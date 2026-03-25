import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:a_and_i_report_web_server/src/feature/promotion/ui/faq_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('FAQPage renders correctly', (WidgetTester tester) async {
    // Build the FAQPage widget.
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: FAQPage()),
      ),
    );

    // Verify that the title is displayed.
    expect(find.text('자주 묻는 질문'), findsOneWidget);
    expect(
      find.text('신규 동아리원 모집 중 가장 자주 묻는 질문에 대한 답변입니다.'),
      findsOneWidget,
    );
    await tester.pumpAndSettle();

    // Verify that FAQ items are displayed (at least the questions).
    expect(
      find.text('재학생만 지원 가능한가요? 휴학생이나 졸업생도 지원할 수 있나요?'),
      findsOneWidget,
    );
    expect(find.text('정기 모임은 언제, 어디서 진행되나요?'), findsOneWidget);

    // Tap on the first item to expand it.
    await tester.tap(find.byType(ExpansionTile).first);
    await tester.pumpAndSettle();

    // Verify that the answer is displayed after expansion.
    expect(
      find.textContaining('재학생과 휴학생은 물론 졸업생까지'),
      findsOneWidget,
    );
  });
}
