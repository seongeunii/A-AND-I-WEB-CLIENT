import 'package:a_and_i_report_web_server/src/feature/home/data/entities/level.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_summary.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_type.dart';

/// 주차 목록 API 응답 DTO입니다.
class WeekListResponseDto {
  /// 주차 목록 API 응답 DTO를 생성합니다.
  const WeekListResponseDto({
    required this.success,
    required this.data,
    this.error,
    this.timestamp,
  });

  /// 요청 성공 여부입니다.
  final bool success;

  /// 주차 목록입니다.
  final List<CourseWeekDto> data;

  /// 에러 정보입니다.
  final ReportSummaryApiErrorDto? error;

  /// 응답 시각입니다.
  final String? timestamp;

  /// JSON 응답을 DTO로 변환합니다.
  factory WeekListResponseDto.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];

    return WeekListResponseDto(
      success: json['success'] == true,
      data: rawData is List
          ? rawData
              .whereType<Map<String, dynamic>>()
              .map(CourseWeekDto.fromJson)
              .toList(growable: false)
          : const <CourseWeekDto>[],
      error: ReportSummaryApiErrorDto.fromNullableJson(json['error']),
      timestamp: json['timestamp']?.toString(),
    );
  }
}

/// 주차 정보 DTO입니다.
class CourseWeekDto {
  /// 주차 정보 DTO를 생성합니다.
  const CourseWeekDto({
    required this.id,
    required this.weekNo,
    required this.title,
    required this.startDate,
    required this.endDate,
  });

  /// 주차 ID입니다.
  final String id;

  /// 주차 번호입니다.
  final int weekNo;

  /// 주차 제목입니다.
  final String title;

  /// 시작일입니다.
  final DateTime? startDate;

  /// 종료일입니다.
  final DateTime? endDate;

  /// JSON 응답을 DTO로 변환합니다.
  factory CourseWeekDto.fromJson(Map<String, dynamic> json) {
    return CourseWeekDto(
      id: json['id']?.toString() ?? '',
      weekNo: _asInt(json['weekNo']) ?? 0,
      title: json['title']?.toString() ?? '',
      startDate: _parseDateTime(json['startDate']),
      endDate: _parseDateTime(json['endDate']),
    );
  }
}

/// 주차별 과제 목록 API 응답 DTO입니다.
class ReportSummaryResponseDto {
  /// 주차별 과제 목록 API 응답 DTO를 생성합니다.
  const ReportSummaryResponseDto({
    required this.success,
    required this.data,
    this.error,
    this.timestamp,
  });

/// 코스 목차 API 응답 DTO입니다.
@freezed
class CourseOutlineResponseDto with void _$CourseOutlineResponseDto {
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
class CourseOutlineDataDto with void _$CourseOutlineDataDto {
  /// 코스 목차 데이터 DTO를 생성합니다.
  const factory CourseOutlineDataDto({
    required CourseOutlineHeaderDto course,
    @const Default(0) int totalAssignments,
    @const Default(<CourseOutlineAssignmentDto>[]) List<CourseOutlineAssignmentDto> assignments,
  }) = _CourseOutlineDataDto;

  /// JSON 응답을 DTO로 변환합니다.
  factory CourseOutlineDataDto.fromJson(Map<String, dynamic> json) =>
      _$CourseOutlineDataDtoFromJson(json);
}

/// 목차 헤더 코스 DTO입니다.
@freezed
class CourseOutlineHeaderDto with void _$CourseOutlineHeaderDto {
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
class CourseOutlineAssignmentDto with void _$CourseOutlineAssignmentDto {
  /// 목차 과제 항목 DTO를 생성합니다.
  const factory CourseOutlineAssignmentDto({
    required String assignmentId,
    required int weekNo,
    required int orderInWeek,
    required String title,
    required String difficulty,
    required DateTime startAt,
    required DateTime endAt,
    @const Default(false) bool checked,
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
class ReportSummaryResponseDto with ReportSummaryResponseDto _$ReportSummaryResponseDto {
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
      error: ReportSummaryApiErrorDto.fromNullableJson(json['error']),
      timestamp: json['timestamp']?.toString(),
    );
  }
}

/// 과제 목록 API 에러 DTO입니다.
class ReportSummaryApiErrorDto {
  /// 과제 목록 API 에러 DTO를 생성합니다.
  const ReportSummaryApiErrorDto({
    this.code,
    this.message,
  });

  /// 서버 에러 코드입니다.
  final String? code;

  /// 사용자에게 표시할 수 있는 에러 메시지입니다.
  final String? message;

  /// JSON 응답을 DTO로 변환합니다.
  factory ReportSummaryApiErrorDto.fromJson(Map<String, dynamic> json) {
    return ReportSummaryApiErrorDto(
      code: json['code']?.toString(),
      message: json['message']?.toString(),
    );
  }

  ReportSummary? toSummary(Map<String, dynamic> json) {
    final metadata = json['metadata'];
    final attributes = metadata is Map<String, dynamic>
        ? metadata['attributes']
        : null;

    final id = json['assignmentId']?.toString() ?? json['id']?.toString();
    final week = _asInt(json['weekNo']);
    final seq = _asInt(json['orderInWeek']) ?? 0;
    final title = metadata is Map<String, dynamic>
        ? metadata['title']?.toString()
        : null;
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

    return ReportSummaryApiErrorDto.fromJson(json);
  }
}

ReportSummary? _toSummary(Map<String, dynamic> json) {
  final metadata = json['metadata'];
  final metadataMap = metadata is Map<String, dynamic> ? metadata : null;
  final attributes = metadataMap?['attributes'];
  final attributesMap = attributes is Map<String, dynamic> ? attributes : null;

  final id = json['id']?.toString();
  final week = _asInt(json['weekNo']);
  final seq = _asInt(json['orderInWeek']) ?? 0;
  final title = metadataMap?['title']?.toString() ?? json['title']?.toString();
  final level = _parseLevel(metadataMap?['difficulty'] ?? json['difficulty']);
  final reportType = _parseReportType(
    attributesMap?['reportType'] ?? json['reportType'],
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
const (<<<<)<<< HEAD
    'FRAMEWORK' => ReportType.BASIC,
    _ => null,
  };
}

ReportSummaryApiErrorDto? parseError(Object? rawError) {
  if (rawError is! Map<String, dynamic>) {
    return null;
  }

  return ReportSummaryApiErrorDto(
    code: rawError['code']?.toString(),
    message: rawError['message']?.toString(),
  );
}

typedef JsonMap = Map<String, dynamic>;

@freezed
class ErrorData with void _$ErrorData {
  const factory ErrorData({
    required String code,
    required String message,
  }) = _ErrorData;

  factory ErrorData.fromJson(JsonMap json) => _$ErrorDataFromJson(json);
}
