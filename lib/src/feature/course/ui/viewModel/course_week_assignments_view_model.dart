import 'package:a_and_i_report_web_server/src/feature/course/domain/entities/course_assignment.dart';
import 'package:a_and_i_report_web_server/src/feature/course/providers/get_course_week_assignments_usecase_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_week_assignments_view_model.g.dart';

/// 코스 주차별 과제 목록 조회 조건 모델입니다.
class CourseWeekAssignmentsQuery {
  final String courseSlug;
  final int weekNo;
  final String? status;

  const CourseWeekAssignmentsQuery({
    required this.courseSlug,
    required this.weekNo,
    this.status,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CourseWeekAssignmentsQuery &&
            runtimeType == other.runtimeType &&
            courseSlug == other.courseSlug &&
            weekNo == other.weekNo &&
            status == other.status;
  }

  @override
  int get hashCode => Object.hash(courseSlug, weekNo, status);
}

/// 코스 주차별 과제 목록 조회 ViewModel입니다.
@riverpod
Future<List<CourseAssignment>> courseWeekAssignmentsViewModel(
  Ref ref,
  CourseWeekAssignmentsQuery query,
) async {
  final normalizedSlug = query.courseSlug.trim();
  if (normalizedSlug.isEmpty) {
    return const <CourseAssignment>[];
  }

  return ref.read(getCourseWeekAssignmentsUsecaseProvider).call(
        courseSlug: normalizedSlug,
        weekNo: query.weekNo,
        status: query.status,
      );
}
