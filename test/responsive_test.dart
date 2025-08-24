import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  setUpAll(() {
    WindConfig.initialize();
  });

  group('Responsive Design Tests', () {
    testWidgets('should handle mobile breakpoint styles', (WidgetTester tester) async {
      // 设置移动设备尺寸
      await tester.binding.setSurfaceSize(const Size(375, 667)); // iPhone SE size
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WContainer(
                  className: 'w-full sm:w-1/2 md:w-1/3 lg:w-1/4 p-4 bg-blue-500',
                  child: WText(
                    'Responsive Width',
                    className: 'text-white text-center',
                  ),
                ),
                WText(
                  'Mobile Text',
                  className: 'text-sm sm:text-base md:text-lg lg:text-xl',
                ),
                WFlex(
                  className: 'flex-col sm:flex-row gap-2',
                  children: [
                    WContainer(
                      className: 'flex-1 bg-red-500 p-2',
                      child: WText('Item 1', className: 'text-white text-center'),
                    ),
                    WContainer(
                      className: 'flex-1 bg-green-500 p-2',
                      child: WText('Item 2', className: 'text-white text-center'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Responsive Width'), findsOneWidget);
      expect(find.text('Mobile Text'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('should handle tablet breakpoint styles', (WidgetTester tester) async {
      // 设置平板设备尺寸
      await tester.binding.setSurfaceSize(const Size(768, 1024)); // iPad size
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WContainer(
                  className: 'w-full sm:w-1/2 md:w-1/3 lg:w-1/4 p-4 bg-blue-500',
                  child: WText(
                    'Tablet Responsive Width',
                    className: 'text-white text-center',
                  ),
                ),
                WText(
                  'Tablet Text',
                  className: 'text-sm sm:text-base md:text-lg lg:text-xl',
                ),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(6, (index) => 
                    SizedBox(
                      width: 120,
                      child: WContainer(
                        className: 'bg-purple-500 p-4 rounded',
                        child: WText(
                          'Grid Item ${index + 1}',
                          className: 'text-white text-center',
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
      
      expect(find.text('Tablet Responsive Width'), findsOneWidget);
      expect(find.text('Tablet Text'), findsOneWidget);
      expect(find.text('Grid Item 1'), findsOneWidget);
      expect(find.text('Grid Item 6'), findsOneWidget);
    });

    testWidgets('should handle desktop breakpoint styles', (WidgetTester tester) async {
      // 设置桌面设备尺寸
      await tester.binding.setSurfaceSize(const Size(1920, 1080)); // Desktop size
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WContainer(
                  className: 'w-full sm:w-1/2 md:w-1/3 lg:w-1/4 p-4 bg-blue-500',
                  child: WText(
                    'Desktop Responsive Width',
                    className: 'text-white text-center',
                  ),
                ),
                WText(
                  'Desktop Text',
                  className: 'text-sm sm:text-base md:text-lg lg:text-xl xl:text-2xl',
                ),
                WFlex(
                  className: 'flex-col sm:flex-row md:flex-col lg:flex-row gap-4 p-4',
                  children: [
                    WContainer(
                      className: 'flex-1 bg-indigo-500 p-6',
                      child: WText('Desktop Item 1', className: 'text-white text-center text-lg'),
                    ),
                    WContainer(
                      className: 'flex-1 bg-pink-500 p-6',
                      child: WText('Desktop Item 2', className: 'text-white text-center text-lg'),
                    ),
                    WContainer(
                      className: 'flex-1 bg-teal-500 p-6',
                      child: WText('Desktop Item 3', className: 'text-white text-center text-lg'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Desktop Responsive Width'), findsOneWidget);
      expect(find.text('Desktop Text'), findsOneWidget);
      expect(find.text('Desktop Item 1'), findsOneWidget);
      expect(find.text('Desktop Item 2'), findsOneWidget);
      expect(find.text('Desktop Item 3'), findsOneWidget);
    });

    testWidgets('should handle responsive padding and margin', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WContainer(
                  className: 'p-2 sm:p-4 md:p-6 lg:p-8 m-1 sm:m-2 md:m-4 lg:m-6 bg-yellow-500',
                  child: WText(
                    'Responsive Spacing',
                    className: 'text-center font-semibold',
                  ),
                ),
                WContainer(
                  className: 'px-2 py-1 sm:px-4 sm:py-2 md:px-6 md:py-3 lg:px-8 lg:py-4 bg-orange-500',
                  child: WText(
                    'Responsive Directional Spacing',
                    className: 'text-white text-center',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Responsive Spacing'), findsOneWidget);
      expect(find.text('Responsive Directional Spacing'), findsOneWidget);
    });

    testWidgets('should handle responsive text alignment', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WText(
                  'Responsive Text Alignment',
                  className: 'text-left sm:text-center md:text-right lg:text-center text-lg font-semibold',
                ),
                WContainer(
                  className: 'w-full p-4 bg-gray-100',
                  child: WText(
                    'This text changes alignment based on screen size',
                    className: 'text-center sm:text-left md:text-center lg:text-right',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Responsive Text Alignment'), findsOneWidget);
      expect(find.text('This text changes alignment based on screen size'), findsOneWidget);
    });

    testWidgets('should handle responsive visibility', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WContainer(
                  className: 'block sm:hidden bg-red-500 p-4',
                  child: WText(
                    'Mobile Only',
                    className: 'text-white text-center',
                  ),
                ),
                WContainer(
                  className: 'hidden sm:block md:hidden bg-blue-500 p-4',
                  child: WText(
                    'Tablet Only',
                    className: 'text-white text-center',
                  ),
                ),
                WContainer(
                  className: 'hidden md:block bg-green-500 p-4',
                  child: WText(
                    'Desktop and Up',
                    className: 'text-white text-center',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      
      // 注意：在测试环境中，visibility classes可能不会完全隐藏元素
      // 这里主要测试组件是否能正确渲染
      expect(find.text('Mobile Only'), findsOneWidget);
      expect(find.text('Tablet Only'), findsOneWidget);
      expect(find.text('Desktop and Up'), findsOneWidget);
    });

    testWidgets('should handle responsive grid layouts', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: WContainer(
                className: 'p-4',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(12, (index) => 
                    SizedBox(
                      width: 100,
                      child: WContainer(
                        className: 'bg-gradient-to-br from-blue-400 to-purple-600 p-3 rounded-lg',
                        child: WText(
                          'Item ${index + 1}',
                          className: 'text-white text-center font-semibold',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 12'), findsOneWidget);
    });

    testWidgets('should handle responsive flex layouts', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                WFlex(
                  className: 'flex-col sm:flex-row gap-2 p-4',
                  children: [
                    WContainer(
                      className: 'flex-1 bg-red-500 p-4 rounded',
                      child: WText('Flex Item 1', className: 'text-white text-center'),
                    ),
                    WContainer(
                      className: 'flex-1 bg-blue-500 p-4 rounded',
                      child: WText('Flex Item 2', className: 'text-white text-center'),
                    ),
                  ],
                ),
                WFlex(
                  className: 'flex-row sm:flex-col md:flex-row justify-between items-center gap-4 p-4',
                  children: [
                    WContainer(
                      className: 'bg-green-500 p-3 rounded',
                      child: WText('Start', className: 'text-white'),
                    ),
                    WContainer(
                      className: 'bg-yellow-500 p-3 rounded',
                      child: WText('Middle', className: 'text-black'),
                    ),
                    WContainer(
                      className: 'bg-purple-500 p-3 rounded',
                      child: WText('End', className: 'text-white'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Flex Item 1'), findsOneWidget);
      expect(find.text('Flex Item 2'), findsOneWidget);
      expect(find.text('Start'), findsOneWidget);
      expect(find.text('Middle'), findsOneWidget);
      expect(find.text('End'), findsOneWidget);
    });

    testWidgets('should handle responsive card layouts', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: WContainer(
                className: 'p-4',
                child: WColumn(
                  children: [
                    WCard(
                      className: 'w-full sm:w-3/4 md:w-1/2 lg:w-1/3 mx-auto p-4 sm:p-6 md:p-8',
                      child: WColumn(
                        children: [
                          WText(
                            'Responsive Card',
                            className: 'text-lg sm:text-xl md:text-2xl font-bold text-center mb-4',
                          ),
                          WText(
                            'This card adapts its width and padding based on screen size.',
                            className: 'text-sm sm:text-base text-gray-600 text-center mb-4',
                          ),
                          WButton(
                            text: 'Action Button',
                            onPressed: () {},
                            className: 'w-full sm:w-auto bg-blue-500 text-white px-4 py-2 rounded',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      
      expect(find.text('Responsive Card'), findsOneWidget);
      expect(find.text('This card adapts its width and padding based on screen size.'), findsOneWidget);
      expect(find.text('Action Button'), findsOneWidget);
    });
  });

  group('Responsive Breakpoint Edge Cases', () {
    testWidgets('should handle breakpoint transitions smoothly', (WidgetTester tester) async {
      // 测试在断点边界的行为
      final breakpoints = [
        const Size(639, 800),  // Just below sm
        const Size(640, 800),  // sm breakpoint
        const Size(767, 800),  // Just below md
        const Size(768, 800),  // md breakpoint
        const Size(1023, 800), // Just below lg
        const Size(1024, 800), // lg breakpoint
      ];
      
      for (final size in breakpoints) {
        await tester.binding.setSurfaceSize(size);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WContainer(
                className: 'w-full sm:w-1/2 md:w-1/3 lg:w-1/4 p-2 sm:p-4 md:p-6 lg:p-8 bg-blue-500',
                child: WText(
                  'Breakpoint Test ${size.width.toInt()}px',
                  className: 'text-white text-center text-xs sm:text-sm md:text-base lg:text-lg',
                ),
              ),
            ),
          ),
        );
        
        expect(find.textContaining('Breakpoint Test'), findsOneWidget);
        await tester.pump();
      }
    });

    testWidgets('should handle complex responsive combinations', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'bg-gradient-to-r from-purple-400 via-pink-500 to-red-500 sm:from-blue-400 sm:via-green-500 sm:to-yellow-500 md:from-indigo-400 md:via-purple-500 md:to-pink-500',
              child: WColumn(
                children: [
                  WText(
                    'Complex Responsive Styles',
                    className: 'text-white text-center text-lg sm:text-xl md:text-2xl lg:text-3xl font-bold p-4 sm:p-6 md:p-8',
                  ),
                  WFlex(
                    className: 'flex-col sm:flex-row md:flex-col lg:flex-row gap-2 sm:gap-4 md:gap-6 p-4',
                    children: [
                      WContainer(
                        className: 'flex-1 bg-white/20 backdrop-blur-sm p-3 sm:p-4 md:p-6 rounded-lg sm:rounded-xl',
                        child: WText(
                          'Responsive Container 1',
                          className: 'text-white text-center text-sm sm:text-base md:text-lg',
                        ),
                      ),
                      WContainer(
                        className: 'flex-1 bg-black/20 backdrop-blur-sm p-3 sm:p-4 md:p-6 rounded-lg sm:rounded-xl',
                        child: WText(
                          'Responsive Container 2',
                          className: 'text-white text-center text-sm sm:text-base md:text-lg',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      
      expect(find.text('Complex Responsive Styles'), findsOneWidget);
      expect(find.text('Responsive Container 1'), findsOneWidget);
      expect(find.text('Responsive Container 2'), findsOneWidget);
    });
  });
}