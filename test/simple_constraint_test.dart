import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  group('Simple Constraint Tests', () {
    testWidgets('Basic functionality test - no crashes', (WidgetTester tester) async {
      // 测试基本功能不会崩溃
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WContainer(
                  className: 'min-w-100 max-w-200 bg-blue-500 p-4',
                  child: Text('Width Constraint Test'),
                ),
                WContainer(
                  className: 'min-h-50 max-h-100 bg-red-500 p-4',
                  child: Text('Height Constraint Test'),
                ),
                WContainer(
                  className: 'min-w-50 max-w-150 min-h-30 max-h-80 bg-green-500 p-4',
                  child: Text('Combined Constraint Test'),
                ),
                WContainer(
                  className: 'bg-yellow-500 p-4',
                  child: Text('No Constraint Test'),
                ),
              ],
            ),
          ),
        ),
      );

      // 验证所有文本都能正常显示
      expect(find.text('Width Constraint Test'), findsOneWidget);
      expect(find.text('Height Constraint Test'), findsOneWidget);
      expect(find.text('Combined Constraint Test'), findsOneWidget);
      expect(find.text('No Constraint Test'), findsOneWidget);
      
      // 验证没有异常抛出
      await tester.pumpAndSettle();
    });

    testWidgets('Edge cases test - zero and extreme values', (WidgetTester tester) async {
      // 测试边界情况
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WContainer(
                  className: 'min-w-0 max-w-0 bg-blue-500',
                  child: Text('Zero Width'),
                ),
                WContainer(
                  className: 'min-h-0 max-h-0 bg-red-500',
                  child: Text('Zero Height'),
                ),
                WContainer(
                  className: 'min-w-1000 max-w-2000 bg-green-500 p-2',
                  child: Text('Large Width'),
                ),
              ],
            ),
          ),
        ),
      );

      // 验证没有崩溃
      expect(find.text('Zero Width'), findsOneWidget);
      expect(find.text('Zero Height'), findsOneWidget);
      expect(find.text('Large Width'), findsOneWidget);
      
      await tester.pumpAndSettle();
    });

    testWidgets('Mixed constraints test', (WidgetTester tester) async {
      // 测试混合约束
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'min-w-100 max-w-300 min-h-50 max-h-200 bg-purple-500 p-4 m-2',
              child: Column(
                children: [
                  Text('Mixed Constraints'),
                  WContainer(
                    className: 'min-w-50 bg-orange-500 p-2',
                    child: Text('Nested Container'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Mixed Constraints'), findsOneWidget);
      expect(find.text('Nested Container'), findsOneWidget);
      
      await tester.pumpAndSettle();
    });
  });
}