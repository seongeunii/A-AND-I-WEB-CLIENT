import 'package:a_and_i_report_web_server/src/feature/articles/data/dtos/image_upload_response_dto.dart';
import 'package:dio/dio.dart';

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
  const ImageRemoteDatasourceImpl(this.dio);

  /// HTTP 클라이언트입니다.
  final Dio dio;

  @override
  Future<ImageUploadResponseDto> uploadImage({
    required String authorization,
    required MultipartFile file,
  }) async {
    final formData = FormData.fromMap(<String, dynamic>{
      'file': file,
    });

    final response = await dio.post<Map<String, dynamic>>(
      '/v1/posts/images',
      data: formData,
      options: Options(
        headers: <String, dynamic>{
          'Authorization': authorization,
        },
      ),
    );

    final responseData = response.data ?? <String, dynamic>{};
    return ImageUploadResponseDto.fromJson(_extractPayload(responseData));
  }

  Map<String, dynamic> _extractPayload(Map<String, dynamic> responseData) {
    final data = responseData['data'];
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return responseData;
  }
}
