import 'package:a_and_i_report_web_server/src/feature/course/presentation/course_access_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isCourseClosed', () {
    test('날짜만 있는 종료일은 해당 날짜가 끝날 때까지 열려 있다', () {
      expect(
        isCourseClosed(
          '2026-03-27',
          now: DateTime.parse('2026-03-27T23:59:59.000Z'),
        ),
        isFalse,
      );
    });

    test('날짜만 있는 종료일은 다음 날부터 종료된다', () {
      expect(
        isCourseClosed(
          '2026-03-27',
          now: DateTime.parse('2026-03-28T00:00:00.000Z'),
        ),
        isTrue,
      );
    });

    test('타임존이 포함된 종료일은 절대 시각 기준으로 종료를 판단한다', () {
      expect(
        isCourseClosed(
          '2026-03-27T12:00:00+09:00',
          now: DateTime.parse('2026-03-27T03:00:00.000Z'),
        ),
        isTrue,
      );
    });
  });
}
