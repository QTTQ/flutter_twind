import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  group('Comprehensive Constraint Tests', () {
    testWidgets('Min/Max width constraints', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'min-w-100 max-w-200',
              child: Text('Width Test'),
            ),
          ),
        ),
      );

      expect(find.text('Width Test'), findsOneWidget);
      
      // 验证 ConstrainedBox 存在
      expect(find.byType(ConstrainedBox), findsOneWidget);
    });

    testWidgets('Min/Max height constraints', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'min-h-50 max-h-100',
              child: Text('Height Test'),
            ),
          ),
        ),
      );

      expect(find.text('Height Test'), findsOneWidget);
      expect(find.byType(ConstrainedBox), findsOneWidget);
    });

    testWidgets('Combined width and height constraints', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'min-w-100 max-w-200 min-h-50 max-h-100 bg-blue-500',
              child: Text('Combined Test'),
            ),
          ),
        ),
      );

      expect(find.text('Combined Test'), findsOneWidget);
      expect(find.byType(ConstrainedBox), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('No constraints should not create ConstrainedBox', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'bg-red-500 p-4',
              child: Text('No Constraints'),
            ),
          ),
        ),
      );

      expect(find.text('No Constraints'), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
      // 应该没有 ConstrainedBox
      expect(find.byType(ConstrainedBox), findsNothing);
    });

    testWidgets('Edge case: zero values', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'min-w-0 min-h-0',
              child: Text('Zero Values'),
            ),
          ),
        ),
      );

      expect(find.text('Zero Values'), findsOneWidget);
      expect(find.byType(ConstrainedBox), findsOneWidget);
    });
  });
}