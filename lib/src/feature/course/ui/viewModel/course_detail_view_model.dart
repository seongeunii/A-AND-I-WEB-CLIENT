import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_detail.dart';
import 'package:a_and_i_report_web_server/src/feature/course/providers/get_course_detail_usecase_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_detail_view_model.g.dart';

/// 코스 슬러그 기반으로 상세 정보를 조회하는 ViewModel입니다.
@riverpod
Future<CourseDetail?> courseDetailViewModel(Ref ref, String courseSlug) async {
  final normalizedSlug = courseSlug.trim();
  if (normalizedSlug.isEmpty) {
    return null;
  }

  return ref.read(getCourseDetailUsecaseProvider).call(normalizedSlug);
}
