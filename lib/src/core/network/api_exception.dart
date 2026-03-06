import 'package:dio/dio.dart';

/// API 요청 처리 중 발생한 공통 예외입니다.
class ApiException implements Exception {
  final String code;
  final String message;
  final int? status;
  final String? requestId;

  const ApiException({
    required this.code,
    required this.message,
    this.status,
    this.requestId,
  });

  /// [DioException]으로부터 [ApiException]을 생성합니다.
  factory ApiException.fromDio(
    DioException error, {
    String? fallbackCode,
    String? fallbackMessage,
  }) {
    final status = error.response?.statusCode;
    final requestId = _extractRequestId(error);

    final data = error.response?.data;
    if (data is Map<String, dynamic>) {
      final apiError = data['error'];
      if (apiError is Map<String, dynamic>) {
        final code = (apiError['code'] as String?) ?? fallbackCode ?? 'UNKNOWN';
        final message = (apiError['message'] as String?) ??
            fallbackMessage ??
            '요청 처리 중 오류가 발생했습니다.';
        return ApiException(
          code: code,
          message: message,
          status: status,
          requestId: requestId,
        );
      }

      final message = data['message'];
      if (message is String && message.isNotEmpty) {
        return ApiException(
          code: fallbackCode ?? _codeByStatus(status),
          message: message,
          status: status,
          requestId: requestId,
        );
      }
    }

    return ApiException(
      code: fallbackCode ?? _codeByStatus(status),
      message: fallbackMessage ?? '요청 처리 중 오류가 발생했습니다.',
      status: status,
      requestId: requestId,
    );
  }

  static String _extractRequestId(DioException error) {
    final headerRequestId = error.response?.headers.value('x-request-id');
    if (headerRequestId != null && headerRequestId.isNotEmpty) {
      return headerRequestId;
    }

    final requestHeader = error.requestOptions.headers['X-Request-Id'];
    if (requestHeader is String && requestHeader.isNotEmpty) {
      return requestHeader;
    }

    final extraRequestId = error.requestOptions.extra['requestId'];
    if (extraRequestId is String && extraRequestId.isNotEmpty) {
      return extraRequestId;
    }

    return '';
  }

  static String _codeByStatus(int? status) {
    return switch (status) {
      400 => 'BAD_REQUEST',
      401 => 'UNAUTHORIZED',
      403 => 'FORBIDDEN',
      404 => 'NOT_FOUND',
      409 => 'CONFLICT',
      422 => 'UNPROCESSABLE_ENTITY',
      500 => 'INTERNAL_ERROR',
      _ => 'UNKNOWN',
    };
  }

  @override
  String toString() {
    return message;
  }
}
