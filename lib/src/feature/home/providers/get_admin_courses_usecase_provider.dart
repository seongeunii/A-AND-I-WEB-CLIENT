import 'package:a_and_i_report_web_server/src/feature/auth/providers/auth_repository_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/home/domain/usecases/get_admin_courses_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/home/providers/course_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_admin_courses_usecase_provider.g.dart';

/// 관리자용 코스 목록 조회 유스케이스 Provider입니다.
@riverpod
GetAdminCoursesUsecase getAdminCoursesUsecase(Ref ref) {
  return GetAdminCoursesUsecaseImpl(
    courseRepository: ref.read(courseRepositoryProvider),
    authRepository: ref.read(authRepositoryProvider),
  );
}
