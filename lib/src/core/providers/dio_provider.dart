import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:a_and_i_report_web_server/src/core/constants/api_url.dart';
import 'package:a_and_i_report_web_server/src/core/interceptors/auth_interceptor.dart';
import 'package:a_and_i_report_web_server/src/core/interceptors/request_id_interceptor.dart';
import 'package:a_and_i_report_web_server/src/core/utils/app_messenger.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/providers/local_auth_datasource_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/auth_view_model.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/user_view_model.dart';

part 'dio_provider.g.dart';

/// HTTP 통신을 위한 [Dio] 인스턴스를 제공하는 Provider입니다.
///
/// 애플리케이션 전반에서 API 호출 시 이 Provider를 통해 Dio 클라이언트를 주입받아 사용합니다.
/// 필요한 경우 Interceptor나 기본 옵션(BaseOptions)을 이곳에서 설정할 수 있습니다.
@riverpod
Dio dio(Ref ref) {
  final localAuthDatasource = ref.read(localAuthDatasourceProvider);
  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
  ));

  dio.interceptors.add(RequestIdInterceptor());

  dio.interceptors.add(
    AuthInterceptor(
      localAuthDatasource: localAuthDatasource,
      dio: dio,
      onTokenExpired: (refreshToken) async {
        if (refreshToken != null && refreshToken.isNotEmpty) {
          try {
            await dio.post(
              '/v1/auth/logout',
              data: {'refreshToken': refreshToken},
              options: Options(
                headers: {'Content-Type': 'application/json'},
              ),
            );
          } catch (_) {
            // 서버 로그아웃 실패여도 로컬 세션은 정리한다.
          }
        }

        await localAuthDatasource.deleteUserToken();
        await localAuthDatasource.deleteRefreshToken();
        await localAuthDatasource.deleteCachedUserJson();

        ref.invalidate(authViewModelProvider);
        ref.invalidate(userViewModelProvider);
        showGlobalSnackBar('세션이 만료되어 로그아웃되었습니다. 다시 로그인해주세요.');
      },
    ),
  );

  return dio;
}
