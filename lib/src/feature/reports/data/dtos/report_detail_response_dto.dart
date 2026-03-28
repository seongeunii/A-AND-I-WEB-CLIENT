import 'package:a_and_i_report_web_server/src/feature/home/data/entities/level.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_type.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/report.dart';

/// 코스 과제 상세 API 응답 DTO입니다.
class ReportDetailResponseDto {
  /// 코스 과제 상세 API 응답 DTO를 생성합니다.
  const ReportDetailResponseDto({
    required this.success,
    this.data,
    this.error,
    this.timestamp,
  });

  /// 요청 성공 여부입니다.
  final bool success;

  /// 과제 상세 데이터입니다.
  final Report? data;

  /// 에러 정보입니다.
  final ReportDetailApiErrorDto? error;

  /// 응답 시각입니다.
  final String? timestamp;

  /// JSON 응답을 DTO로 변환합니다.
  factory ReportDetailResponseDto.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];

    return ReportDetailResponseDto(
      success: json['success'] == true,
      data: _parseReport(rawData),
      error: ReportDetailApiErrorDto.fromNullableJson(json['error']),
      timestamp: json['timestamp']?.toString(),
    );
  }
}

/// 과제 상세 API 에러 DTO입니다.
class ReportDetailApiErrorDto {
  /// 과제 상세 API 에러 DTO를 생성합니다.
  const ReportDetailApiErrorDto({
    this.code,
    this.message,
  });

  /// 서버 에러 코드입니다.
  final String? code;

  /// 사용자에게 표시할 수 있는 에러 메시지입니다.
  final String? message;

  /// JSON 응답을 DTO로 변환합니다.
  factory ReportDetailApiErrorDto.fromJson(Map<String, dynamic> json) {
    return ReportDetailApiErrorDto(
      code: json['code']?.toString(),
      message: json['message']?.toString(),
    );
  }

  /// nullable JSON을 DTO로 변환합니다.
  static ReportDetailApiErrorDto? fromNullableJson(Object? rawError) {
    if (rawError is! Map<String, dynamic>) {
      return null;
    }

    return ReportDetailApiErrorDto.fromJson(rawError);
  }
}

Report? _parseReport(Object? rawData) {
  if (rawData is! Map<String, dynamic>) {
    return null;
  }

  final metadata = rawData['metadata'];
  final metadataMap = metadata is Map<String, dynamic> ? metadata : null;
  final attributes = metadataMap?['attributes'];
  final attributesMap = attributes is Map<String, dynamic> ? attributes : null;
  final requirements = metadataMap?['requirements'];
  final learningGoals = metadataMap?['learningGoals'];
  final testCases = metadataMap?['testCases'];
  final codeTemplates = metadataMap?['codeTemplates'];

  final id = rawData['assignmentId']?.toString() ?? rawData['id']?.toString();
  final problemId = _extractProblemId(
    rawData: rawData,
    metadataMap: metadataMap,
    attributesMap: attributesMap,
  );
  final title = metadataMap?['title']?.toString();
  final content = metadataMap?['description']?.toString();
  final level = _parseLevel(metadataMap?['difficulty']);
  final reportType = _parseReportType(
    attributesMap?['legacyReportType'] ??
        attributesMap?['reportType'] ??
        rawData['reportType'] ??
        rawData['phase'] ??
        rawData['courseSlug'],
  );
  final week = _asInt(rawData['weekNo']);

  if (id == null ||
      title == null ||
      title.isEmpty ||
      content == null ||
      content.isEmpty ||
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
    exampleIo: _parseExamples(testCases),
    codeTemplates: _parseCodeTemplates(codeTemplates),
    reportType: reportType,
    week: week,
    level: level,
  );
}

String? _extractProblemId({
  required Map<String, dynamic> rawData,
  required Map<String, dynamic>? metadataMap,
  required Map<String, dynamic>? attributesMap,
}) {
  final candidates = <Object?>[
    attributesMap?['problemId'],
    attributesMap?['gradingProblemId'],
    attributesMap?['judgeProblemId'],
    attributesMap?['problemUuid'],
    metadataMap?['problemId'],
    metadataMap?['gradingProblemId'],
    metadataMap?['judgeProblemId'],
    rawData['problemId'],
    rawData['gradingProblemId'],
    rawData['judgeProblemId'],
    rawData['problemUuid'],
  ];

  for (final candidate in candidates) {
    final value = candidate?.toString().trim();
    if (value != null && value.isNotEmpty) {
      return value;
    }
  }

  return null;
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

    result.add(SeqString(seq: seq, content: content));
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

    result.add(SeqString(seq: seq, content: content));
  }
  return result;
}

List<ExampleIO> _parseExamples(Object? value) {
  if (value is! List) {
    return const <ExampleIO>[];
  }

  final result = <ExampleIO>[];
  for (var index = 0; index < value.length; index++) {
    final item = value[index];
    if (item is! Map<String, dynamic>) {
      continue;
    }

    final visibility = item['visibility']?.toString().trim().toUpperCase();
    if (visibility != null && visibility.isNotEmpty && visibility != 'PUBLIC') {
      continue;
    }

    final seq = _asInt(item['seq']) ?? _asInt(item['sortOrder']) ?? index + 1;
    final input = item['inputText']?.toString() ?? _parseInputValues(item);
    final output = item['outputText']?.toString() ?? _parseOutputValues(item);
    if (input == null || input.isEmpty || output == null || output.isEmpty) {
      continue;
    }

    result.add(ExampleIO(seq: seq, input: input, output: output));
  }
  return result;
}

List<CodeTemplate> _parseCodeTemplates(Object? value) {
  if (value is! List) {
    return const <CodeTemplate>[];
  }

  final result = <CodeTemplate>[];
  for (final item in value.whereType<Map<String, dynamic>>()) {
    final language = item['language']?.toString();
    final functionTemplate = item['functionTemplate']?.toString();
    if (language == null ||
        language.isEmpty ||
        functionTemplate == null ||
        functionTemplate.isEmpty) {
      continue;
    }

    result.add(
      CodeTemplate(
        language: language,
        functionTemplate: functionTemplate,
      ),
    );
  }

  return result;
}

String? _parseInputValues(Map<String, dynamic> item) {
  final inputValues = item['inputValues'];
  if (inputValues is! List) {
    return null;
  }
  return _formatVariableValues(inputValues);
}

String? _parseOutputValues(Map<String, dynamic> item) {
  final outputValues = item['outputValues'];
  if (outputValues is! List) {
    return null;
  }
  return _formatVariableValues(outputValues);
}

String? _formatVariableValues(List<dynamic> rawValues) {
  final values = rawValues
      .map((value) => value?.toString() ?? '')
      .where((value) => value.isNotEmpty)
      .toList(growable: false);
  if (values.isEmpty) {
    return null;
  }

  return values
      .asMap()
      .entries
      .map((entry) => '${_alphabetLabel(entry.key)} = ${entry.value}')
      .join('\n');
}

String _alphabetLabel(int index) {
  var current = index;
  final buffer = StringBuffer();

  do {
    buffer.writeCharCode(97 + (current % 26));
    current = (current ~/ 26) - 1;
  } while (current >= 0);

  return buffer.toString().split('').reversed.join();
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

  if (normalized.contains('CS')) {
    return ReportType.CS;
  }

  if (normalized.contains('BASIC') || normalized.contains('FRAMEWORK')) {
    return ReportType.BASIC;
  }

  return switch (normalized) {
    'CS' => ReportType.CS,
    'BASIC' || 'FRAMEWORK' => ReportType.BASIC,
    _ => null,
  };
}
