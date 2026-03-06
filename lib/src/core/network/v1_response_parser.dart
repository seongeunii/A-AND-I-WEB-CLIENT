import 'package:a_and_i_report_web_server/src/core/network/api_exception.dart';

/// v1 API의 공통 응답 envelope(`success/data/error/timestamp`)를 파싱하는 유틸입니다.
final class V1ResponseParser {
  const V1ResponseParser._();

  /// 객체 응답을 파싱합니다.
  static T parseObject<T>(
      Map<String, dynamic> json, T Function(Map<String, dynamic> map) fromJson,
      {int? status, String? requestId}) {
    if (!json.containsKey('success')) {
      throw ApiException(
        code: 'INVALID_ENVELOPE',
        message: 'v1 응답 envelope 형식이 올바르지 않습니다.',
        status: status,
        requestId: requestId,
      );
    }

    final success = json['success'] as bool? ?? false;
    if (!success) {
      throw _extractError(json, status: status, requestId: requestId);
    }

    final data = json['data'];
    if (data is Map<String, dynamic>) {
      return fromJson(data);
    }
    throw ApiException(
      code: 'INVALID_ENVELOPE',
      message: '응답 데이터 형식이 올바르지 않습니다.',
      status: status,
      requestId: requestId,
    );
  }

  /// 목록 응답을 파싱합니다.
  static List<T> parseList<T>(
      Map<String, dynamic> json, T Function(Map<String, dynamic> map) fromJson,
      {int? status, String? requestId}) {
    if (!json.containsKey('success')) {
      throw ApiException(
        code: 'INVALID_ENVELOPE',
        message: 'v1 응답 envelope 형식이 올바르지 않습니다.',
        status: status,
        requestId: requestId,
      );
    }

    final success = json['success'] as bool? ?? false;
    if (!success) {
      throw _extractError(json, status: status, requestId: requestId);
    }

    final data = json['data'];
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(fromJson)
          .toList(growable: false);
    }
    return <T>[];
  }

  /// 에러 envelope를 [ApiException]으로 변환합니다.
  static ApiException _extractError(
    Map<String, dynamic> json, {
    int? status,
    String? requestId,
  }) {
    String code = 'UNKNOWN';
    String message = '요청 처리 중 오류가 발생했습니다.';

    final error = json['error'];
    if (error is Map<String, dynamic>) {
      final extractedCode = error['code'];
      if (extractedCode is String && extractedCode.isNotEmpty) {
        code = extractedCode;
      }

      final extractedMessage = error['message'];
      if (extractedMessage is String && extractedMessage.isNotEmpty) {
        message = extractedMessage;
      }
    }

    final topLevelMessage = json['message'];
    if (topLevelMessage is String && topLevelMessage.isNotEmpty) {
      message = topLevelMessage;
    }

    return ApiException(
      code: code,
      message: message,
      status: status,
      requestId: requestId,
    );
  }
}
