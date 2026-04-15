import 'package:a_and_i_report_web_server/src/core/constants/api_url.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/auth_token_store_adapter.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/remote/remote_auth_datasource.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/providers/local_auth_datasource_provider.dart';
import 'package:aandi_auth/aandi_auth.dart' as auth_api;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_auth_datasource_provider.g.dart';

@riverpod
RemoteAuthDatasource remoteAuthDatasource(Ref ref) {
  return RemoteAuthDatasource(
    repository: auth_api.AuthRepositoryImpl(
      apiClient: auth_api.AuthApiClient(baseUrl: baseUrl),
      tokenStore: AuthTokenStoreAdapter(
        localAuthDatasource: ref.read(localAuthDatasourceProvider),
      ),
    ),
  );
}
