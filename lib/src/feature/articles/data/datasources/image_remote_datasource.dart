import 'package:a_and_i_report_web_server/src/feature/articles/data/dtos/image_upload_response_dto.dart';
import 'package:aandi_tech_blog/aandi_tech_blog.dart' as blog_api;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// 이미지 업로드 원격 데이터소스입니다.
abstract class ImageRemoteDatasource {
  /// 서버에 이미지를 업로드합니다.
  Future<ImageUploadResponseDto> uploadImage({
    required String authorization,
    required MultipartFile file,
  });
}

/// 이미지 업로드 원격 데이터소스 구현체입니다.
class ImageRemoteDatasourceImpl implements ImageRemoteDatasource {
  /// 이미지 업로드 원격 데이터소스 구현체를 생성합니다.
  ImageRemoteDatasourceImpl(this.dio)
    : _client = blog_api.TechBlogApiClient(
        baseUrl: dio.options.baseUrl,
        dio: dio,
        deviceOs: _resolveDeviceOs(),
      );

  /// HTTP 클라이언트입니다.
  final Dio dio;
  final blog_api.TechBlogApiClient _client;

  @override
  Future<ImageUploadResponseDto> uploadImage({
    required String authorization,
    required MultipartFile file,
  }) async {
    final response = await _client.uploadImageV2(
      accessToken: _extractAccessToken(authorization),
      file: file,
    );

    return ImageUploadResponseDto(
      url: response.url,
      key: response.key,
      contentType: response.contentType ?? '',
      size: response.size ?? 0,
    );
  }

  String _extractAccessToken(String authorization) {
    final normalized = authorization.trim();
    if (normalized.toLowerCase().startsWith('bearer ')) {
      return normalized.substring(7).trim();
    }
    return normalized;
  }

  static String _resolveDeviceOs() {
    if (kIsWeb) {
      return 'web';
    }
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => 'android',
      TargetPlatform.iOS => 'ios',
      TargetPlatform.macOS => 'macos',
      TargetPlatform.windows => 'windows',
      TargetPlatform.linux => 'linux',
      TargetPlatform.fuchsia => 'fuchsia',
    };
  }
}
