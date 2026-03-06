import 'package:a_and_i_report_web_server/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/course.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/repositories/course_repository.dart';

/// 관리자용 전체 코스 목록 조회 유스케이스 인터페이스입니다.
abstract class GetAdminCoursesUsecase {
  Future<List<Course>> call();
}

/// 관리자용 전체 코스 목록 조회 유스케이스 구현체입니다.
final class GetAdminCoursesUsecaseImpl implements GetAdminCoursesUsecase {
  final CourseRepository courseRepository;
  final AuthRepository authRepository;

  const GetAdminCoursesUsecaseImpl({
    required this.courseRepository,
    required this.authRepository,
  });

  @override
  Future<List<Course>> call() async {
    final token = await authRepository.getToken();

    if (token == null || token.isEmpty) {
      throw Exception('인증되지 않은 사용자입니다. 로그인이 필요합니다.');
    }

    return courseRepository.getAdminCourses('Bearer $token');
  }
}
