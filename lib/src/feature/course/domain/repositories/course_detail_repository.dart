import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_assignment.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_detail.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_week.dart';

/// 코스 상세 조회를 위한 리포지토리 인터페이스입니다.
abstract class CourseDetailRepository {
  /// 코스 슬러그로 코스 상세 정보를 조회합니다.
  Future<CourseDetail?> getCourseDetail({
    required String authorization,
    required String courseSlug,
  });

  /// 코스 주차 목록을 조회합니다.
  Future<List<CourseWeek>> getCourseWeeks({
    required String authorization,
    required String courseSlug,
  });

  /// 코스 과제 목록을 조회합니다.
  Future<List<CourseAssignment>> getCourseAssignments({
    required String authorization,
    required String courseSlug,
    int? week,
    int? weekNo,
    String? status,
  });

  /// 주차별 코스 과제 목록을 조회합니다.
  Future<List<CourseAssignment>> getCourseWeekAssignments({
    required String authorization,
    required String courseSlug,
    required int weekNo,
    String? status,
  });
}
