import 'package:a_and_i_report_web_server/src/feature/home/data/entities/course.dart';
import 'package:a_and_i_report_web_server/src/feature/home/providers/get_courses_usecase_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_phase_view_model.g.dart';

/// 과정별 카드에서 사용할 코스를 조회합니다.
@riverpod
Future<Course?> coursePhaseViewModel(
  Ref ref, {
  required String phase,
  String? track,
  String? status,
}) async {
  const allowedStatus = <String>{'ACTIVE', 'ARCHIVED'};
  const allowedPhase = <String>{'BASIC', 'CS', 'FRAMEWORK'};
  const allowedTrack = <String>{'NO', 'FL', 'SP'};

  if (!allowedPhase.contains(phase)) {
    throw ArgumentError('지원하지 않는 phase 입니다: $phase');
  }
  if (status != null && !allowedStatus.contains(status)) {
    throw ArgumentError('지원하지 않는 status 입니다: $status');
  }
  if (track != null && !allowedTrack.contains(track)) {
    throw ArgumentError('지원하지 않는 track 입니다: $track');
  }

  final courses = await ref.read(getCoursesUsecaseProvider).call(
        status: status,
        phase: phase,
        track: track,
      );

  if (courses.isEmpty) {
    return null;
  }
  return courses.first;
}
