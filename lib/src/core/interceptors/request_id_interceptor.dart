import 'dart:math';

import 'package:a_and_i_report_web_server/src/core/network/api_exception.dart';
import 'package:dio/dio.dart';

/// 요청/응답의 X-Request-Id를 추적하기 위한 Interceptor입니다.
class RequestIdInterceptor extends Interceptor {
  static const _headerKey = 'X-Request-Id';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final existing = options.headers[_headerKey];
    final requestId = (existing is String && existing.isNotEmpty)
        ? existing
        : _generateRequestId();

    options.headers[_headerKey] = requestId;
    options.extra['requestId'] = requestId;

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final responseRequestId = response.headers.value('x-request-id');
    if (responseRequestId != null && responseRequestId.isNotEmpty) {
      response.requestOptions.extra['requestId'] = responseRequestId;
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final responseRequestId = err.response?.headers.value('x-request-id');
    if (responseRequestId != null && responseRequestId.isNotEmpty) {
      err.requestOptions.extra['requestId'] = responseRequestId;
    }

    if (err.error is! ApiException) {
      final apiException = ApiException.fromDio(err);
      handler.next(err.copyWith(error: apiException));
      return;
    }

    handler.next(err);
  }

  String _generateRequestId() {
    final now = DateTime.now().toUtc().microsecondsSinceEpoch;
    final random = Random().nextInt(1 << 32).toRadixString(16);
    return 'req-$now-$random';
  }
}
