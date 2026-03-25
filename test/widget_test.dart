import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('기본 Material 위젯을 렌더링한다', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('A&I Report Web Server'),
        ),
      ),
    );

    expect(find.text('A&I Report Web Server'), findsOneWidget);
  });
}
