import 'package:aandi_tech_blog/aandi_tech_blog.dart' as blog_api;
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/image_upload_payload.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/image_upload_result.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/repositories/image_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/local_auth_datasource.dart';
import 'package:dio/dio.dart';

/// aandi_tech_blog 패키지를 이미지 업로드 Repository 인터페이스에 맞추는 구현체다.
final class ImageRepositoryAdapter implements ImageRepository {
  ImageRepositoryAdapter({
    required blog_api.TechBlogApiClient client,
    required LocalAuthDatasource localAuthDatasource,
  })  : _client = client,
        _localAuthDatasource = localAuthDatasource;

  final blog_api.TechBlogApiClient _client;
  final LocalAuthDatasource _localAuthDatasource;

  @override
  Future<ImageUploadResult> uploadImage({
    required ImageUploadPayload payload,
  }) async {
    final response = await _client.uploadImageV2(
      accessToken: await _resolveAccessToken(),
      file: MultipartFile.fromBytes(
        payload.bytes,
        filename: payload.fileName,
      ),
    );

    return ImageUploadResult(
      url: response.url,
      key: response.key,
      contentType: response.contentType ?? '',
      size: response.size ?? 0,
    );
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
