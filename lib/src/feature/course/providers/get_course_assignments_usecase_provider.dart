import 'package:a_and_i_report_web_server/src/feature/auth/providers/auth_repository_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/usecases/get_course_assignments_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/course/providers/course_detail_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_course_assignments_usecase_provider.g.dart';

/// 코스 과제 목록 조회 유스케이스 Provider입니다.
@riverpod
GetCourseAssignmentsUsecase getCourseAssignmentsUsecase(Ref ref) {
  return GetCourseAssignmentsUsecaseImpl(
    courseDetailRepository: ref.read(courseDetailRepositoryProvider),
    authRepository: ref.read(authRepositoryProvider),
  );
}
