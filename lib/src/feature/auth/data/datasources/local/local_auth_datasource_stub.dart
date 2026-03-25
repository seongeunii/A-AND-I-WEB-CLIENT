import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/local_auth_datasource.dart';

/// 비웹 환경에서 사용하는 메모리 기반 로컬 인증 데이터소스입니다.
final class LocalAuthDatasourceImpl implements LocalAuthDatasource {
  String? _accessToken;
  String? _refreshToken;
  String? _cachedUserJson;

  @override
  Future<void> deleteCachedUserJson() async {
    _cachedUserJson = null;
  }

  @override
  Future<void> deleteRefreshToken() async {
    _refreshToken = null;
  }

  @override
  Future<void> deleteUserToken() async {
    _accessToken = null;
  }

  @override
  Future<String?> getCachedUserJson() async {
    return _cachedUserJson;
  }

  @override
  Future<String?> getRefreshToken() async {
    return _refreshToken;
  }

  @override
  Future<String?> getUserToken() async {
    return _accessToken;
  }

  @override
  Future<void> saveCachedUserJson(String userJson) async {
    _cachedUserJson = userJson;
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    _refreshToken = token;
  }

  @override
  Future<void> saveUserToken(String token) async {
    _accessToken = token;
  }
}
