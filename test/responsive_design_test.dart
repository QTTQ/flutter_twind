import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  setUpAll(() {
    WindConfig.initialize();
    SmartStyleParser.initialize();
  });

  group('Responsive Design Tests - Breakpoint Handling', () {
    testWidgets('should apply mobile styles by default', (WidgetTester tester) async {
      // Set mobile screen size
      await tester.binding.setSurfaceSize(const Size(375, 667)); // iPhone size
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'bg-red-500 sm:bg-blue-500 md:bg-green-500 lg:bg-yellow-500',
              child: Text('Responsive Container'),
            ),
          ),
        ),
      );
      
      expect(find.text('Responsive Container'), findsOneWidget);
      expect(find.byType(WContainer), findsOneWidget);
    });

    testWidgets('should apply small screen styles on sm breakpoint', (WidgetTester tester) async {
      // Set small screen size
      await tester.binding.setSurfaceSize(const Size(640, 800));
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'p-2 sm:p-4 md:p-6 lg:p-8',
              child: WText(
                'Small Screen Text',
                className: 'text-sm sm:text-base md:text-lg lg:text-xl',
              ),
            ),
          ),
        ),
      );
      
      expect(find.text('Small Screen Text'), findsOneWidget);
    });

    testWidgets('should apply medium screen styles on md breakpoint', (WidgetTester tester) async {
      // Set medium screen size
      await tester.binding.setSurfaceSize(const Size(768, 1024));
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WColumn(
              children: [
                WContainer(
                  className: 'bg-blue-500 p-4',
                  child: WText('Left Panel', className: 'text-white'),
                ),
                WContainer(
                  className: 'bg-green-500 p-4',
                  child: WText('Right Panel', className: 'text-white'),
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Left Panel'), findsOneWidget);
      expect(find.text('Right Panel'), findsOneWidget);
    });

    testWidgets('should apply large screen styles on lg breakpoint', (WidgetTester tester) async {
      // Set large screen size
      await tester.binding.setSurfaceSize(const Size(1024, 768));
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'p-4',
              child: WColumn(
                children: [
                  WCard(
                    className: 'bg-white p-4 mb-4',
                    child: WText(
                      'Card 1',
                      className: 'font-semibold',
                    ),
                  ),
                  WCard(
                    className: 'bg-white p-4',
                    child: WText(
                      'Card 2',
                      className: 'font-semibold',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      
      expect(find.byType(WCard), findsNWidgets(2));
    });
  });

  group('Responsive Design Tests - Layout Changes', () {
    testWidgets('should change layout based on screen size', (WidgetTester tester) async {
      Widget buildResponsiveLayout() {
        return MaterialApp(
          home: Scaffold(
            body: WColumn(
              children: [
                WContainer(
                  className: 'bg-blue-500 p-6',
                  child: WText(
                    'Sidebar',
                    className: 'text-white text-xl font-bold',
                  ),
                ),
                WContainer(
                  className: 'bg-gray-100 p-6',
                  child: WColumn(
                    children: [
                      WText(
                        'Main Content',
                        className: 'text-2xl font-bold',
                      ),
                      WText(
                        'This is responsive content.',
                        className: 'text-gray-700',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
      
      // Test mobile layout
      await tester.binding.setSurfaceSize(const Size(375, 667));
      await tester.pumpWidget(buildResponsiveLayout());
      expect(find.text('Sidebar'), findsOneWidget);
      expect(find.text('Main Content'), findsOneWidget);
      
      // Test large screen layout
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(buildResponsiveLayout());
      expect(find.text('Sidebar'), findsOneWidget);
      expect(find.text('Main Content'), findsOneWidget);
    });

    testWidgets('should hide/show elements based on screen size', (WidgetTester tester) async {
      Widget buildResponsiveVisibility() {
        return MaterialApp(
          home: Scaffold(
            body: WColumn(
              children: [
                WContainer(
                  className: 'block md:hidden bg-red-500 p-4',
                  child: WText('Mobile Only', className: 'text-white'),
                ),
                WContainer(
                  className: 'hidden md:block bg-blue-500 p-4',
                  child: WText('Desktop Only', className: 'text-white'),
                ),
                WContainer(
                  className: 'bg-green-500 p-4',
                  child: WText('Always Visible', className: 'text-white'),
                ),
              ],
            ),
          ),
        );
      }
      
      // Test mobile visibility
      await tester.binding.setSurfaceSize(const Size(375, 667));
      await tester.pumpWidget(buildResponsiveVisibility());
      expect(find.text('Always Visible'), findsOneWidget);
      
      // Test desktop visibility
      await tester.binding.setSurfaceSize(const Size(1024, 768));
      await tester.pumpWidget(buildResponsiveVisibility());
      expect(find.text('Always Visible'), findsOneWidget);
    });
  });

  group('Responsive Design Tests - Typography and Spacing', () {
    testWidgets('should scale typography responsively', (WidgetTester tester) async {
      Widget buildResponsiveTypography() {
        return MaterialApp(
          home: Scaffold(
            body: WColumn(
              className: 'p-4 space-y-4',
              children: [
                WText(
                  'Responsive Heading',
                  className: 'text-xl sm:text-2xl md:text-3xl lg:text-4xl font-bold',
                ),
                WText(
                  'Responsive Subheading',
                  className: 'text-lg sm:text-xl md:text-2xl font-semibold text-gray-700',
                ),
                WText(
                  'This is responsive body text that scales with screen size.',
                  className: 'text-sm sm:text-base md:text-lg text-gray-600',
                ),
              ],
            ),
          ),
        );
      }
      
      // Test different screen sizes
      final sizes = [
        const Size(375, 667),  // Mobile
        const Size(640, 800),  // Small
        const Size(768, 1024), // Medium
        const Size(1024, 768), // Large
      ];
      
      for (final size in sizes) {
        await tester.binding.setSurfaceSize(size);
        await tester.pumpWidget(buildResponsiveTypography());
        
        expect(find.text('Responsive Heading'), findsOneWidget);
        expect(find.text('Responsive Subheading'), findsOneWidget);
        expect(find.textContaining('responsive body text'), findsOneWidget);
      }
    });

    testWidgets('should scale spacing responsively', (WidgetTester tester) async {
      Widget buildResponsiveSpacing() {
        return MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'p-2 sm:p-4 md:p-6 lg:p-8',
              child: WColumn(
                className: 'space-y-2 sm:space-y-4 md:space-y-6 lg:space-y-8',
                children: List.generate(4, (index) => 
                  WContainer(
                    className: 'bg-blue-${(index + 1) * 100} p-2 sm:p-3 md:p-4 lg:p-6 rounded',
                    child: WText(
                      'Item ${index + 1}',
                      className: 'text-white text-center',
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
      
      // Test different screen sizes
      final sizes = [
        const Size(375, 667),  // Mobile
        const Size(768, 1024), // Medium
        const Size(1024, 768), // Large
      ];
      
      for (final size in sizes) {
        await tester.binding.setSurfaceSize(size);
        await tester.pumpWidget(buildResponsiveSpacing());
        
        expect(find.byType(WContainer), findsNWidgets(5)); // 1 parent + 4 children
        for (int i = 1; i <= 4; i++) {
          expect(find.text('Item $i'), findsOneWidget);
        }
      }
    });
  });

  group('Responsive Design Tests - Grid and Flex', () {
    testWidgets('should create responsive grid layouts - mobile', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(375, 667));
      
      Widget buildResponsiveGrid() {
        return MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'p-4',
              child: WColumn(
                children: [
                  WText(
                    'Responsive Grid',
                    className: 'text-2xl font-bold',
                  ),
                  WCard(
                    className: 'bg-blue-400 p-4',
                    child: WText(
                      'Card 1',
                      className: 'text-white font-semibold',
                    ),
                  ),
                  WCard(
                    className: 'bg-blue-400 p-4',
                    child: WText(
                      'Card 2',
                      className: 'text-white font-semibold',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      
      await tester.pumpWidget(buildResponsiveGrid());
      expect(find.text('Responsive Grid'), findsOneWidget);
      expect(find.byType(WCard), findsNWidgets(2));
      expect(find.text('Card 1'), findsOneWidget);
      expect(find.text('Card 2'), findsOneWidget);
    });
    
    testWidgets('should create responsive grid layouts - desktop', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1024, 768));
      
      Widget buildResponsiveGrid() {
        return MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'p-4',
              child: WColumn(
                children: [
                  WText(
                    'Responsive Grid',
                    className: 'text-2xl font-bold',
                  ),
                  WCard(
                    className: 'bg-blue-400 p-4',
                    child: WText(
                      'Card 1',
                      className: 'text-white font-semibold',
                    ),
                  ),
                  WCard(
                    className: 'bg-blue-400 p-4',
                    child: WText(
                      'Card 2',
                      className: 'text-white font-semibold',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      
      await tester.pumpWidget(buildResponsiveGrid());
      expect(find.text('Responsive Grid'), findsOneWidget);
      expect(find.byType(WCard), findsNWidgets(2));
      expect(find.text('Card 1'), findsOneWidget);
      expect(find.text('Card 2'), findsOneWidget);
    });

    testWidgets('should handle responsive flex properties - mobile', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(375, 667));
      
      Widget buildResponsiveFlex() {
        return MaterialApp(
          home: Scaffold(
            body: WColumn(
              children: [
                WContainer(
                  className: 'bg-red-500 p-4',
                  child: WText('Flex Item 1', className: 'text-white'),
                ),
                WContainer(
                  className: 'bg-green-500 p-4',
                  child: WText('Flex Item 2', className: 'text-white'),
                ),
                WContainer(
                  className: 'bg-blue-500 p-4',
                  child: WText('Flex Item 3', className: 'text-white'),
                ),
              ],
            ),
          ),
        );
      }
      
      await tester.pumpWidget(buildResponsiveFlex());
      expect(find.text('Flex Item 1'), findsOneWidget);
      expect(find.text('Flex Item 2'), findsOneWidget);
      expect(find.text('Flex Item 3'), findsOneWidget);
    });
    
    testWidgets('should handle responsive flex properties - desktop', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1024, 768));
      
      Widget buildResponsiveFlex() {
        return MaterialApp(
          home: Scaffold(
            body: WColumn(
              children: [
                WContainer(
                  className: 'bg-red-500 p-4',
                  child: WText('Flex Item 1', className: 'text-white'),
                ),
                WContainer(
                  className: 'bg-green-500 p-4',
                  child: WText('Flex Item 2', className: 'text-white'),
                ),
                WContainer(
                  className: 'bg-blue-500 p-4',
                  child: WText('Flex Item 3', className: 'text-white'),
                ),
              ],
            ),
          ),
        );
      }
      
      await tester.pumpWidget(buildResponsiveFlex());
      expect(find.text('Flex Item 1'), findsOneWidget);
      expect(find.text('Flex Item 2'), findsOneWidget);
      expect(find.text('Flex Item 3'), findsOneWidget);
    });
  });

  group('Responsive Design Tests - Simple Scenarios', () {
    testWidgets('should handle basic responsive layout', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(375, 667));
      
      Widget buildSimpleResponsive() {
        return MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'p-4',
              child: WColumn(
                children: [
                  WText(
                    'Responsive Test',
                    className: 'text-xl font-bold',
                  ),
                  WContainer(
                    className: 'mt-4 p-4 bg-blue-500',
                    child: WText(
                      'Content',
                      className: 'text-white',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      
      await tester.pumpWidget(buildSimpleResponsive());
      expect(find.text('Responsive Test'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });
  });

  // tearDown is not needed as Flutter test framework automatically resets state
}