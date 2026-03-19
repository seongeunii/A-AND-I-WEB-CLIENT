import 'package:a_and_i_report_web_server/src/feature/home/data/entities/level.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_summary.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_summary_response_dto.freezed.dart';
part 'report_summary_response_dto.g.dart';

/// 코스 목차 API 응답 DTO입니다.
@freezed
abstract class CourseOutlineResponseDto with _$CourseOutlineResponseDto {
  /// 코스 목차 API 응답 DTO를 생성합니다.
  const factory CourseOutlineResponseDto({
    required bool success,
    CourseOutlineDataDto? data,
    ErrorData? error,
    String? timestamp,
  }) = _CourseOutlineResponseDto;

  const CourseOutlineResponseDto._();

  /// JSON 응답을 DTO로 변환합니다.
  factory CourseOutlineResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CourseOutlineResponseDtoFromJson(json);

  /// 목차 응답을 화면용 요약 목록으로 변환합니다.
  List<ReportSummary> toSummaries() {
    final outline = data;
    if (outline == null) {
      return const <ReportSummary>[];
    }

    final reportType = _parseReportType(outline.course.phase);
    if (reportType == null) {
      return const <ReportSummary>[];
    }

    return outline.assignments
        .map(
          (assignment) => assignment.toSummary(reportType),
        )
        .whereType<ReportSummary>()
        .toList(growable: false);
  }
}

/// 코스 목차 데이터 DTO입니다.
@freezed
abstract class CourseOutlineDataDto with _$CourseOutlineDataDto {
  /// 코스 목차 데이터 DTO를 생성합니다.
  const factory CourseOutlineDataDto({
    required CourseOutlineHeaderDto course,
    @Default(0) int totalAssignments,
    @Default(<CourseOutlineAssignmentDto>[]) List<CourseOutlineAssignmentDto> assignments,
  }) = _CourseOutlineDataDto;

  /// JSON 응답을 DTO로 변환합니다.
  factory CourseOutlineDataDto.fromJson(Map<String, dynamic> json) =>
      _$CourseOutlineDataDtoFromJson(json);
}

/// 목차 헤더 코스 DTO입니다.
@freezed
abstract class CourseOutlineHeaderDto with _$CourseOutlineHeaderDto {
  /// 목차 헤더 코스 DTO를 생성합니다.
  const factory CourseOutlineHeaderDto({
    required String id,
    required String slug,
    required String fieldTag,
    required String title,
    required String description,
    required String phase,
  }) = _CourseOutlineHeaderDto;

  /// JSON 응답을 DTO로 변환합니다.
  factory CourseOutlineHeaderDto.fromJson(Map<String, dynamic> json) =>
      _$CourseOutlineHeaderDtoFromJson(json);
}

/// 목차 과제 항목 DTO입니다.
@freezed
abstract class CourseOutlineAssignmentDto with _$CourseOutlineAssignmentDto {
  /// 목차 과제 항목 DTO를 생성합니다.
  const factory CourseOutlineAssignmentDto({
    required String assignmentId,
    required int weekNo,
    required int orderInWeek,
    required String title,
    required String difficulty,
    required DateTime startAt,
    required DateTime endAt,
    @Default(false) bool checked,
  }) = _CourseOutlineAssignmentDto;

  const CourseOutlineAssignmentDto._();

  /// JSON 응답을 DTO로 변환합니다.
  factory CourseOutlineAssignmentDto.fromJson(Map<String, dynamic> json) =>
      _$CourseOutlineAssignmentDtoFromJson(json);

  /// 화면용 요약 엔티티로 변환합니다.
  ReportSummary? toSummary(ReportType reportType) {
    final level = _parseLevel(difficulty);
    if (level == null) {
      return null;
    }

    return ReportSummary(
      id: assignmentId,
      week: weekNo,
      seq: orderInWeek,
      title: title,
      level: level,
      reportType: reportType,
      endAt: endAt,
    );
  }
}

/// 주차별 과제 목록 API 응답 DTO입니다.
@freezed
abstract class ReportSummaryResponseDto with _$ReportSummaryResponseDto {
  /// 주차별 과제 목록 API 응답 DTO를 생성합니다.
  const factory ReportSummaryResponseDto({
    required bool success,
    required List<ReportSummary> data,
    ErrorData? error,
    String? timestamp,
  }) = _ReportSummaryResponseDto;

  const ReportSummaryResponseDto._();

  /// JSON 응답을 DTO로 변환합니다.
  factory ReportSummaryResponseDto.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];

    return ReportSummaryResponseDto(
      success: json['success'] == true,
      data: rawData is List
          ? rawData
              .whereType<Map<String, dynamic>>()
              .map(_toSummary)
              .whereType<ReportSummary>()
              .toList(growable: false)
          : const <ReportSummary>[],
      error: json['error'] is Map<String, dynamic>
          ? ErrorData.fromJson(json['error'] as Map<String, dynamic>)
          : null,
      timestamp: json['timestamp']?.toString(),
    );
  }

  static ReportSummary? _toSummary(Map<String, dynamic> json) {
    final metadata = json['metadata'];
    final attributes =
        metadata is Map<String, dynamic> ? metadata['attributes'] : null;

    final id = json['assignmentId']?.toString() ?? json['id']?.toString();
    final week = _asInt(json['weekNo']);
    final seq = _asInt(json['orderInWeek']) ?? 0;
    final title =
        metadata is Map<String, dynamic> ? metadata['title']?.toString() : null;
    final level = _parseLevel(
      metadata is Map<String, dynamic> ? metadata['difficulty'] : null,
    );
    final reportType = _parseReportType(
      attributes is Map<String, dynamic>
          ? attributes['legacyReportType'] ?? attributes['reportType']
          : null,
    );
    final endAt = _parseDateTime(json['endAt']);

    if (id == null ||
        week == null ||
        title == null ||
        level == null ||
        reportType == null ||
        endAt == null) {
      return null;
    }

    return ReportSummary(
      id: id,
      week: week,
      seq: seq,
      title: title,
      level: level,
      reportType: reportType,
      endAt: endAt,
    );
  }
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

DateTime? _parseDateTime(Object? value) {
  if (value is String && value.isNotEmpty) {
    return DateTime.tryParse(value);
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

typedef JsonMap = Map<String, dynamic>;

@freezed
abstract class ErrorData with _$ErrorData {
  const factory ErrorData({
    required String code,
    required String message,
  }) = _ErrorData;

  factory ErrorData.fromJson(JsonMap json) => _$ErrorDataFromJson(json);
}
