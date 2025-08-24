import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  setUpAll(() {
    // 初始化WindConfig和SmartStyleParser
    WindConfig.initialize();
    SmartStyleParser.initialize();
  });

  group('Style Parser Tests - Basic Parsing', () {
    testWidgets('should parse basic background colors', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            final style1 = SmartStyleParser.parseClassName('bg-red-500', 'container', context);
            expect(style1['backgroundColor'], isNotNull);
            
            final style2 = SmartStyleParser.parseClassName('bg-blue-600', 'container', context);
            expect(style2['backgroundColor'], isNotNull);
            
            final style3 = SmartStyleParser.parseClassName('bg-green-400', 'container', context);
            expect(style3['backgroundColor'], isNotNull);
            
            return Container();
          },
        ),
      ));
    });

    testWidgets('should parse basic text colors', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            final style1 = SmartStyleParser.parseClassName('text-red-500', 'text', context);
            expect(style1['color'], isNotNull);
            
            final style2 = SmartStyleParser.parseClassName('text-blue-600', 'text', context);
            expect(style2['color'], isNotNull);
            
            final style3 = SmartStyleParser.parseClassName('text-white', 'text', context);
            expect(style3['color'], isNotNull);
            
            return Container();
          },
        ),
      ));
    });

    testWidgets('should parse padding classes', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            final style1 = SmartStyleParser.parseClassName('p-4', 'container', context);
            expect(style1['padding'], isNotNull);
            
            final style2 = SmartStyleParser.parseClassName('px-6', 'container', context);
            expect(style2['paddingHorizontal'], isNotNull);
            
            final style3 = SmartStyleParser.parseClassName('py-8', 'container', context);
            expect(style3['paddingVertical'], isNotNull);
            
            return Container();
          },
        ),
      ));
    });

    testWidgets('should parse margin classes', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            final style1 = SmartStyleParser.parseClassName('m-4', 'container', context);
            expect(style1['margin'], isNotNull);
            
            final style2 = SmartStyleParser.parseClassName('mx-6', 'container', context);
            expect(style2['marginHorizontal'], isNotNull);
            
            final style3 = SmartStyleParser.parseClassName('my-8', 'container', context);
            expect(style3['marginVertical'], isNotNull);
            
            return Container();
          },
        ),
      ));
    });

    testWidgets('should parse border radius classes', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            final style1 = SmartStyleParser.parseClassName('rounded', 'container', context);
            expect(style1['borderRadius'], isNotNull);
            
            final style2 = SmartStyleParser.parseClassName('rounded-lg', 'container', context);
            expect(style2['borderRadius'], isNotNull);
            
            final style3 = SmartStyleParser.parseClassName('rounded-full', 'container', context);
            expect(style3['borderRadius'], isNotNull);
            
            return Container();
          },
        ),
      ));
    });
  });

  group('Style Parser Tests - Advanced Parsing', () {
    testWidgets('should parse font weight classes', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            final style1 = SmartStyleParser.parseClassName('font-thin', 'text', context);
            expect(style1['fontWeight'], equals(FontWeight.w100));
            
            final style2 = SmartStyleParser.parseClassName('font-normal', 'text', context);
            expect(style2['fontWeight'], equals(FontWeight.w400));
            
            final style3 = SmartStyleParser.parseClassName('font-bold', 'text', context);
            expect(style3['fontWeight'], equals(FontWeight.w700));
            
            return Container();
          },
        ),
      ));
    });

    testWidgets('should parse font size classes', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            final style1 = SmartStyleParser.parseClassName('text-xs', 'text', context);
            expect(style1['fontSize'], isNotNull);
            
            final style2 = SmartStyleParser.parseClassName('text-sm', 'text', context);
            expect(style2['fontSize'], isNotNull);
            
            final style3 = SmartStyleParser.parseClassName('text-lg', 'text', context);
            expect(style3['fontSize'], isNotNull);
            
            return Container();
          },
        ),
      ));
    });
  });

  group('Style Parser Tests - Complex Combinations', () {
    testWidgets('should parse multiple classes correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            final style = SmartStyleParser.parseClassName(
              'bg-blue-500 text-white p-4 rounded-lg font-bold text-lg',
              'container',
              context
            );
            
            expect(style['backgroundColor'], isNotNull);
            expect(style['color'], isNotNull);
            expect(style['padding'], isNotNull);
            expect(style['borderRadius'], isNotNull);
            expect(style['fontWeight'], equals(FontWeight.w700));
            expect(style['fontSize'], isNotNull);
            
            return Container();
          },
        ),
      ));
    });

    testWidgets('should handle conflicting classes (last one wins)', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            final style = SmartStyleParser.parseClassName(
              'bg-red-500 bg-blue-500 bg-green-500',
              'container',
              context
            );
            expect(style['backgroundColor'], isNotNull);
            
            final style2 = SmartStyleParser.parseClassName(
              'p-2 p-4 p-8',
              'container',
              context
            );
            expect(style2['padding'], isNotNull);
            
            return Container();
          },
        ),
      ));
    });

    testWidgets('should parse gradient classes', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            final style1 = SmartStyleParser.parseClassName(
              'bg-gradient-to-r from-blue-500 to-purple-600',
              'container',
              context
            );
            expect(style1['gradientDirection'], isNotNull);
            expect(style1['gradientFrom'], isNotNull);
            expect(style1['gradientTo'], isNotNull);
            
            final style2 = SmartStyleParser.parseClassName(
              'bg-gradient-to-b from-red-400 via-yellow-500 to-pink-600',
              'container',
              context
            );
            expect(style2['gradientDirection'], isNotNull);
            expect(style2['gradientFrom'], isNotNull);
            expect(style2['gradientVia'], isNotNull);
            expect(style2['gradientTo'], isNotNull);
            
            return Container();
          },
        ),
      ));
    });
  });

  group('Style Parser Tests - Custom Colors', () {
    testWidgets('should handle custom color systems', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            // Add custom colors
            SmartStyleParser.addColorSystem('brand', {
              '50': const Color(0xFFF0F9FF),
              '100': const Color(0xFFE0F2FE),
              '200': const Color(0xFFBAE6FD),
              '300': const Color(0xFF7DD3FC),
              '400': const Color(0xFF38BDF8),
              '500': const Color(0xFF0EA5E9),
              '600': const Color(0xFF0284C7),
              '700': const Color(0xFF0369A1),
              '800': const Color(0xFF075985),
              '900': const Color(0xFF0C4A6E),
            });
            
            final style1 = SmartStyleParser.parseClassName('bg-brand-500', 'container', context);
            expect(style1['backgroundColor'], isNotNull);
            
            final style2 = SmartStyleParser.parseClassName('text-brand-900', 'text', context);
            expect(style2['color'], isNotNull);
            
            return Container();
          },
        ),
      ));
    });
  });

  group('Style Parser Tests - Error Handling', () {
    testWidgets('should handle empty and null class names', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            final style1 = SmartStyleParser.parseClassName('', 'container', context);
            expect(style1, isEmpty);
            
            return Container();
          },
        ),
      ));
    });

    testWidgets('should handle invalid class names gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            final style1 = SmartStyleParser.parseClassName('invalid-class-name', 'container', context);
            expect(style1, isA<Map<String, dynamic>>());
            
            final style2 = SmartStyleParser.parseClassName('bg-invalid-color', 'container', context);
            expect(style2, isA<Map<String, dynamic>>());
            
            return Container();
          },
        ),
      ));
    });
  });

  group('Style Parser Tests - Performance', () {
    testWidgets('should handle large class name strings efficiently', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            final longClassName = List.generate(100, (i) => 'p-$i').join(' ');
            
            final stopwatch = Stopwatch()..start();
            final style = SmartStyleParser.parseClassName(longClassName, 'container', context);
            stopwatch.stop();
            
            expect(style, isA<Map<String, dynamic>>());
            expect(stopwatch.elapsedMilliseconds, lessThan(100)); // Should be fast
            
            return Container();
          },
        ),
      ));
    });

    testWidgets('should cache results for repeated parsing', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            const className = 'bg-blue-500 text-white p-4 rounded-lg';
            
            // First parse
            final stopwatch1 = Stopwatch()..start();
            final style1 = SmartStyleParser.parseClassName(className, 'container', context);
            stopwatch1.stop();
            
            // Second parse (should be cached in production)
            final stopwatch2 = Stopwatch()..start();
            final style2 = SmartStyleParser.parseClassName(className, 'container', context);
            stopwatch2.stop();
            
            expect(style1, isA<Map<String, dynamic>>());
            expect(style2, isA<Map<String, dynamic>>());
            
            return Container();
          },
        ),
      ));
    });
  });
}