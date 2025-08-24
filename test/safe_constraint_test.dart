import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/wind_components.dart';

void main() {
  group('安全约束测试', () {
    testWidgets('基本约束功能 - 无崩溃', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 基本宽度约束
                WContainer(
                  className: 'min-w-100',
                  child: const Text('最小宽度100'),
                ),
                
                // 基本高度约束
                WContainer(
                  className: 'min-h-50',
                  child: const Text('最小高度50'),
                ),
                
                // 组合约束
                WContainer(
                  className: 'min-w-100 max-w-200',
                  child: const Text('宽度约束100-200'),
                ),
                
                // 无约束对照
                WContainer(
                  className: 'bg-blue-500 p-4',
                  child: const Text('无约束'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pump();
      
      // 验证所有组件都正常渲染
      expect(find.text('最小宽度100'), findsOneWidget);
      expect(find.text('最小高度50'), findsOneWidget);
      expect(find.text('宽度约束100-200'), findsOneWidget);
      expect(find.text('无约束'), findsOneWidget);
      
      print('✅ 安全约束测试通过！');
    });

    testWidgets('边界值测试 - 零值和极值', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 零值测试
                WContainer(
                  className: 'min-w-0 min-h-0',
                  child: const Text('零值约束'),
                ),
                
                // 大值测试
                WContainer(
                  className: 'min-w-500 max-w-600',
                  child: const Text('大值约束'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pump();
      
      expect(find.text('零值约束'), findsOneWidget);
      expect(find.text('大值约束'), findsOneWidget);
      
      print('✅ 边界值测试通过！');
    });
  });
}