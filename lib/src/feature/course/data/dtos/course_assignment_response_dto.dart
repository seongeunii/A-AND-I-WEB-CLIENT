/// 코스 과제 응답 DTO입니다.
class CourseAssignmentDto {
  final String id;
  final String courseSlug;
  final int weekNo;
  final int orderInWeek;
  final DateTime startAt;
  final DateTime endAt;
  final String status;
  final DateTime? publishedAt;
  final CourseAssignmentMetadataDto metadata;

  const CourseAssignmentDto({
    required this.id,
    required this.courseSlug,
    required this.weekNo,
    required this.orderInWeek,
    required this.startAt,
    required this.endAt,
    required this.status,
    this.publishedAt,
    required this.metadata,
  });

  factory CourseAssignmentDto.fromJson(Map<String, dynamic> json) {
    return CourseAssignmentDto(
      id: json['id'] as String,
      courseSlug: json['courseSlug'] as String,
      weekNo: (json['weekNo'] as num).toInt(),
      orderInWeek: (json['orderInWeek'] as num).toInt(),
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      status: json['status'] as String,
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'] as String)
          : null,
      metadata: CourseAssignmentMetadataDto.fromJson(
        json['metadata'] as Map<String, dynamic>,
      ),
    );
  }
}

/// 코스 과제 메타데이터 응답 DTO입니다.
class CourseAssignmentMetadataDto {
  final String title;
  final String difficulty;
  final String description;
  final int? timeLimitMinutes;
  final List<String> learningGoals;
  final Map<String, dynamic>? attributes;

  const CourseAssignmentMetadataDto({
    required this.title,
    required this.difficulty,
    required this.description,
    this.timeLimitMinutes,
    this.learningGoals = const <String>[],
    this.attributes,
  });

  factory CourseAssignmentMetadataDto.fromJson(Map<String, dynamic> json) {
    return CourseAssignmentMetadataDto(
      title: json['title'] as String,
      difficulty: json['difficulty'] as String,
      description: json['description'] as String,
      timeLimitMinutes: (json['timeLimitMinutes'] as num?)?.toInt(),
      learningGoals:
          (json['learningGoals'] as List<dynamic>? ?? const <dynamic>[])
              .map((e) => e.toString())
              .toList(growable: false),
      attributes: json['attributes'] as Map<String, dynamic>?,
    );
  }
}
