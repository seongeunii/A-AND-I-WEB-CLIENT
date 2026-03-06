import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_filter_view_model.g.dart';

/// 코스 목록 조회 필터 상태입니다.
class CourseFilterState {
  final String? status;
  final String? phase;
  final String? track;

  const CourseFilterState({
    this.status,
    this.phase,
    this.track,
  });

  CourseFilterState copyWith({
    String? status,
    String? phase,
    String? track,
    bool clearStatus = false,
    bool clearPhase = false,
    bool clearTrack = false,
  }) {
    return CourseFilterState(
      status: clearStatus ? null : (status ?? this.status),
      phase: clearPhase ? null : (phase ?? this.phase),
      track: clearTrack ? null : (track ?? this.track),
    );
  }
}

/// 코스 목록 조회 필터를 관리하는 ViewModel입니다.
@riverpod
class CourseFilterViewModel extends _$CourseFilterViewModel {
  static const List<String> statuses = <String>['ACTIVE', 'ARCHIVED'];
  static const List<String> phases = <String>['BASIC', 'CS', 'FRAMEWORK'];
  static const List<String> tracks = <String>['NO', 'FL', 'SP'];

  @override
  CourseFilterState build() {
    return const CourseFilterState();
  }

  /// 상태 필터를 갱신합니다.
  void setStatus(String? value) {
    if (value == null) {
      state = state.copyWith(clearStatus: true);
      return;
    }
    if (!statuses.contains(value)) {
      return;
    }
    state = state.copyWith(status: value);
  }

  /// 과정 단계 필터를 갱신합니다.
  void setPhase(String? value) {
    if (value == null) {
      state = state.copyWith(clearPhase: true);
      return;
    }
    if (!phases.contains(value)) {
      return;
    }
    state = state.copyWith(phase: value);
  }

  /// 유저 트랙 필터를 갱신합니다.
  void setTrack(String? value) {
    if (value == null) {
      state = state.copyWith(clearTrack: true);
      return;
    }
    if (!tracks.contains(value)) {
      return;
    }
    state = state.copyWith(track: value);
  }
}
