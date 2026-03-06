import 'package:a_and_i_report_web_server/src/feature/auth/providers/auth_repository_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/course/domain/usecases/get_course_detail_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/course/providers/course_detail_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_course_detail_usecase_provider.g.dart';

/// 코스 상세 조회 유스케이스를 제공합니다.
@riverpod
GetCourseDetailUsecase getCourseDetailUsecase(Ref ref) {
  return GetCourseDetailUsecaseImpl(
    courseDetailRepository: ref.read(courseDetailRepositoryProvider),
    authRepository: ref.read(authRepositoryProvider),
  );
}
