import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  group('约束验证测试', () {
    setUpAll(() {
      WindConfig.initialize();
    });

    testWidgets('WContainer 约束安全性测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 测试1: 无限高度约束
                Expanded(
                  child: WContainer(
                    className: 'p-4 bg-blue-100',
                    child: const Text('无限高度测试'),
                  ),
                ),
                // 测试2: 固定高度约束
                WContainer(
                  className: 'p-4 bg-red-100',
                  height: 100,
                  child: const Text('固定高度测试'),
                ),
                // 测试3: 最小/最大约束
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
      
      // 验证组件是否正常渲染
      expect(find.text('无限高度测试'), findsOneWidget);
      expect(find.text('固定高度测试'), findsOneWidget);
      expect(find.text('约束范围测试'), findsOneWidget);
    });

    testWidgets('WStack 约束安全性测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 测试1: Stack 在 Expanded 中
                Expanded(
                  child: WStack(
                    className: 'bg-gray-100',
                    children: [
                      Container(
                        color: Colors.blue,
                        width: 100,
                        height: 100,
                      ),
                      const Positioned(
                        top: 10,
                        left: 10,
                        child: Text('Stack 测试'),
                      ),
                    ],
                  ),
                ),
                // 测试2: Stack 在固定容器中
                SizedBox(
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
                        child: Text('固定 Stack'),
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
      
      expect(find.text('Stack 测试'), findsOneWidget);
      expect(find.text('固定 Stack'), findsOneWidget);
    });

    testWidgets('WImage 约束安全性测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 测试1: Image 在 Stack 中
                SizedBox(
                  height: 200,
                  child: WStack(
                    children: [
                      WImage(
                        image: const AssetImage('test_assets/test_image.png'),
                        fit: BoxFit.cover,
                      ),
                      const Positioned(
                        top: 10,
                        left: 10,
                        child: Text('图片覆盖层'),
                      ),
                    ],
                  ),
                ),
                // 测试2: Image 在 Expanded 中
                Expanded(
                  child: WImage(
                    image: const AssetImage('test_assets/test_image.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                // 测试3: 固定尺寸 Image
                WImage(
                  image: const AssetImage('test_assets/test_image.png'),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('图片覆盖层'), findsOneWidget);
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
                          className: 'p-6 bg-gradient-to-r from-blue-500 to-purple-600',
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              WImage(
                                image: const AssetImage('test_assets/test_image.png'),
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 16),
                              const Text('复杂嵌套测试'),
                            ],
                          ),
                        ),
                        const Positioned(
                          bottom: 16,
                          right: 16,
                          child: Icon(Icons.favorite, color: Colors.red),
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
      
      expect(find.text('复杂嵌套测试'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('边界条件约束测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // 测试1: 零尺寸约束
                  WContainer(
                    className: 'bg-red-100',
                    width: 0,
                    height: 0,
                    child: const Text('零尺寸'),
                  ),
                  // 测试2: 极大尺寸约束
                  WContainer(
                    className: 'bg-blue-100',
                    constraints: const BoxConstraints(
                      maxWidth: 10000,
                      maxHeight: 10000,
                    ),
                    child: const Text('极大尺寸'),
                  ),
                  // 测试3: 负数约束处理
                  WContainer(
                    className: 'bg-green-100',
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
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('零尺寸'), findsOneWidget);
      expect(find.text('极大尺寸'), findsOneWidget);
      expect(find.text('负数约束'), findsOneWidget);
    });

    testWidgets('ListView 中的约束测试', (WidgetTester tester) async {
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
                SizedBox(
                  height: 150,
                  child: WStack(
                    className: 'bg-red-100 m-2 rounded-lg',
                    children: [
                      Container(
                        color: Colors.orange,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      const Center(
                        child: Text('ListView Stack'),
                      ),
                    ],
                  ),
                ),
                WContainer(
                  className: 'p-4 m-2 bg-green-100 rounded-lg',
                  child: WImage(
                    image: const AssetImage('test_assets/test_image.png'),
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('ListView 项目 1'), findsOneWidget);
      expect(find.text('ListView Stack'), findsOneWidget);
    });

    testWidgets('GridView 中的约束测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return WContainer(
                  className: 'p-2 m-1 bg-purple-100 rounded-lg',
                  child: WStack(
                    children: [
                      Container(
                        color: Colors.cyan,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Center(
                        child: Text('Grid $index'),
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
      
      expect(find.text('Grid 0'), findsOneWidget);
      expect(find.text('Grid 1'), findsOneWidget);
    });

    testWidgets('动态约束变化测试', (WidgetTester tester) async {
      bool isExpanded = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: isExpanded ? 200 : 100,
                      child: WStack(
                        className: 'bg-orange-100',
                        children: [
                          Container(
                            color: Colors.teal,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          const Center(
                            child: Text('动态约束'),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: const Text('切换尺寸'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('动态约束'), findsOneWidget);
      
      // 触发尺寸变化
      await tester.tap(find.text('切换尺寸'));
      await tester.pumpAndSettle();
      
      expect(find.text('动态约束'), findsOneWidget);
    });
  });

  group('样式解析约束测试', () {
    testWidgets('className 约束样式测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WContainer(
                  className: 'w-full h-32 bg-blue-500',
                  child: const Text('全宽固定高度'),
                ),
                WContainer(
                  className: 'min-h-16 max-h-64 bg-red-500',
                  child: const Text('最小最大高度'),
                ),
                WContainer(
                  className: 'w-64 h-64 bg-green-500',
                  child: const Text('固定宽高'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('全宽固定高度'), findsOneWidget);
      expect(find.text('最小最大高度'), findsOneWidget);
      expect(find.text('固定宽高'), findsOneWidget);
    });
  });
}