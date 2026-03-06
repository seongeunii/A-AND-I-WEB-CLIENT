import 'package:a_and_i_report_web_server/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_assignment.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/repositories/course_detail_repository.dart';

/// 코스 주차별 과제 목록 조회 유스케이스 인터페이스입니다.
abstract class GetCourseWeekAssignmentsUsecase {
  Future<List<CourseAssignment>> call({
    required String courseSlug,
    required int weekNo,
    String? status,
  });
}

/// 코스 주차별 과제 목록 조회 유스케이스 구현체입니다.
final class GetCourseWeekAssignmentsUsecaseImpl
    implements GetCourseWeekAssignmentsUsecase {
  final CourseDetailRepository courseDetailRepository;
  final AuthRepository authRepository;

  const GetCourseWeekAssignmentsUsecaseImpl({
    required this.courseDetailRepository,
    required this.authRepository,
  });

  @override
  Future<List<CourseAssignment>> call({
    required String courseSlug,
    required int weekNo,
    String? status,
  }) async {
    final token = await authRepository.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('인증되지 않은 사용자입니다. 로그인이 필요합니다.');
    }

    return courseDetailRepository.getCourseWeekAssignments(
      authorization: 'Bearer $token',
      courseSlug: courseSlug,
      weekNo: weekNo,
      status: status,
    );
  }
}
