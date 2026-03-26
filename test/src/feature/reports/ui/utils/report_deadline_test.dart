import 'package:a_and_i_report_web_server/src/feature/reports/ui/utils/report_deadline.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isReportDeadlineClosed', () {
    test('현재 시각과 마감 시각이 같으면 마감된 것으로 본다', () {
      final now = DateTime.parse('2026-03-27T03:00:00Z');

      expect(
        isReportDeadlineClosed(
          DateTime.parse('2026-03-27T12:00:00+09:00'),
          now: now,
        ),
        isTrue,
      );
    });

    test('마감 시각이 남아 있으면 아직 열려 있다', () {
      final now = DateTime.parse('2026-03-27T02:59:59Z');

      expect(
        isReportDeadlineClosed(
          DateTime.parse('2026-03-27T12:00:00+09:00'),
          now: now,
        ),
        isFalse,
      );
    });
  });
}
