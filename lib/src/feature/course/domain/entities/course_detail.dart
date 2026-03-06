/// 코스 상세 정보를 표현하는 엔티티입니다.
class CourseDetail {
  final String id;
  final String slug;
  final String fieldTag;
  final String startDate;
  final String endDate;
  final CourseDetailMetadata metadata;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? title;
  final String? description;
  final String? phase;
  final String? targetTrack;

  const CourseDetail({
    required this.id,
    required this.slug,
    required this.fieldTag,
    required this.startDate,
    required this.endDate,
    required this.metadata,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.title,
    this.description,
    this.phase,
    this.targetTrack,
  });
}

/// 코스 메타데이터를 표현하는 엔티티입니다.
class CourseDetailMetadata {
  final String title;
  final String description;
  final String phase;
  final Map<String, dynamic>? attributes;

  const CourseDetailMetadata({
    required this.title,
    required this.description,
    required this.phase,
    this.attributes,
  });
}
