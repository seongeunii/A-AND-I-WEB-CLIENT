// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_result_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubmissionResultResponseDto _$SubmissionResultResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _SubmissionResultResponseDto(
      submissionId: json['submissionId'] as String,
      problemId: json['problemId'] as String?,
      language: json['language'] as String?,
      status: json['status'] as String,
      testCases: json['testCases'] == null
          ? const <SubmissionTestCaseResult>[]
          : _parseTestCases(json['testCases']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$SubmissionResultResponseDtoToJson(
        _SubmissionResultResponseDto instance) =>
    <String, dynamic>{
      'submissionId': instance.submissionId,
      'problemId': instance.problemId,
      'language': instance.language,
      'status': instance.status,
      'testCases': instance.testCases,
      'createdAt': instance.createdAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };
