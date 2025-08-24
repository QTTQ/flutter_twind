import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  group('基础约束测试', () {
    setUpAll(() {
      WindConfig.initialize();
    });

    testWidgets('WContainer 基础功能测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'p-4 bg-blue-100',
              height: 100,
              child: const Text('测试文本'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('测试文本'), findsOneWidget);
    });

    testWidgets('WStack 基础功能测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 100,
              child: WStack(
                children: [
                  Container(color: Colors.red, width: 50, height: 50),
                  const Text('Stack 文本'),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Stack 文本'), findsOneWidget);
    });
  });
}