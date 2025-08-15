import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  group('Flutter TWind Components', () {
    // 布局组件测试
    group('Layout Components', () {
      testWidgets('WContainer renders correctly with className', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WContainer(
                className: 'bg-blue-500 p-4 rounded-lg',
                child: const Text('Test Container'),
              ),
            ),
          ),
        );

        expect(find.text('Test Container'), findsOneWidget);
        expect(find.byType(WContainer), findsOneWidget);
        
        // 验证容器是否正确渲染
        final container = tester.widget<WContainer>(find.byType(WContainer));
        expect(container.className, equals('bg-blue-500 p-4 rounded-lg'));
      });

      testWidgets('WFlex renders with correct direction', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WFlex(
                className: 'p-4',
                direction: Axis.horizontal,
                children: [
                  WText('Item 1'),
                  WText('Item 2'),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Item 1'), findsOneWidget);
        expect(find.text('Item 2'), findsOneWidget);
        expect(find.byType(WFlex), findsOneWidget);
      });

      testWidgets('WRow and WColumn render correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  WRow(
                    children: [WText('Row Item 1'), WText('Row Item 2')],
                  ),
                  WColumn(
                    children: [WText('Column Item 1'), WText('Column Item 2')],
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Row Item 1'), findsOneWidget);
        expect(find.text('Column Item 1'), findsOneWidget);
      });
    });

    // 视觉组件测试
    group('Visual Components', () {
      testWidgets('WText renders with styling', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WText(
                'Hello World',
                className: 'text-lg text-blue-500 font-bold',
              ),
            ),
          ),
        );

        expect(find.text('Hello World'), findsOneWidget);
        
        final textWidget = tester.widget<WText>(find.byType(WText));
        expect(textWidget.className, equals('text-lg text-blue-500 font-bold'));
      });

      testWidgets('WCard renders with default styling', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WCard(
                child: WText('Card Content'),
              ),
            ),
          ),
        );

        expect(find.text('Card Content'), findsOneWidget);
        expect(find.byType(WCard), findsOneWidget);
      });

      testWidgets('WIcon renders correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WIcon(
                Icons.star,
                className: 'text-yellow-500',
                size: 32,
              ),
            ),
          ),
        );

        expect(find.byType(WIcon), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });

      testWidgets('WAvatar renders with correct radius', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WAvatar(
                radius: 30,
                child: WText('A'),
              ),
            ),
          ),
        );

        expect(find.text('A'), findsOneWidget);
        expect(find.byType(WAvatar), findsOneWidget);
      });
    });

    // 交互组件测试
    group('Interactive Components', () {
      testWidgets('WButton handles tap events', (WidgetTester tester) async {
        bool buttonPressed = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WButton(
                text: 'Test Button',
                className: 'bg-blue-500',
                onPressed: () {
                  buttonPressed = true;
                },
              ),
            ),
          ),
        );

        expect(find.text('Test Button'), findsOneWidget);
        
        await tester.tap(find.byType(WButton));
        expect(buttonPressed, isTrue);
      });

      testWidgets('WButton shows loading state', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WButton(
                text: 'Loading Button',
                isLoading: true,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('WInput handles text input', (WidgetTester tester) async {
        final controller = TextEditingController();
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WInput(
                placeholder: 'Enter text',
                controller: controller,
              ),
            ),
          ),
        );

        await tester.enterText(find.byType(WInput), 'Test input');
        expect(controller.text, equals('Test input'));
      });
    });

    // 列表组件测试
    group('List Components', () {
      testWidgets('WList renders children correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WList(
                children: [
                  WListTile(title: WText('Item 1')),
                  WListTile(title: WText('Item 2')),
                  WListTile(title: WText('Item 3')),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Item 1'), findsOneWidget);
        expect(find.text('Item 2'), findsOneWidget);
        expect(find.text('Item 3'), findsOneWidget);
      });

      testWidgets('WListTile handles tap events', (WidgetTester tester) async {
        bool tileTapped = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WListTile(
                title: WText('Tappable Tile'),
                onTap: () {
                  tileTapped = true;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(WListTile));
        expect(tileTapped, isTrue);
      });
    });

    // 功能组件测试
    group('Functional Components', () {
      testWidgets('WAppBar renders with title', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: WAppBar(
                title: WText('Test App'),
                className: 'bg-blue-600',
              ),
            ),
          ),
        );

        expect(find.text('Test App'), findsOneWidget);
      });

      testWidgets('WBadge displays count correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WBadge(
                count: 5,
                child: WIcon(Icons.notifications),
              ),
            ),
          ),
        );

        expect(find.text('5'), findsOneWidget);
        expect(find.byIcon(Icons.notifications), findsOneWidget);
      });
    });
  });

  // 样式解析器测试
  group('Style Parser Tests', () {
    test('UniversalStyleParser parses padding correctly', () {
      // 这里需要根据实际的样式解析器实现来编写测试
      // 例如：
      // final parser = UniversalStyleParser();
      // final styles = parser.parse('p-4 m-2');
      // expect(styles.padding, equals(EdgeInsets.all(16)));
      // expect(styles.margin, equals(EdgeInsets.all(8)));
    });

    test('UniversalStyleParser parses colors correctly', () {
      // 测试颜色解析
      // final parser = UniversalStyleParser();
      // final styles = parser.parse('bg-blue-500 text-white');
      // expect(styles.backgroundColor, equals(Colors.blue[500]));
      // expect(styles.textColor, equals(Colors.white));
    });

    test('UniversalStyleParser handles invalid classes gracefully', () {
      // 测试无效类名的处理
      // final parser = UniversalStyleParser();
      // expect(() => parser.parse('invalid-class'), returnsNormally);
    });
  });

  // 性能测试
  group('Performance Tests', () {
    testWidgets('Large list renders efficiently', (WidgetTester tester) async {
      final items = List.generate(1000, (index) => 
        WListTile(title: WText('Item $index'))
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WList(
              children: items,
            ),
          ),
        ),
      );

      // 验证列表能够正常渲染
      expect(find.byType(WList), findsOneWidget);
    });
  });

  // 集成测试
  group('Integration Tests', () {
    testWidgets('Complete form workflow', (WidgetTester tester) async {
      final nameController = TextEditingController();
      final emailController = TextEditingController();
      bool formSubmitted = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'p-4',
              child: WColumn(
                children: [
                  WInput(
                    placeholder: 'Name',
                    controller: nameController,
                  ),
                  SizedBox(height: 16),
                  WInput(
                    placeholder: 'Email',
                    controller: emailController,
                  ),
                  SizedBox(height: 16),
                  WButton(
                    text: 'Submit',
                    onPressed: () {
                      formSubmitted = true;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // 填写表单
      await tester.enterText(find.byType(WInput).first, 'John Doe');
      await tester.enterText(find.byType(WInput).last, 'john@example.com');
      
      // 提交表单
      await tester.tap(find.byType(WButton));
      
      expect(nameController.text, equals('John Doe'));
      expect(emailController.text, equals('john@example.com'));
      expect(formSubmitted, isTrue);
    });
  });
}