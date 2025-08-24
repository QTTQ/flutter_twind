import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  group('简化约束测试', () {
    setUpAll(() {
      WindConfig.initialize();
    });

    testWidgets('WContainer 基础约束测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 测试固定高度
                WContainer(
                  className: 'p-4 bg-blue-100',
                  height: 100,
                  child: const Text('固定高度测试'),
                ),
                // 测试约束范围
                WContainer(
                  className: 'p-4 bg-green-100',
                  constraints: const BoxConstraints(
                    minHeight: 50,
                    maxHeight: 200,
                  ),
                  child: const Text('约束范围测试'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('固定高度测试'), findsOneWidget);
      expect(find.text('约束范围测试'), findsOneWidget);
    });

    testWidgets('WStack 基础约束测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 150,
              child: WStack(
                className: 'bg-yellow-100 p-4',
                children: [
                  Container(
                    color: Colors.red,
                    width: 80,
                    height: 80,
                  ),
                  const Positioned(
                    bottom: 10,
                    right: 10,
                    child: Text('Stack 测试'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('Stack 测试'), findsOneWidget);
    });

    testWidgets('边界条件测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 测试零尺寸
                WContainer(
                  className: 'bg-red-100',
                  width: 0,
                  height: 0,
                  child: const Text('零尺寸'),
                ),
                // 测试负数约束处理
                WContainer(
                  className: 'bg-green-100 p-4',
                  constraints: const BoxConstraints(
                    minWidth: -10, // 应该被处理为0
                    minHeight: -10, // 应该被处理为0
                  ),
                  child: const Text('负数约束'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('零尺寸'), findsOneWidget);
      expect(find.text('负数约束'), findsOneWidget);
    });

    testWidgets('Expanded 中的约束测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: WContainer(
                    className: 'p-4 bg-purple-100',
                    child: const Center(
                      child: Text('Expanded 容器'),
                    ),
                  ),
                ),
                WContainer(
                  className: 'p-4 bg-orange-100',
                  height: 100,
                  child: const Text('固定容器'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('Expanded 容器'), findsOneWidget);
      expect(find.text('固定容器'), findsOneWidget);
    });

    testWidgets('ListView 约束测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                WContainer(
                  className: 'p-4 m-2 bg-blue-100 rounded-lg',
                  height: 100,
                  child: const Text('ListView 项目 1'),
                ),
                WContainer(
                  className: 'p-4 m-2 bg-red-100 rounded-lg',
                  height: 120,
                  child: const Text('ListView 项目 2'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('ListView 项目 1'), findsOneWidget);
      expect(find.text('ListView 项目 2'), findsOneWidget);
    });
  });
}