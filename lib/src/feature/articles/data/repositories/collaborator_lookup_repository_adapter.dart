import 'package:aandi_auth/aandi_auth.dart' as auth_api;
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/collaborator_lookup_user.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/repositories/collaborator_lookup_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/local_auth_datasource.dart';

/// aandi_auth 패키지를 협업자 조회 Repository 인터페이스에 맞추는 구현체다.
final class CollaboratorLookupRepositoryAdapter
    implements CollaboratorLookupRepository {
  CollaboratorLookupRepositoryAdapter({
    required auth_api.AuthRepository repository,
    required LocalAuthDatasource localAuthDatasource,
  })  : _repository = repository,
        _localAuthDatasource = localAuthDatasource;

  final auth_api.AuthRepository _repository;
  final LocalAuthDatasource _localAuthDatasource;

  @override
  Future<CollaboratorLookupUser?> lookupByCode({
    required String code,
  }) async {
    final normalizedCode = code.trim();
    if (normalizedCode.isEmpty) {
      return null;
    }

    try {
      final _ = await _resolveAccessToken();
      final response = await _repository.lookupUserByPublicCodeV2(
        code: normalizedCode,
      );

      final nickname = response.nickname?.trim().isNotEmpty == true
          ? response.nickname!.trim()
          : response.username;

      return CollaboratorLookupUser(
        id: response.id,
        nickname: nickname,
        profileImageUrl: response.profileImageUrl,
        publicCode: response.publicCode,
      );
    } on auth_api.AuthApiException catch (error) {
      if (error.statusCode == 404) {
        return null;
      }
      rethrow;
    }
  }

  Future<String> _resolveAccessToken() async {
    final token = await _localAuthDatasource.getUserToken();
    final normalizedToken = token?.trim();
    if (normalizedToken == null || normalizedToken.isEmpty) {
      throw Exception('로그인이 필요합니다.');
    }
    if (normalizedToken.toLowerCase().startsWith('bearer ')) {
      return normalizedToken.substring('Bearer '.length).trim();
    }
    return normalizedToken;
  }
}
