import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  group('溢出修复测试', () {
    setUpAll(() {
      WindConfig.initialize();
    });

    testWidgets('WColumn 溢出处理测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 测试1: overflow-scroll
                SizedBox(
                  height: 100,
                  child: WColumn(
                    className: 'overflow-scroll',
                    children: List.generate(10, (index) => 
                      Container(
                        height: 50,
                        color: Colors.blue,
                        child: Text('Item $index'),
                      ),
                    ),
                  ),
                ),
                // 测试2: overflow-hidden
                SizedBox(
                  height: 100,
                  child: WColumn(
                    className: 'overflow-hidden',
                    children: List.generate(10, (index) => 
                      Container(
                        height: 50,
                        color: Colors.red,
                        child: Text('Hidden Item $index'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      // 验证组件正常渲染
      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Hidden Item 0'), findsOneWidget);
    });

    testWidgets('WRow 溢出处理测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 测试1: overflow-scroll (水平滚动)
                SizedBox(
                  width: 200,
                  height: 50,
                  child: WRow(
                    className: 'overflow-scroll',
                    children: List.generate(10, (index) => 
                      Container(
                        width: 80,
                        height: 40,
                        color: Colors.green,
                        child: Text('R$index'),
                      ),
                    ),
                  ),
                ),
                // 测试2: overflow-hidden
                SizedBox(
                  width: 200,
                  height: 50,
                  child: WRow(
                    className: 'overflow-hidden',
                    children: List.generate(10, (index) => 
                      Container(
                        width: 80,
                        height: 40,
                        color: Colors.orange,
                        child: Text('H$index'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('R0'), findsOneWidget);
      expect(find.text('H0'), findsOneWidget);
    });

    testWidgets('WContainer 溢出处理测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 测试1: overflow-scroll
                SizedBox(
                  width: 200,
                  height: 100,
                  child: WContainer(
                    className: 'overflow-scroll p-4 bg-blue-100',
                    child: WColumn(
                      children: List.generate(10, (index) => 
                        Container(
                          height: 30,
                          color: Colors.purple,
                          child: Text('Container Item $index'),
                        ),
                      ),
                    ),
                  ),
                ),
                // 测试2: overflow-hidden
                SizedBox(
                  width: 200,
                  height: 100,
                  child: WContainer(
                    className: 'overflow-hidden p-4 bg-red-100',
                    child: WColumn(
                      className: 'overflow-hidden',
                      children: List.generate(10, (index) => 
                        Container(
                          height: 30,
                          color: Colors.teal,
                          child: Text('Hidden Container $index'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('Container Item 0'), findsOneWidget);
      expect(find.text('Hidden Container 0'), findsOneWidget);
    });

    testWidgets('WStack 溢出处理测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 测试1: overflow-scroll
                SizedBox(
                  width: 200,
                  height: 100,
                  child: WStack(
                    className: 'overflow-scroll',
                    children: [
                      Container(
                        width: 300,
                        height: 150,
                        color: Colors.yellow,
                        child: const Text('Large Stack Content'),
                      ),
                      const Positioned(
                        top: 10,
                        left: 10,
                        child: Text('Stack Overlay'),
                      ),
                    ],
                  ),
                ),
                // 测试2: overflow-hidden
                SizedBox(
                  width: 200,
                  height: 100,
                  child: WStack(
                    className: 'overflow-hidden',
                    children: [
                      Container(
                        width: 300,
                        height: 150,
                        color: Colors.pink,
                        child: const Text('Hidden Stack Content'),
                      ),
                      const Positioned(
                        top: 10,
                        left: 10,
                        child: Text('Hidden Overlay'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('Large Stack Content'), findsOneWidget);
      expect(find.text('Stack Overlay'), findsOneWidget);
      expect(find.text('Hidden Stack Content'), findsOneWidget);
      expect(find.text('Hidden Overlay'), findsOneWidget);
    });

    testWidgets('复合溢出场景测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'overflow-scroll p-4',
              child: WColumn(
                className: 'overflow-hidden',
                children: [
                  WRow(
                    className: 'overflow-scroll',
                    children: List.generate(5, (index) => 
                      WContainer(
                        className: 'p-2 m-1 bg-blue-200',
                        width: 100,
                        child: Text('复合 $index'),
                      ),
                    ),
                  ),
                  WStack(
                    className: 'overflow-hidden',
                    children: [
                      Container(
                        width: 400,
                        height: 200,
                        color: Colors.lightGreen,
                        child: const Text('复合 Stack'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('复合 0'), findsOneWidget);
      expect(find.text('复合 Stack'), findsOneWidget);
    });

    testWidgets('边界条件溢出测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 空内容溢出测试
                SizedBox(
                  height: 50,
                  child: WColumn(
                    className: 'overflow-scroll',
                    children: const [],
                  ),
                ),
                // 单个子组件溢出测试
                SizedBox(
                  height: 50,
                  child: WColumn(
                    className: 'overflow-hidden',
                    children: [
                      Container(
                        height: 100,
                        color: Colors.amber,
                        child: const Text('单个大组件'),
                      ),
                    ],
                  ),
                ),
                // 无溢出样式测试
                SizedBox(
                  height: 100,
                  child: WColumn(
                    children: [
                      Container(
                        height: 30,
                        color: Colors.cyan,
                        child: const Text('正常组件'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('单个大组件'), findsOneWidget);
      expect(find.text('正常组件'), findsOneWidget);
    });
  });
}