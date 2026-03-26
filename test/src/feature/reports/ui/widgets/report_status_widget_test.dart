import 'package:a_and_i_report_web_server/src/feature/reports/ui/widgets/report_status_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReportStatueType.fromEndAt', () {
    test('마감이 8시간 남아 있으면 진행중 상태를 반환한다', () {
      final endAt = DateTime.now().toUtc().add(const Duration(hours: 8));

      expect(
        ReportStatueType.fromEndAt(endAt),
        ReportStatueType.progress,
      );
    });

    test('마감이 지난 경우 종료 상태를 반환한다', () {
      final endAt = DateTime.now().toUtc().subtract(const Duration(minutes: 1));

      expect(
        ReportStatueType.fromEndAt(endAt),
        ReportStatueType.done,
      );
    });
  });
}
