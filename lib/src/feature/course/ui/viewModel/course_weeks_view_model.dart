import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_week.dart';
import 'package:a_and_i_report_web_server/src/feature/course/providers/get_course_weeks_usecase_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_weeks_view_model.g.dart';

/// 코스 슬러그 기반 주차 목록 조회 ViewModel입니다.
@riverpod
Future<List<CourseWeek>> courseWeeksViewModel(
    Ref ref, String courseSlug) async {
  final normalizedSlug = courseSlug.trim();
  if (normalizedSlug.isEmpty) {
    return const <CourseWeek>[];
  }

  return ref.read(getCourseWeeksUsecaseProvider).call(normalizedSlug);
}
