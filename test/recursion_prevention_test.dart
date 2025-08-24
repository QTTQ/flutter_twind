import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  group('递归检测测试', () {
    setUpAll(() {
      WindConfig.initialize();
    });

    testWidgets('嵌套 LayoutBuilder 递归检测测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                return WContainer(
                  className: 'p-4 bg-blue-100',
                  height: 200,
                  child: WStack(
                    className: 'bg-red-100 p-2',
                    children: [
                      WContainer(
                        className: 'p-2 bg-green-100',
                        child: const Text('嵌套测试'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('嵌套测试'), findsOneWidget);
    });

    testWidgets('复杂嵌套约束测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: WContainer(
                    className: 'p-4 bg-purple-100',
                    child: WStack(
                      className: 'bg-white rounded-lg shadow-md',
                      children: [
                        WContainer(
                          className: 'p-6 bg-blue-100',
                          child: WStack(
                            className: 'bg-yellow-100',
                            children: [
                              Container(
                                color: Colors.orange,
                                width: 100,
                                height: 100,
                              ),
                              const Positioned(
                                top: 10,
                                left: 10,
                                child: Text('深度嵌套'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('深度嵌套'), findsOneWidget);
    });

    testWidgets('响应式约束测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OrientationBuilder(
              builder: (context, orientation) {
                return WContainer(
                  className: 'p-4 bg-gray-100',
                  child: WStack(
                    className: 'bg-white rounded-lg',
                    children: [
                      Container(
                        color: Colors.blue,
                        width: orientation == Orientation.portrait ? 200 : 300,
                        height: orientation == Orientation.portrait ? 300 : 200,
                      ),
                      const Center(
                        child: Text('响应式测试'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('响应式测试'), findsOneWidget);
    });
  });
}