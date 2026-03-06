import 'package:a_and_i_report_web_server/src/core/network/api_exception.dart';
import 'package:a_and_i_report_web_server/src/core/network/v1_response_parser.dart';
import 'package:a_and_i_report_web_server/src/feature/course/data/dtos/course_assignment_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/course/data/dtos/course_detail_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/course/data/dtos/course_week_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/course/data/mappers/course_detail_mapper.dart';
import 'package:a_and_i_report_web_server/src/feature/course/data/mappers/course_query_mapper.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_assignment.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_detail.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_week.dart';
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
        '/v1/courses/$courseSlug',
        options: Options(headers: {'Authorization': authorization}),
      );

      final data = response.data;
      if (data == null) {
        throw ApiException(
          code: 'INVALID_ENVELOPE',
          message: '코스 상세 응답이 비어있습니다.',
          status: response.statusCode,
          requestId: _requestIdFromResponse(response),
        );
      }

      final dto = V1ResponseParser.parseObject(
        data,
        CourseDetailDto.fromJson,
        status: response.statusCode,
        requestId: _requestIdFromResponse(response),
      );
      return dto.toEntity();
    } on DioException catch (e) {
      final apiException = e.error;
      if (apiException is ApiException) {
        throw apiException;
      }

      throw ApiException.fromDio(
        e,
        fallbackMessage: '코스 조회에 실패했습니다.',
      );
    }
  }

  @override
  Future<List<CourseWeek>> getCourseWeeks({
    required String authorization,
    required String courseSlug,
  }) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/v1/courses/$courseSlug/weeks',
      options: Options(headers: {'Authorization': authorization}),
    );

    final data = response.data;
    if (data == null) {
      throw ApiException(
        code: 'INVALID_ENVELOPE',
        message: '코스 주차 목록 응답이 비어있습니다.',
        status: response.statusCode,
        requestId: _requestIdFromResponse(response),
      );
    }

    final weekDtos = V1ResponseParser.parseList(
      data,
      CourseWeekDto.fromJson,
      status: response.statusCode,
      requestId: _requestIdFromResponse(response),
    );

    return weekDtos.map((dto) => dto.toEntity()).toList(growable: false);
  }

  @override
  Future<List<CourseAssignment>> getCourseAssignments({
    required String authorization,
    required String courseSlug,
    int? week,
    int? weekNo,
    String? status,
  }) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/v1/courses/$courseSlug/assignments',
      queryParameters: <String, dynamic>{
        if (week != null) 'week': week,
        if (weekNo != null) 'weekNo': weekNo,
        if (status != null && status.isNotEmpty) 'status': status,
      },
      options: Options(headers: {'Authorization': authorization}),
    );

    final data = response.data;
    if (data == null) {
      throw ApiException(
        code: 'INVALID_ENVELOPE',
        message: '코스 과제 목록 응답이 비어있습니다.',
        status: response.statusCode,
        requestId: _requestIdFromResponse(response),
      );
    }

    final assignmentDtos = V1ResponseParser.parseList(
      data,
      CourseAssignmentDto.fromJson,
      status: response.statusCode,
      requestId: _requestIdFromResponse(response),
    );

    return assignmentDtos.map((dto) => dto.toEntity()).toList(growable: false);
  }

  @override
  Future<List<CourseAssignment>> getCourseWeekAssignments({
    required String authorization,
    required String courseSlug,
    required int weekNo,
    String? status,
  }) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/v1/courses/$courseSlug/weeks/$weekNo/assignments',
      queryParameters: <String, dynamic>{
        if (status != null && status.isNotEmpty) 'status': status,
      },
      options: Options(headers: {'Authorization': authorization}),
    );

    final data = response.data;
    if (data == null) {
      throw ApiException(
        code: 'INVALID_ENVELOPE',
        message: '주차별 과제 목록 응답이 비어있습니다.',
        status: response.statusCode,
        requestId: _requestIdFromResponse(response),
      );
    }

    final assignmentDtos = V1ResponseParser.parseList(
      data,
      CourseAssignmentDto.fromJson,
      status: response.statusCode,
      requestId: _requestIdFromResponse(response),
    );

    return assignmentDtos.map((dto) => dto.toEntity()).toList(growable: false);
  }

  String _requestIdFromResponse(Response<Map<String, dynamic>> response) {
    return response.headers.value('x-request-id') ??
        response.requestOptions.extra['requestId']?.toString() ??
        '';
  }
}
