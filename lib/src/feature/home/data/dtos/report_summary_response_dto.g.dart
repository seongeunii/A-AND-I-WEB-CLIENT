// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_summary_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseOutlineResponseDto _$CourseOutlineResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _CourseOutlineResponseDto(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : CourseOutlineDataDto.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'] == null
          ? null
          : ErrorData.fromJson(json['error'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$CourseOutlineResponseDtoToJson(
        _CourseOutlineResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'error': instance.error,
      'timestamp': instance.timestamp,
    };

_CourseOutlineDataDto _$CourseOutlineDataDtoFromJson(
        Map<String, dynamic> json) =>
    _CourseOutlineDataDto(
      course: CourseOutlineHeaderDto.fromJson(
          json['course'] as Map<String, dynamic>),
      totalAssignments: (json['totalAssignments'] as num?)?.toInt() ?? 0,
      assignments: (json['assignments'] as List<dynamic>?)
              ?.map((e) => CourseOutlineAssignmentDto.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const <CourseOutlineAssignmentDto>[],
    );

Map<String, dynamic> _$CourseOutlineDataDtoToJson(
        _CourseOutlineDataDto instance) =>
    <String, dynamic>{
      'course': instance.course,
      'totalAssignments': instance.totalAssignments,
      'assignments': instance.assignments,
    };

_CourseOutlineHeaderDto _$CourseOutlineHeaderDtoFromJson(
        Map<String, dynamic> json) =>
    _CourseOutlineHeaderDto(
      id: json['id'] as String,
      slug: json['slug'] as String,
      fieldTag: json['fieldTag'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      phase: json['phase'] as String,
    );

Map<String, dynamic> _$CourseOutlineHeaderDtoToJson(
        _CourseOutlineHeaderDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'fieldTag': instance.fieldTag,
      'title': instance.title,
      'description': instance.description,
      'phase': instance.phase,
    };

_CourseOutlineAssignmentDto _$CourseOutlineAssignmentDtoFromJson(
        Map<String, dynamic> json) =>
    _CourseOutlineAssignmentDto(
      assignmentId: json['assignmentId'] as String,
      weekNo: (json['weekNo'] as num).toInt(),
      orderInWeek: (json['orderInWeek'] as num).toInt(),
      title: json['title'] as String,
      difficulty: json['difficulty'] as String,
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      checked: json['checked'] as bool? ?? false,
    );

Map<String, dynamic> _$CourseOutlineAssignmentDtoToJson(
        _CourseOutlineAssignmentDto instance) =>
    <String, dynamic>{
      'assignmentId': instance.assignmentId,
      'weekNo': instance.weekNo,
      'orderInWeek': instance.orderInWeek,
      'title': instance.title,
      'difficulty': instance.difficulty,
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt.toIso8601String(),
      'checked': instance.checked,
    };

_ErrorData _$ErrorDataFromJson(Map<String, dynamic> json) => _ErrorData(
      code: json['code'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ErrorDataToJson(_ErrorData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
