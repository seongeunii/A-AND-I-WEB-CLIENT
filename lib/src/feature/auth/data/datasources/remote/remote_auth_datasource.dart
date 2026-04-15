import 'package:aandi_auth/aandi_auth.dart' as auth_api;
import 'package:a_and_i_report_web_server/src/core/models/user.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/dtos/login_request_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/dtos/login_response_dto.dart';

/// 인증 관련 원격 데이터소스다.
class RemoteAuthDatasource {
  /// v2 인증 API 클라이언트를 주입받아 생성한다.
  RemoteAuthDatasource({
    required auth_api.AuthRepository repository,
  }) : _repository = repository;

  final auth_api.AuthRepository _repository;

  /// `/v2/auth/login` 로그인 API를 호출한다.
  Future<LoginResponseDto> login(LoginRequestDto dto) async {
    final response = await _repository.loginV2(
      username: dto.username,
      password: dto.password,
    );

    return LoginResponseDto(
      success: true,
      data: LoginDataDto(
        accessToken: response.tokens.accessToken,
        refreshToken: response.tokens.refreshToken ?? '',
        expiresIn: response.tokens.expiresIn,
        tokenType: response.tokens.tokenType ?? 'Bearer',
        forcePasswordChange: response.forcePasswordChange,
        user: LoginUserDto(
          id: response.user.id,
          username: response.user.username,
          role: response.user.role.toApi(),
        ),
      ),
      error: null,
      timestamp: null,
    );
  }

  /// `/v2/me` 내 정보 조회 API를 호출한다.
  Future<User> getMyInfo(String accessToken) async {
    final _ = accessToken;
    final response = await _repository.meV2();
    return User(
      id: response.id,
      nickname: _resolveNickname(
        nickname: response.nickname,
        username: response.username,
      ),
      role: response.role.toApi(),
      profileImageUrl: response.profileImageUrl,
      publicCode: response.publicCode,
    );
  }
}

String _resolveNickname({
  required String? nickname,
  required String username,
}) {
  final trimmedNickname = nickname?.trim();
  if (trimmedNickname != null && trimmedNickname.isNotEmpty) {
    return trimmedNickname;
  }

  final trimmedUsername = username.trim();
  if (trimmedUsername.isNotEmpty) {
    return trimmedUsername;
  }

  return '동아리원';
}
