import 'dart:convert';

import 'package:a_and_i_report_web_server/src/feature/articles/data/datasources/post_remote_datasource.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_author.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostRemoteDatasourceImpl', () {
    test('createPost는 post(json)와 thumbnail 파트를 multipart로 전송한다', () async {
      FormData? capturedFormData;
      RequestOptions? capturedOptions;

      final dio = Dio()
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              capturedOptions = options;
              capturedFormData = options.data as FormData;
              handler.resolve(
                Response<Map<String, dynamic>>(
                  requestOptions: options,
                  statusCode: 201,
                  data: _responseJson(),
                ),
              );
            },
          ),
        );

      final datasource = PostRemoteDatasourceImpl(dio);
      final thumbnail = MultipartFile.fromBytes(
        <int>[1, 2, 3],
        filename: 'thumbnail.webp',
        contentType: DioMediaType.parse('image/webp'),
      );

      await datasource.createPost(
        'Bearer access-token',
        '제목',
        '본문',
        PostType.blog,
        '요약',
        '11111111-1111-1111-1111-111111111111',
        '멘토',
        'https://example.com/profile.png',
        'Published',
        const <PostAuthor>[
          PostAuthor(
            id: '22222222-2222-2222-2222-222222222222',
            nickname: '공동작업자',
            profileImage: 'https://example.com/collaborator.png',
          ),
        ],
        thumbnail,
      );

      expect(capturedOptions, isNotNull);
      expect(capturedOptions!.path, '/v1/posts');
      expect(capturedOptions!.method, 'POST');
      expect(capturedOptions!.headers['Authorization'], 'Bearer access-token');

      final files = capturedFormData!.files;
      final postPart = files.firstWhere((entry) => entry.key == 'post').value;
      final thumbnailPart =
          files.firstWhere((entry) => entry.key == 'thumbnail').value;

      expect(postPart.filename, 'post.json');
      expect(postPart.contentType?.mimeType, 'application/json');
      expect(
        jsonDecode(await _readMultipartAsString(postPart)),
        <String, dynamic>{
          'type': 'Blog',
          'title': '제목',
          'contentMarkdown': '본문',
          'summary': '요약',
          'author': <String, dynamic>{
            'id': '11111111-1111-1111-1111-111111111111',
            'nickname': '멘토',
            'profileImageUrl': 'https://example.com/profile.png',
          },
          'collaborators': <Map<String, dynamic>>[
            <String, dynamic>{
              'id': '22222222-2222-2222-2222-222222222222',
              'nickname': '공동작업자',
              'profileImageUrl': 'https://example.com/collaborator.png',
            },
          ],
          'status': 'Published',
        },
      );

      expect(thumbnailPart.filename, 'thumbnail.webp');
      expect(thumbnailPart.contentType?.mimeType, 'image/webp');
    });

    test('patchPost는 post(json) 파트를 multipart로 전송한다', () async {
      FormData? capturedFormData;
      RequestOptions? capturedOptions;

      final dio = Dio()
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              capturedOptions = options;
              capturedFormData = options.data as FormData;
              handler.resolve(
                Response<Map<String, dynamic>>(
                  requestOptions: options,
                  statusCode: 200,
                  data: _responseJson(),
                ),
              );
            },
          ),
        );

      final datasource = PostRemoteDatasourceImpl(dio);

      await datasource.patchPost(
        'Bearer access-token',
        'post-id',
        null,
        '수정 제목',
        '수정 본문',
        '수정 요약',
        'Draft',
        const <PostAuthor>[],
        null,
      );

      expect(capturedOptions, isNotNull);
      expect(capturedOptions!.path, '/v1/posts/post-id');
      expect(capturedOptions!.method, 'PATCH');
      expect(capturedOptions!.headers['Authorization'], 'Bearer access-token');

      final files = capturedFormData!.files;
      final postPart = files.firstWhere((entry) => entry.key == 'post').value;
      expect(postPart.filename, 'post.json');
      expect(postPart.contentType?.mimeType, 'application/json');
      expect(
        jsonDecode(await _readMultipartAsString(postPart)),
        <String, dynamic>{
          'title': '수정 제목',
          'contentMarkdown': '수정 본문',
          'summary': '수정 요약',
          'status': 'Draft',
        },
      );
      expect(files.any((entry) => entry.key == 'thumbnail'), isFalse);
    });

    test('patchPost는 빈 summary도 post(json)에 포함한다', () async {
      FormData? capturedFormData;

      final dio = Dio()
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              capturedFormData = options.data as FormData;
              handler.resolve(
                Response<Map<String, dynamic>>(
                  requestOptions: options,
                  statusCode: 200,
                  data: _responseJson(),
                ),
              );
            },
          ),
        );

      final datasource = PostRemoteDatasourceImpl(dio);
      await datasource.patchPost(
        'Bearer access-token',
        'post-id',
        null,
        '수정 제목',
        '수정 본문',
        '',
        'Draft',
        const <PostAuthor>[],
        null,
      );

      final files = capturedFormData!.files;
      final postPart = files.firstWhere((entry) => entry.key == 'post').value;
      final payload = jsonDecode(await _readMultipartAsString(postPart))
          as Map<String, dynamic>;
      expect(payload.containsKey('summary'), isTrue);
      expect(payload['summary'], '');
    });

    test('getDraftPosts는 /v1/posts/drafts/me 경로와 인증 헤더로 조회한다', () async {
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
                      'items': <Map<String, dynamic>>[],
                      'page': 0,
                      'size': 20,
                      'totalElements': 0,
                      'totalPages': 0,
                    },
                    'error': null,
                  },
                ),
              );
            },
          ),
        );

      final datasource = PostRemoteDatasourceImpl(dio);
      await datasource.getDraftPosts('Bearer access-token', 0, 20, null);

      expect(capturedOptions, isNotNull);
      expect(capturedOptions!.path, '/v1/posts/drafts/me');
      expect(capturedOptions!.method, 'GET');
      expect(capturedOptions!.headers['Authorization'], 'Bearer access-token');
      expect(capturedOptions!.queryParameters, <String, dynamic>{
        'page': 0,
        'size': 20,
      });
    });
  });
}

Map<String, dynamic> _responseJson() {
  return <String, dynamic>{
    'success': true,
    'data': <String, dynamic>{
      'id': 'post-id',
      'title': '제목',
      'contentMarkdown': '본문',
      'summary': '요약',
      'thumbnailUrl': 'https://example.com/thumbnail.webp',
      'author': <String, dynamic>{
        'id': '11111111-1111-1111-1111-111111111111',
        'nickname': '멘토',
        'profileImage': 'https://example.com/profile.png',
      },
      'collaborators': <Map<String, dynamic>>[
        <String, dynamic>{
          'id': '22222222-2222-2222-2222-222222222222',
          'nickname': '공동작업자',
          'profileImageUrl': 'https://example.com/collaborator.png',
        },
      ],
      'status': 'Published',
      'createdAt': DateTime.utc(2026, 1, 1).toIso8601String(),
      'updatedAt': DateTime.utc(2026, 1, 1).toIso8601String(),
    },
    'error': null,
  };
}

Future<String> _readMultipartAsString(MultipartFile file) async {
  final bytes = await file.finalize().fold<List<int>>(
    <int>[],
    (acc, chunk) => acc..addAll(chunk),
  );
  return utf8.decode(bytes);
}
