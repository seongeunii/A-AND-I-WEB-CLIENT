import 'package:aandi_auth/aandi_auth.dart' as auth_api;
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/local_auth_datasource.dart';

/// 루트 앱의 로컬 인증 저장소를 `aandi_auth` 토큰 저장소로 연결한다.
final class AuthTokenStoreAdapter implements auth_api.TokenStore {
  /// 기존 [LocalAuthDatasource]를 감싸는 어댑터를 생성한다.
  const AuthTokenStoreAdapter({
    required LocalAuthDatasource localAuthDatasource,
  }) : _localAuthDatasource = localAuthDatasource;

  final LocalAuthDatasource _localAuthDatasource;

  @override
  Future<void> save(auth_api.AuthTokens tokens) async {
    await _localAuthDatasource.saveUserToken(tokens.accessToken);

    final refreshToken = tokens.refreshToken;
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _localAuthDatasource.saveRefreshToken(refreshToken);
    }
  }

  @override
  Future<auth_api.AuthTokens?> read() async {
    final accessToken = await _localAuthDatasource.getUserToken();
    final refreshToken = await _localAuthDatasource.getRefreshToken();

    final normalizedAccessToken = accessToken?.trim();
    if (normalizedAccessToken == null || normalizedAccessToken.isEmpty) {
      return null;
    }

    return auth_api.AuthTokens(
      accessToken: normalizedAccessToken,
      refreshToken: refreshToken?.trim(),
      expiresIn: 0,
      tokenType: 'Bearer',
    );
  }

  @override
  Future<void> clear() async {
    await _localAuthDatasource.deleteUserToken();
    await _localAuthDatasource.deleteRefreshToken();
  }
}
