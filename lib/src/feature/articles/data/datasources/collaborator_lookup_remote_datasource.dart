import 'package:a_and_i_report_web_server/src/feature/articles/data/dtos/collaborator_lookup_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// 협업자 조회 원격 데이터소스 인터페이스입니다.
abstract class CollaboratorLookupRemoteDatasource {
  /// 공개 코드로 협업자 정보를 조회합니다.
  Future<CollaboratorLookupResponseDto?> lookupByCode(
    String authorization,
    String code,
  );
}

/// 협업자 조회 원격 데이터소스 구현체입니다.
class CollaboratorLookupRemoteDatasourceImpl
    implements CollaboratorLookupRemoteDatasource {
  /// 협업자 조회 원격 데이터소스 구현체를 생성합니다.
  CollaboratorLookupRemoteDatasourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<CollaboratorLookupResponseDto?> lookupByCode(
    String authorization,
    String code,
  ) async {
    try {
      final response = await _dio.requestUri<Map<String, dynamic>>(
        Uri.parse('${_dio.options.baseUrl}/v2/users/lookup').replace(
          queryParameters: <String, dynamic>{'code': code},
        ),
        options: Options(
          method: 'GET',
          headers: <String, dynamic>{
            'Authenticate': authorization,
            'deviceOS': _resolveDeviceOs(),
            'timestamp': DateTime.now().toIso8601String(),
          },
        ),
      );

      final body = response.data;
      if (body == null) {
        throw Exception('협업자 조회 응답이 비어 있습니다.');
      }

      final data = body['data'];
      if (data is! Map<String, dynamic>) {
        throw Exception('협업자 조회 응답 형식이 올바르지 않습니다.');
      }

      return CollaboratorLookupResponseDto.fromJson(data);
    } on DioException catch (error) {
      if (error.response?.statusCode == 404) {
        return null;
      }
      rethrow;
    }
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
