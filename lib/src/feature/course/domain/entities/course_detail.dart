/// 코스 상세 정보를 표현하는 엔티티입니다.
class CourseDetail {
  final CourseDetailCore core;
  final CourseDetailMetadata metadata;
  final CourseDetailAdditional additional;

  const CourseDetail({
    required this.core,
    required this.metadata,
    required this.additional,
  });

  String get id => core.id;
  String get slug => core.slug;
  String get fieldTag => core.fieldTag;
  String get startDate => core.startDate;
  String get endDate => core.endDate;
  String get status => core.status;
  DateTime get createdAt => core.createdAt;
  DateTime get updatedAt => core.updatedAt;
  String? get title => additional.title;
  String? get description => additional.description;
  String? get phase => additional.phase;
  String? get targetTrack => additional.targetTrack;
}

/// 코스 상세의 코어 필드입니다.
class CourseDetailCore {
  final String id;
  final String slug;
  final String fieldTag;
  final String startDate;
  final String endDate;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CourseDetailCore({
    required this.id,
    required this.slug,
    required this.fieldTag,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
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

/// 코스 상세의 부가 필드입니다.
class CourseDetailAdditional {
  final String? title;
  final String? description;
  final String? phase;
  final String? targetTrack;

  const CourseDetailAdditional({
    this.title,
    this.description,
    this.phase,
    this.targetTrack,
  });
}
