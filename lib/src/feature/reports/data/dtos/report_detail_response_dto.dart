// ignore_for_file: invalid_annotation_target

import 'package:a_and_i_report_web_server/src/feature/home/data/entities/level.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_type.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/report.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_detail_response_dto.freezed.dart';
part 'report_detail_response_dto.g.dart';

/// 코스 과제 상세 API 응답 DTO입니다.
@freezed
abstract class ReportDetailResponseDto with _$ReportDetailResponseDto {
  /// 코스 과제 상세 API 응답 DTO를 생성합니다.
  const factory ReportDetailResponseDto({
    required bool success,
    @JsonKey(fromJson: _parseReport) Report? data,
    @JsonKey(fromJson: _parseError) ReportDetailApiErrorDto? error,
    String? timestamp,
  }) = _ReportDetailResponseDto;

  /// JSON 응답을 DTO로 변환합니다.
  factory ReportDetailResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ReportDetailResponseDtoFromJson(json);
}

Report? _parseReport(Object? rawData) {
  if (rawData is! Map<String, dynamic>) {
    return null;
  }

  final metadata = rawData['metadata'];
  final attributes = metadata is Map<String, dynamic>
      ? metadata['attributes']
      : null;
  final requirements = metadata is Map<String, dynamic>
      ? metadata['requirements']
      : null;
  final learningGoals = metadata is Map<String, dynamic>
      ? metadata['learningGoals']
      : null;
  final examples = metadata is Map<String, dynamic>
      ? metadata['examples']
      : null;

  final id = rawData['assignmentId']?.toString() ?? rawData['id']?.toString();
  final problemId = attributes is Map<String, dynamic>
      ? attributes['problemId']?.toString()
      : rawData['problemId']?.toString();
  final title = metadata is Map<String, dynamic>
      ? metadata['title']?.toString()
      : null;
  final content = metadata is Map<String, dynamic>
      ? metadata['description']?.toString()
      : null;
  final level = _parseLevel(
    metadata is Map<String, dynamic> ? metadata['difficulty'] : null,
  );
  final reportType = _parseReportType(
    attributes is Map<String, dynamic>
        ? attributes['legacyReportType'] ?? attributes['reportType']
        : null,
  );
  final week = _asInt(rawData['weekNo']);

  if (id == null ||
      title == null ||
      content == null ||
      level == null ||
      reportType == null ||
      week == null) {
    return null;
  }

  return Report(
    id: id,
    problemId: problemId,
    title: title,
    content: content,
    requirement: _parseRequirements(requirements),
    objects: _parseLearningGoals(learningGoals),
    exampleIo: _parseExamples(examples),
    reportType: reportType,
    week: week,
    level: level,
  );
}

List<SeqString> _parseRequirements(Object? value) {
  if (value is! List) {
    return const <SeqString>[];
  }

  final result = <SeqString>[];
  for (final item in value.whereType<Map<String, dynamic>>()) {
    final seq = _asInt(item['sortOrder']);
    final content = item['requirementText']?.toString();
    if (seq == null || content == null || content.isEmpty) {
      continue;
    }

    result.add(
      SeqString(
        seq: seq,
        content: content,
      ),
    );
  }
  return result;
}

List<SeqString> _parseLearningGoals(Object? value) {
  if (value is! List) {
    return const <SeqString>[];
  }

  final result = <SeqString>[];
  for (final item in value.whereType<Map<String, dynamic>>()) {
    final seq = _asInt(item['sortOrder']);
    final content = item['learningGoalText']?.toString();
    if (seq == null || content == null || content.isEmpty) {
      continue;
    }

    result.add(
      SeqString(
        seq: seq,
        content: content,
      ),
    );
  }
  return result;
}

List<ExampleIO> _parseExamples(Object? value) {
  if (value is! List) {
    return const <ExampleIO>[];
  }

  final result = <ExampleIO>[];
  for (final item in value.whereType<Map<String, dynamic>>()) {
    final seq = _asInt(item['seq']);
    final input = item['inputText']?.toString();
    final output = item['outputText']?.toString();
    if (seq == null || input == null || output == null) {
      continue;
    }

    result.add(
      ExampleIO(
        seq: seq,
        input: input,
        output: output,
      ),
    );
  }
  return result;
}

int? _asInt(Object? value) {
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  if (value is String) {
    return int.tryParse(value);
  }
  return null;
}

Level? _parseLevel(Object? value) {
  final normalized = value?.toString().trim().toUpperCase();
  if (normalized == null || normalized.isEmpty) {
    return null;
  }

  return switch (normalized) {
    'VERY_HIGH' || 'VERYHIGH' => Level.VERYHIGH,
    'HIGH' => Level.HIGH,
    'MID' || 'MEDIUM' => Level.MEDIUM,
    'LOW' => Level.LOW,
    _ => null,
  };
}

ReportType? _parseReportType(Object? value) {
  final normalized = value?.toString().trim().toUpperCase();
  if (normalized == null || normalized.isEmpty) {
    return null;
  }

  return switch (normalized) {
    'CS' => ReportType.CS,
    'BASIC' => ReportType.BASIC,
    'FRAMEWORK' => ReportType.BASIC,
    _ => null,
  };
}

ReportDetailApiErrorDto? _parseError(Object? rawError) {
  if (rawError is! Map<String, dynamic>) {
    return null;
  }

  return ReportDetailApiErrorDto.fromJson(rawError);
}

/// 과제 상세 API 에러 DTO입니다.
@freezed
abstract class ReportDetailApiErrorDto with _$ReportDetailApiErrorDto {
  /// 과제 상세 API 에러 DTO를 생성합니다.
  const factory ReportDetailApiErrorDto({
    String? code,
    String? message,
  }) = _ReportDetailApiErrorDto;

  /// JSON 응답을 DTO로 변환합니다.
  factory ReportDetailApiErrorDto.fromJson(Map<String, dynamic> json) =>
      _$ReportDetailApiErrorDtoFromJson(json);
}
