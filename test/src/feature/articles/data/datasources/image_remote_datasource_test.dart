import 'package:a_and_i_report_web_server/src/feature/articles/data/datasources/image_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ImageRemoteDatasourceImpl', () {
    test('uploadImage는 data 래퍼 payload를 파싱한다', () async {
      RequestOptions? capturedOptions;

      final dio = Dio()
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              capturedOptions = options;
              handler.resolve(
                Response<Map<String, dynamic>>(
                  requestOptions: options,
                  statusCode: 201,
                  data: <String, dynamic>{
                    'success': true,
                    'data': <String, dynamic>{
                      'url': 'https://cdn.example.com/sample.png',
                      'key': 'posts/sample.png',
                      'contentType': 'image/png',
                      'size': 4,
                    },
                    'error': null,
                  },
                ),
              );
            },
          ),
        );

      final datasource = ImageRemoteDatasourceImpl(dio);
      final result = await datasource.uploadImage(
        authorization: 'Bearer access-token',
        file: MultipartFile.fromBytes(
          <int>[1, 2, 3, 4],
          filename: 'sample.png',
        ),
      );

      expect(capturedOptions, isNotNull);
      expect(capturedOptions!.path, '/v1/posts/images');
      expect(capturedOptions!.method, 'POST');
      expect(capturedOptions!.headers['Authorization'], 'Bearer access-token');

      expect(result.url, 'https://cdn.example.com/sample.png');
      expect(result.key, 'posts/sample.png');
      expect(result.contentType, 'image/png');
      expect(result.size, 4);
    });

    test('uploadImage는 data 래퍼가 없는 응답도 파싱한다', () async {
      final dio = Dio()
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              handler.resolve(
                Response<Map<String, dynamic>>(
                  requestOptions: options,
                  statusCode: 201,
                  data: <String, dynamic>{
                    'url': 'https://cdn.example.com/no-wrapper.png',
                    'key': 'posts/no-wrapper.png',
                    'contentType': 'image/png',
                    'size': 10,
                  },
                ),
              );
            },
          ),
        );

      final datasource = ImageRemoteDatasourceImpl(dio);
      final result = await datasource.uploadImage(
        authorization: 'Bearer access-token',
        file: MultipartFile.fromBytes(
          <int>[1, 2, 3, 4],
          filename: 'sample.png',
        ),
      );

      expect(result.url, 'https://cdn.example.com/no-wrapper.png');
      expect(result.key, 'posts/no-wrapper.png');
      expect(result.contentType, 'image/png');
      expect(result.size, 10);
    });
  });
}
