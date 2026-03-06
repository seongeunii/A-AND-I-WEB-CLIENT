import 'package:a_and_i_report_web_server/src/feature/course/data/dtos/course_detail_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/course/data/mappers/course_detail_mapper.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_detail.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/repositories/course_detail_repository.dart';
import 'package:dio/dio.dart';

/// 코스 상세 조회 리포지토리 구현체입니다.
final class CourseDetailRepositoryImpl implements CourseDetailRepository {
  final Dio dio;

  const CourseDetailRepositoryImpl({required this.dio});

  @override
  Future<CourseDetail?> getCourseDetail({
    required String authorization,
    required String courseSlug,
  }) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '/v1/course/$courseSlug',
        options: Options(headers: {'Authorization': authorization}),
      );

      final data = response.data;
      if (data == null) {
        return null;
      }

      // API가 envelope(success/data/error) 형식인 경우
      if (data.containsKey('success')) {
        final envelope = CourseDetailResponseDto.fromJson(data);
        if (!envelope.success) {
          throw Exception(envelope.error?.message ?? '코스 조회에 실패했습니다.');
        }
        return envelope.data?.toEntity();
      }

      // API가 코스 객체를 직접 반환하는 경우
      return CourseDetailDto.fromJson(data).toEntity();
    } on DioException catch (e) {
      final errorData = e.response?.data;
      if (errorData is Map<String, dynamic>) {
        if (errorData.containsKey('error')) {
          final envelope = CourseDetailResponseDto.fromJson(errorData);
          final message = envelope.error?.message;
          if (message != null && message.isNotEmpty) {
            throw Exception(message);
          }
        }

        final message = errorData['message'];
        if (message is String && message.isNotEmpty) {
          throw Exception(message);
        }
      }

      throw Exception('코스 조회에 실패했습니다. (status: ${e.response?.statusCode})');
    }
  }
}
