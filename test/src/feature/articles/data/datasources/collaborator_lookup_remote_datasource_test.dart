import 'package:a_and_i_report_web_server/src/feature/articles/data/datasources/collaborator_lookup_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CollaboratorLookupRemoteDatasourceImpl', () {
    test('lookupByCode는 /v2/users/lookup에 code 쿼리와 인증 헤더로 요청한다', () async {
      RequestOptions? capturedOptions;

      final dio = Dio()
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              capturedOptions = options;
              handler.resolve(
                Response<Map<String, dynamic>>(
                  requestOptions: options,
                  statusCode: 200,
                  data: <String, dynamic>{
                    'success': true,
                    'data': <String, dynamic>{
                      'id': '09856e0d-c5be-43d7-ba45-e957d503aa15',
                      'username': 'qazws78941',
                      'role': 'ORGANIZER',
                      'publicCode': '#OR009',
                      'nickname': '한상욱',
                      'profileImageUrl': 'https://example.com/profile.webp',
                    },
                    'error': null,
                  },
                ),
              );
            },
          ),
        );

      final datasource = CollaboratorLookupRemoteDatasourceImpl(dio);
      final result =
          await datasource.lookupByCode('Bearer access-token', '#OR009');

      expect(capturedOptions, isNotNull);
      expect(capturedOptions!.path, contains('/v2/users/lookup'));
      expect(capturedOptions!.method, 'GET');
      expect(capturedOptions!.queryParameters, <String, dynamic>{
        'code': '#OR009',
      });
      expect(capturedOptions!.headers['Authenticate'], 'Bearer access-token');
      expect(capturedOptions!.headers['deviceOS'], isNotNull);
      expect(capturedOptions!.headers['timestamp'], isNotNull);

      expect(result, isNotNull);
      expect(result!.id, '09856e0d-c5be-43d7-ba45-e957d503aa15');
      expect(result.nickname, '한상욱');
      expect(result.publicCode, '#OR009');
      expect(result.profileImageUrl, 'https://example.com/profile.webp');
    });

    test('lookupByCode는 404 응답이면 null을 반환한다', () async {
      final dio = Dio()
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              handler.reject(
                DioException(
                  requestOptions: options,
                  response: Response<Map<String, dynamic>>(
                    requestOptions: options,
                    statusCode: 404,
                    data: <String, dynamic>{
                      'success': false,
                      'data': null,
                      'error': <String, dynamic>{
                        'code': 'USER_NOT_FOUND',
                      },
                    },
                  ),
                  type: DioExceptionType.badResponse,
                ),
              );
            },
          ),
        );

      final datasource = CollaboratorLookupRemoteDatasourceImpl(dio);
      final result =
          await datasource.lookupByCode('Bearer access-token', '#NOPE');

      expect(result, isNull);
    });
  });
}
