import 'package:a_and_i_report_web_server/src/core/network/api_exception.dart';

/// API 예외를 사용자 표시 문구로 변환합니다.
final class ApiErrorPresenter {
  const ApiErrorPresenter._();

  /// 사용자에게 보여줄 에러 메시지를 반환합니다.
  static String message(Object error) {
    if (error is ApiException) {
      return switch (error.code) {
        'UNAUTHORIZED' => '인증이 필요합니다. 다시 로그인해주세요.',
        'FORBIDDEN' => '요청을 수행할 권한이 없습니다.',
        'NOT_FOUND' => error.message,
        'ENUM_MISMATCH' => '요청 값이 올바르지 않습니다. 값을 확인해주세요.',
        'VALIDATION_ERROR' ||
        'INPUT_ERROR' ||
        'MISSING_REQUIRED_VALUE' ||
        'BAD_REQUEST' =>
          error.message,
        _ => error.message,
      };
    }

    return '요청 처리 중 오류가 발생했습니다.';
  }

  /// 사용자 문의 추적용 requestId를 반환합니다.
  static String? requestId(Object error) {
    if (error is ApiException &&
        error.requestId != null &&
        error.requestId!.isNotEmpty) {
      return error.requestId;
    }
    return null;
  }
}
