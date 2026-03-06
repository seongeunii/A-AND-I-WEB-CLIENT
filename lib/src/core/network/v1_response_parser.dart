/// v1 API의 공통 응답 envelope(`success/data/error/timestamp`)를 파싱하는 유틸입니다.
final class V1ResponseParser {
  const V1ResponseParser._();

  /// 객체 응답을 파싱합니다.
  static T parseObject<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> map) fromJson,
  ) {
    if (json.containsKey('success')) {
      final success = json['success'] as bool? ?? false;
      if (!success) {
        throw Exception(_extractErrorMessage(json));
      }

      final data = json['data'];
      if (data is Map<String, dynamic>) {
        return fromJson(data);
      }
      throw Exception('응답 데이터 형식이 올바르지 않습니다.');
    }

    return fromJson(json);
  }

  /// 목록 응답을 파싱합니다.
  static List<T> parseList<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> map) fromJson,
  ) {
    if (json.containsKey('success')) {
      final success = json['success'] as bool? ?? false;
      if (!success) {
        throw Exception(_extractErrorMessage(json));
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

    // envelope가 아닌 경우 단일 객체로 판단해 1개 리스트로 변환
    return <T>[fromJson(json)];
  }

  /// 에러 메시지를 추출합니다.
  static String _extractErrorMessage(Map<String, dynamic> json) {
    final error = json['error'];
    if (error is Map<String, dynamic>) {
      final message = error['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }

    final message = json['message'];
    if (message is String && message.isNotEmpty) {
      return message;
    }

    return '요청 처리 중 오류가 발생했습니다.';
  }
}
