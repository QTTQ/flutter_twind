import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  group('Constraint Tests', () {
    testWidgets('Basic constraint test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'min-w-100 max-w-200 bg-blue-500',
              child: Text('Test'),
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('Simple container without constraints', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'bg-red-500 p-4',
              child: Text('Simple Test'),
            ),
          ),
        ),
      );

      expect(find.text('Simple Test'), findsOneWidget);
    });
  });
}
