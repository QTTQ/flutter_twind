import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  setUpAll(() {
    WindConfig.initialize();
  });

  group('Edge Cases and Error Handling Tests', () {
    testWidgets('should handle null and empty className gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WText('No className', className: null),
                WText('Empty className', className: ''),
                WContainer(className: null, child: WText('Container with null className')),
                WContainer(className: '', child: WText('Container with empty className')),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('No className'), findsOneWidget);
      expect(find.text('Empty className'), findsOneWidget);
      expect(find.text('Container with null className'), findsOneWidget);
      expect(find.text('Container with empty className'), findsOneWidget);
    });

    testWidgets('should handle invalid className values', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WText('Invalid class', className: 'invalid-class-name'),
                WText('Multiple spaces', className: '  text-lg   font-bold  '),
                WText('Special chars', className: 'text-lg@#\$%^&*()'),
                WContainer(
                  className: 'bg-nonexistent-color p-4',
                  child: WText('Nonexistent color'),
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Invalid class'), findsOneWidget);
      expect(find.text('Multiple spaces'), findsOneWidget);
      expect(find.text('Special chars'), findsOneWidget);
      expect(find.text('Nonexistent color'), findsOneWidget);
    });

    testWidgets('should handle extreme values', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  WContainer(
                    className: 'p-[9999px] m-[9999px]',
                    child: WText('Extreme padding/margin'),
                  ),
                  WText(
                    'Extreme font size',
                    className: 'text-[999px]',
                  ),
                  WContainer(
                    className: 'w-[99999px] h-[99999px] bg-red-500',
                    child: WText('Extreme dimensions'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      
      expect(find.text('Extreme padding/margin'), findsOneWidget);
      expect(find.text('Extreme font size'), findsOneWidget);
      expect(find.text('Extreme dimensions'), findsOneWidget);
    });

    testWidgets('should handle conflicting styles', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WText(
                  'Conflicting text colors',
                  className: 'text-red-500 text-blue-500 text-green-500',
                ),
                WContainer(
                  className: 'bg-red-500 bg-blue-500 bg-green-500 p-4',
                  child: WText('Conflicting backgrounds'),
                ),
                WText(
                  'Conflicting font sizes',
                  className: 'text-xs text-lg text-2xl',
                ),
                WContainer(
                  className: 'p-2 p-4 p-8 m-1 m-2 m-4',
                  child: WText('Conflicting spacing'),
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Conflicting text colors'), findsOneWidget);
      expect(find.text('Conflicting backgrounds'), findsOneWidget);
      expect(find.text('Conflicting font sizes'), findsOneWidget);
      expect(find.text('Conflicting spacing'), findsOneWidget);
    });

    testWidgets('should handle very long className strings', (WidgetTester tester) async {
      final longClassName = List.generate(100, (i) => 'class-\$i').join(' ');
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WText(
                  'Very long className',
                  className: longClassName,
                ),
                WContainer(
                  className: longClassName,
                  child: WText('Container with long className'),
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Very long className'), findsOneWidget);
      expect(find.text('Container with long className'), findsOneWidget);
    });

    testWidgets('should handle nested components with complex styles', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'bg-gradient-to-r from-purple-500 to-pink-500 p-8',
              child: WCard(
                className: 'bg-white/90 backdrop-blur-sm p-6 rounded-xl shadow-2xl',
                child: WColumn(
                  children: [
                    WText(
                      'Nested Complex Styles',
                      className: 'text-2xl font-bold text-gray-800 mb-4',
                    ),
                    WFlex(
                      className: 'flex-row justify-between items-center gap-4',
                      children: [
                        WContainer(
                          className: 'flex-1 bg-gradient-to-br from-blue-400 to-blue-600 p-4 rounded-lg',
                          child: WText(
                            'Nested Gradient 1',
                            className: 'text-white font-semibold text-center',
                          ),
                        ),
                        WContainer(
                          className: 'flex-1 bg-gradient-to-br from-green-400 to-green-600 p-4 rounded-lg',
                          child: WText(
                            'Nested Gradient 2',
                            className: 'text-white font-semibold text-center',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      
      expect(find.text('Nested Complex Styles'), findsOneWidget);
      expect(find.text('Nested Gradient 1'), findsOneWidget);
      expect(find.text('Nested Gradient 2'), findsOneWidget);
    });

    testWidgets('should handle rapid style changes', (WidgetTester tester) async {
      String currentClass = 'text-red-500';
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    WText(
                      'Dynamic Style Text',
                      className: currentClass,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentClass = currentClass == 'text-red-500' 
                              ? 'text-blue-500 text-2xl font-bold' 
                              : 'text-red-500';
                        });
                      },
                      child: Text('Change Style'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
      
      expect(find.text('Dynamic Style Text'), findsOneWidget);
      
      // 测试样式变化
      await tester.tap(find.text('Change Style'));
      await tester.pump();
      
      expect(find.text('Dynamic Style Text'), findsOneWidget);
      
      // 再次变化
      await tester.tap(find.text('Change Style'));
      await tester.pump();
      
      expect(find.text('Dynamic Style Text'), findsOneWidget);
    });

    testWidgets('should handle memory stress with many components', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: WColumn(
                children: List.generate(50, (index) => 
                  WContainer(
                    className: 'bg-blue-${(index % 9 + 1) * 100} p-2 m-1 rounded',
                    child: WText(
                      'Component $index',
                      className: 'text-white font-semibold text-center',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      
      // 验证第一个和最后一个组件
      expect(find.text('Component 0'), findsOneWidget);
      expect(find.text('Component 49'), findsOneWidget);
      
      // 验证中间的一些组件
      expect(find.text('Component 25'), findsOneWidget);
    });
  });

  group('Accessibility and Usability Tests', () {
    testWidgets('should maintain accessibility with custom styles', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WText(
                  'Accessible Text',
                  className: 'text-lg font-semibold text-gray-800',
                ),
                WButton(
                  text: 'Accessible Button',
                  onPressed: () {},
                  className: 'bg-blue-500 text-white p-4 rounded-lg',
                ),
                WContainer(
                  className: 'bg-gray-100 p-4 rounded border',
                  child: WText(
                    'Container with good contrast',
                    className: 'text-gray-800',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Accessible Text'), findsOneWidget);
      expect(find.text('Accessible Button'), findsOneWidget);
      expect(find.text('Container with good contrast'), findsOneWidget);
    });

    testWidgets('should handle text overflow properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                SizedBox(
                  width: 100,
                  child: WText(
                    'This is a very long text that should overflow',
                    className: 'overflow-ellipsis',
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: WText(
                    'This is another very long text that should wrap to multiple lines',
                    className: 'text-sm',
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.textContaining('This is a very long'), findsOneWidget);
      expect(find.textContaining('This is another very long'), findsOneWidget);
    });
  });
}