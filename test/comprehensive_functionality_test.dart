import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/wind_components.dart';

void main() {
  group('全面功能测试', () {
    testWidgets('基础组件功能测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 基本容器
                WContainer(
                  className: 'bg-blue-500 p-4',
                  child: const Text('基本容器'),
                ),
                
                // 文本组件
                WText(
                  '基本文本',
                  className: 'text-lg text-red-500',
                ),
                
                // 按钮组件
                WButton(
                  text: '基本按钮',
                  onPressed: () {},
                  className: 'bg-green-500 p-2',
                ),
                
                // 行组件
                WRow(
                  className: 'justify-center items-center',
                  children: const [
                    Text('行1'),
                    Text('行2'),
                  ],
                ),
                
                // 列组件
                WColumn(
                  className: 'items-center',
                  children: const [
                    Text('列1'),
                    Text('列2'),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pump();
      
      // 验证所有组件都正常渲染
      expect(find.text('基本容器'), findsOneWidget);
      expect(find.text('基本文本'), findsOneWidget);
      expect(find.text('基本按钮'), findsOneWidget);
      expect(find.text('行1'), findsOneWidget);
      expect(find.text('行2'), findsOneWidget);
      expect(find.text('列1'), findsOneWidget);
      expect(find.text('列2'), findsOneWidget);
      
      print('✅ 基础组件功能测试通过！');
    });

    testWidgets('样式解析功能测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 背景色测试
                WContainer(
                  className: 'bg-red-500',
                  child: const Text('红色背景'),
                ),
                
                // 内边距测试
                WContainer(
                  className: 'p-4',
                  child: const Text('内边距'),
                ),
                
                // 外边距测试
                WContainer(
                  className: 'm-4',
                  child: const Text('外边距'),
                ),
                
                // 圆角测试
                WContainer(
                  className: 'rounded-lg',
                  child: const Text('圆角'),
                ),
                
                // 阴影测试
                WContainer(
                  className: 'shadow-md',
                  child: const Text('阴影'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pump();
      
      expect(find.text('红色背景'), findsOneWidget);
      expect(find.text('内边距'), findsOneWidget);
      expect(find.text('外边距'), findsOneWidget);
      expect(find.text('圆角'), findsOneWidget);
      expect(find.text('阴影'), findsOneWidget);
      
      print('✅ 样式解析功能测试通过！');
    });

    testWidgets('布局功能测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // Flex 布局
                WContainer(
                  className: 'flex flex-row justify-between',
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('左'),
                      Text('右'),
                    ],
                  ),
                ),
                
                // 居中布局
                WContainer(
                  className: 'flex items-center justify-center',
                  child: const Text('居中'),
                ),
                
                // 尺寸设置
                WContainer(
                  className: 'w-32 h-16',
                  child: const Text('固定尺寸'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pump();
      
      expect(find.text('左'), findsOneWidget);
      expect(find.text('右'), findsOneWidget);
      expect(find.text('居中'), findsOneWidget);
      expect(find.text('固定尺寸'), findsOneWidget);
      
      print('✅ 布局功能测试通过！');
    });

    testWidgets('交互功能测试', (WidgetTester tester) async {
      bool buttonPressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 按钮点击测试
                WButton(
                  text: '点击测试',
                  onPressed: () {
                    buttonPressed = true;
                  },
                  className: 'bg-blue-500 p-4',
                ),
                
                // 容器点击测试
                WContainer(
                  className: 'bg-green-500 p-4',
                  child: const Text('容器测试'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pump();
      
      // 测试按钮点击
      await tester.tap(find.text('点击测试'));
      expect(buttonPressed, isTrue);
      
      expect(find.text('点击测试'), findsOneWidget);
      expect(find.text('容器测试'), findsOneWidget);
      
      print('✅ 交互功能测试通过！');
    });

    testWidgets('复杂嵌套测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'bg-gray-100 p-4',
              child: WColumn(
                className: 'items-center',
                children: [
                  WContainer(
                    className: 'bg-white rounded-lg shadow-md p-4 m-2',
                    child: WRow(
                      className: 'justify-between items-center',
                      children: [
                        WText(
                          '嵌套测试',
                          className: 'text-lg font-bold',
                        ),
                        WButton(
                          text: '按钮',
                          onPressed: () {},
                          className: 'bg-blue-500 px-4 py-2 rounded',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      
      expect(find.text('嵌套测试'), findsOneWidget);
      expect(find.text('按钮'), findsOneWidget);
      
      print('✅ 复杂嵌套测试通过！');
    });

    testWidgets('边界情况测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 空类名
                WContainer(
                  className: '',
                  child: const Text('空类名'),
                ),
                
                // null 类名
                WContainer(
                  className: null,
                  child: const Text('null类名'),
                ),
                
                // 无效类名
                WContainer(
                  className: 'invalid-class-name-123',
                  child: const Text('无效类名'),
                ),
                
                // 空子组件
                WContainer(
                  className: 'bg-blue-500 p-4',
                  child: null,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pump();
      
      expect(find.text('空类名'), findsOneWidget);
      expect(find.text('null类名'), findsOneWidget);
      expect(find.text('无效类名'), findsOneWidget);
      
      print('✅ 边界情况测试通过！');
    });
  });
}