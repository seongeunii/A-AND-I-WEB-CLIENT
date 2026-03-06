import 'package:a_and_i_report_web_server/src/core/network/v1_response_parser.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/course.dart';
import 'package:dio/dio.dart';

/// 코스 관련 API를 호출하는 리포지토리입니다.
abstract class CourseRepository {
  /// 일반 사용자 코스 목록을 조회합니다.
  Future<List<Course>> getCourses(String authorization);

  /// 코스 슬러그로 단건 조회합니다.
  Future<Course> getCourseBySlug(String authorization, String courseSlug);

  /// 코스 슬러그를 복수형 경로로 단건 조회합니다.
  Future<Course> getCourseBySlugFromCourses(
    String authorization,
    String courseSlug,
  );

  /// 관리자용 전체 코스 목록을 조회합니다.
  Future<List<Course>> getAdminCourses(String authorization);
}

/// [CourseRepository] 구현체입니다.
final class CourseRepositoryImpl implements CourseRepository {
  final Dio dio;

  const CourseRepositoryImpl({required this.dio});

  @override
  Future<List<Course>> getCourses(String authorization) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/v1/courses',
      options: Options(headers: {'Authorization': authorization}),
    );

    final data = response.data;
    if (data == null) {
      return const <Course>[];
    }

    return V1ResponseParser.parseList(data, Course.fromJson);
  }

  @override
  Future<Course> getCourseBySlug(
      String authorization, String courseSlug) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/v1/course/$courseSlug',
      options: Options(headers: {'Authorization': authorization}),
    );

    final data = response.data;
    if (data == null) {
      throw Exception('코스 상세 응답이 비어있습니다.');
    }

    return V1ResponseParser.parseObject(data, Course.fromJson);
  }

  @override
  Future<Course> getCourseBySlugFromCourses(
    String authorization,
    String courseSlug,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/v1/courses/$courseSlug',
      options: Options(headers: {'Authorization': authorization}),
    );

    final data = response.data;
    if (data == null) {
      throw Exception('코스 상세 응답이 비어있습니다.');
    }

    return V1ResponseParser.parseObject(data, Course.fromJson);
  }

  @override
  Future<List<Course>> getAdminCourses(String authorization) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/v1/admin/courses',
      options: Options(headers: {'Authorization': authorization}),
    );

    final data = response.data;
    if (data == null) {
      return const <Course>[];
    }

    return V1ResponseParser.parseList(data, Course.fromJson);
  }
}
