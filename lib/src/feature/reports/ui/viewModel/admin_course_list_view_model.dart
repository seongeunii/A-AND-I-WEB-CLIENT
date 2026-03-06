import 'package:a_and_i_report_web_server/src/feature/home/data/entities/course.dart';
import 'package:a_and_i_report_web_server/src/feature/home/providers/get_admin_courses_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_course_list_view_model.g.dart';

/// 관리자용 전체 코스 목록을 조회하는 ViewModel입니다.
@riverpod
class AdminCourseListViewModel extends _$AdminCourseListViewModel {
  @override
  Future<List<Course>> build() async {
    return ref.read(getAdminCoursesUsecaseProvider).call();
  }
}
