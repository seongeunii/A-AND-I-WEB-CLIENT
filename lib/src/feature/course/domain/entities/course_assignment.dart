/// 과제 코어 필드를 표현하는 엔티티입니다.
class CourseAssignmentCore {
  final String id;
  final String courseSlug;
  final int weekNo;
  final int orderInWeek;
  final DateTime startAt;
  final DateTime endAt;
  final String status;
  final DateTime? publishedAt;

  const CourseAssignmentCore({
    required this.id,
    required this.courseSlug,
    required this.weekNo,
    required this.orderInWeek,
    required this.startAt,
    required this.endAt,
    required this.status,
    this.publishedAt,
  });
}

/// 과제 메타데이터 필드를 표현하는 엔티티입니다.
class CourseAssignmentMetadata {
  final String title;
  final String difficulty;
  final String description;
  final int? timeLimitMinutes;
  final List<String> learningGoals;
  final Map<String, dynamic>? attributes;

  const CourseAssignmentMetadata({
    required this.title,
    required this.difficulty,
    required this.description,
    this.timeLimitMinutes,
    this.learningGoals = const <String>[],
    this.attributes,
  });
}

/// 코스 과제 정보를 표현하는 엔티티입니다.
class CourseAssignment {
  final CourseAssignmentCore core;
  final CourseAssignmentMetadata metadata;

  const CourseAssignment({
    required this.core,
    required this.metadata,
  });

  String get id => core.id;
  String get courseSlug => core.courseSlug;
  int get weekNo => core.weekNo;
  int get orderInWeek => core.orderInWeek;
  DateTime get startAt => core.startAt;
  DateTime get endAt => core.endAt;
  String get status => core.status;
  DateTime? get publishedAt => core.publishedAt;
}
