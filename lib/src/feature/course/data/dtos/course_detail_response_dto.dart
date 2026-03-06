/// 코스 상세 API 응답 DTO입니다.
class CourseDetailResponseDto {
  final bool success;
  final CourseDetailDto? data;
  final CourseDetailErrorDto? error;
  final DateTime? timestamp;

  const CourseDetailResponseDto({
    required this.success,
    this.data,
    this.error,
    this.timestamp,
  });

  factory CourseDetailResponseDto.fromJson(Map<String, dynamic> json) {
    return CourseDetailResponseDto(
      success: json['success'] as bool? ?? false,
      data: json['data'] is Map<String, dynamic>
          ? CourseDetailDto.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      error: json['error'] is Map<String, dynamic>
          ? CourseDetailErrorDto.fromJson(json['error'] as Map<String, dynamic>)
          : null,
      timestamp: json['timestamp'] is String
          ? DateTime.tryParse(json['timestamp'] as String)
          : null,
    );
  }
}

/// 코스 상세 데이터 DTO입니다.
class CourseDetailDto {
  final String id;
  final String slug;
  final String fieldTag;
  final String startDate;
  final String endDate;
  final CourseDetailMetadataDto metadata;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? title;
  final String? description;
  final String? phase;
  final String? targetTrack;

  const CourseDetailDto({
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

  factory CourseDetailDto.fromJson(Map<String, dynamic> json) {
    return CourseDetailDto(
      id: json['id'] as String,
      slug: json['slug'] as String,
      fieldTag: json['fieldTag'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      metadata: CourseDetailMetadataDto.fromJson(
        json['metadata'] as Map<String, dynamic>,
      ),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      title: json['title'] as String?,
      description: json['description'] as String?,
      phase: json['phase'] as String?,
      targetTrack: json['targetTrack'] as String?,
    );
  }
}

/// 코스 메타데이터 DTO입니다.
class CourseDetailMetadataDto {
  final String title;
  final String description;
  final String phase;
  final Map<String, dynamic>? attributes;

  const CourseDetailMetadataDto({
    required this.title,
    required this.description,
    required this.phase,
    this.attributes,
  });

  factory CourseDetailMetadataDto.fromJson(Map<String, dynamic> json) {
    return CourseDetailMetadataDto(
      title: json['title'] as String,
      description: json['description'] as String,
      phase: json['phase'] as String,
      attributes: json['attributes'] as Map<String, dynamic>?,
    );
  }
}

/// 코스 상세 API 에러 응답 DTO입니다.
class CourseDetailErrorDto {
  final String? code;
  final String message;

  const CourseDetailErrorDto({
    this.code,
    required this.message,
  });

  factory CourseDetailErrorDto.fromJson(Map<String, dynamic> json) {
    return CourseDetailErrorDto(
      code: json['code'] as String?,
      message: json['message'] as String? ?? '코스 조회에 실패했습니다.',
    );
  }
}
