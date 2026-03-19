// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_result_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubmissionResultResponseDto _$SubmissionResultResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _SubmissionResultResponseDto(
      submissionId: json['submissionId'] as String,
      status: json['status'] as String,
      testCases: json['testCases'] == null
          ? const <SubmissionTestCaseResult>[]
          : _parseTestCases(json['testCases']),
    );

Map<String, dynamic> _$SubmissionResultResponseDtoToJson(
        _SubmissionResultResponseDto instance) =>
    <String, dynamic>{
      'submissionId': instance.submissionId,
      'status': instance.status,
      'testCases': instance.testCases,
    };
