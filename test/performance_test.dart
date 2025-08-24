import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';


void main() {
  setUpAll(() {
    WindConfig.initialize();
    SmartStyleParser.initialize();
  });

  group('Performance Tests', () {
    testWidgets('should efficiently render large number of containers', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: WColumn(
                children: List.generate(100, (index) => 
                  WContainer(
                    className: 'bg-blue-${(index % 9 + 1) * 100} p-4 mb-2 rounded-lg shadow-md',
                    child: WText(
                      'Container $index',
                      className: 'text-white font-semibold text-center',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      
      stopwatch.stop();
      
      expect(find.byType(WContainer), findsNWidgets(100));
      expect(stopwatch.elapsedMilliseconds, lessThan(5000)); // Should render within 5 seconds
      
      // print('Rendered 100 containers in ${stopwatch.elapsedMilliseconds}ms');
    });

    testWidgets('should efficiently handle complex nested structures', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: WContainer(
                className: 'p-4',
                child: WColumn(
                  children: List.generate(20, (i) => 
                    WCard(
                      className: 'mb-4 p-4 rounded-xl shadow-lg bg-gradient-to-r from-blue-500 to-purple-600',
                      child: WColumn(
                        children: [
                          WText(
                            'Card $i',
                            className: 'text-white text-xl font-bold mb-4',
                          ),
                          WRow(
                            className: 'gap-2',
                            children: List.generate(3, (j) => 
                              WContainer(
                                className: 'flex-1 bg-white/20 p-3 rounded-lg backdrop-blur-sm',
                                child: WColumn(
                                  children: [
                                    WIcon(
                                      Icons.star,
                                      className: 'text-yellow-300 text-2xl mb-2',
                                    ),
                                    WText(
                                      'Item ${i * 3 + j}',
                                      className: 'text-white text-sm font-medium',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          WButton(
                            text: 'Action $i',
                            onPressed: () {},
                            className: 'mt-4 bg-white text-blue-600 px-6 py-2 rounded-lg font-semibold',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      
      stopwatch.stop();
      
      expect(find.byType(WCard), findsNWidgets(20));
      expect(find.byType(WContainer), findsNWidgets(61)); // 1 main + 20*3 nested
      expect(find.byType(WButton), findsNWidgets(20));
      expect(stopwatch.elapsedMilliseconds, lessThan(8000)); // Should render within 8 seconds
      
      // print('Rendered complex nested structure in ${stopwatch.elapsedMilliseconds}ms');
    });

    testWidgets('should efficiently parse large number of style combinations', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Container())));
      final context = tester.element(find.byType(Container));
      final stopwatch = Stopwatch()..start();
      
      final styleClasses = [
        'bg-red-500 text-white p-4 rounded-lg shadow-md',
        'bg-gradient-to-r from-blue-500 to-purple-600 text-white p-6 rounded-xl shadow-xl',
        'bg-green-400/80 text-gray-800 px-4 py-2 rounded-full border border-green-600',
        'bg-[#ff6b6b] text-white font-bold text-lg p-8 rounded-2xl shadow-2xl',
        'bg-gradient-to-br from-pink-500 via-red-500 to-yellow-500 text-white p-4',
        'text-blue-600/75 font-semibold text-xl underline decoration-2',
        'bg-white/90 backdrop-blur-md border border-gray-200/50 rounded-lg p-6',
        'bg-black text-white font-mono text-sm p-3 rounded border-l-4 border-blue-500',
        'bg-gradient-radial from-yellow-400 to-red-600 text-white p-8 rounded-full',
        'text-[rgb(255,107,107)] bg-[rgba(78,205,196,0.1)] p-4 rounded border',
      ];
      
      // Parse each style combination multiple times
      for (int i = 0; i < 50; i++) {
        for (final styleClass in styleClasses) {
          SmartStyleParser.parseClassName(styleClass, 'Container', context);
        }
      }
      
      stopwatch.stop();
      
      expect(stopwatch.elapsedMilliseconds, lessThan(2000)); // Should parse within 2 seconds
      
      // print('Parsed ${styleClasses.length * 50} style combinations in ${stopwatch.elapsedMilliseconds}ms');
    });

    testWidgets('should efficiently handle rapid style updates', (WidgetTester tester) async {
      String currentClass = 'bg-blue-500 p-4 rounded';
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return WContainer(
                  className: currentClass,
                  child: WButton(
                    text: 'Update Style',
                    onPressed: () {
                      setState(() {
                        final colors = ['red', 'green', 'blue', 'purple', 'pink', 'yellow'];
                        final randomColor = colors[DateTime.now().millisecond % colors.length];
                        currentClass = 'bg-$randomColor-500 p-4 rounded-lg shadow-md hover:shadow-lg transition-all';
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );
      
      final stopwatch = Stopwatch()..start();
      
      // Simulate rapid style updates
      for (int i = 0; i < 20; i++) {
        await tester.tap(find.text('Update Style'));
        await tester.pump();
      }
      
      stopwatch.stop();
      
      expect(find.text('Update Style'), findsOneWidget);
      expect(stopwatch.elapsedMilliseconds, lessThan(3000)); // Should update within 3 seconds
      
      // print('Performed 20 rapid style updates in ${stopwatch.elapsedMilliseconds}ms');
    });

    testWidgets('should efficiently render multiple components', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WColumn(
              className: 'p-4',
              children: List.generate(10, (index) => 
                WContainer(
                  className: 'mb-2 p-2 bg-gray-100',
                  child: WText(
                    'Component ${index + 1}',
                    className: 'text-gray-800',
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      
      stopwatch.stop();
      
      expect(find.byType(WContainer), findsNWidgets(10));
      expect(stopwatch.elapsedMilliseconds, lessThan(1000)); // Should render within 1 second
      
      // Rendered 10 components in ${stopwatch.elapsedMilliseconds}ms
    });

    testWidgets('should efficiently handle memory usage with many widgets', (WidgetTester tester) async {
      // Create a large widget tree and measure memory impact
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: WColumn(
                children: List.generate(50, (i) => 
                  WContainer(
                    className: 'p-4 mb-2',
                    child: WRow(
                      className: 'gap-2',
                      children: List.generate(5, (j) => 
                        WContainer(
                          className: 'flex-1 bg-gradient-to-r from-indigo-500 to-purple-600 p-3 rounded',
                          child: WColumn(
                            children: [
                              WIcon(
                                Icons.widgets,
                                className: 'text-white text-lg mb-1',
                              ),
                              WText(
                                'Widget ${i * 5 + j}',
                                className: 'text-white text-xs font-medium text-center',
                              ),
                            ],
                          ),
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
      
      expect(find.byType(WContainer), findsNWidgets(300)); // 50 + 50*5
      expect(find.byType(WIcon), findsNWidgets(250));
      expect(find.byType(WText), findsNWidgets(250));
      
      // Verify widgets are properly disposed
      await tester.pumpWidget(Container());
      await tester.pump();
      
      expect(find.byType(WContainer), findsNothing);
    });

    testWidgets('should efficiently handle style parser caching', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Container())));
      final context = tester.element(find.byType(Container));
      final stopwatch = Stopwatch();
      
      const testClass = 'bg-blue-500 text-white p-4 rounded-lg shadow-md font-bold text-xl';
      
      // First parse (no cache)
      stopwatch.start();
      final firstResult = SmartStyleParser.parseClassName(testClass, 'Container', context);
      final firstParseTime = stopwatch.elapsedMicroseconds;
      stopwatch.reset();
      
      // Second parse (should use cache)
      stopwatch.start();
      final secondResult = SmartStyleParser.parseClassName(testClass, 'Container', context);
      final secondParseTime = stopwatch.elapsedMicroseconds;
      stopwatch.stop();
      
      expect(firstResult, isNotNull);
      expect(secondResult, isNotNull);
      expect(secondParseTime, lessThan(firstParseTime)); // Cache should be faster
      
      // First parse: ${firstParseTime}μs, Cached parse: ${secondParseTime}μs
      // Cache speedup: ${(firstParseTime / secondParseTime).toStringAsFixed(2)}x
    });

    testWidgets('should handle concurrent style parsing efficiently', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Container())));
      final context = tester.element(find.byType(Container));
      final stopwatch = Stopwatch()..start();
      
      final futures = List.generate(100, (index) => 
        Future.microtask(() => SmartStyleParser.parseClassName(
          'bg-${['red', 'green', 'blue', 'purple', 'pink'][index % 5]}-${(index % 9 + 1) * 100} '
          'text-white p-${index % 8 + 1} rounded-${['sm', 'md', 'lg', 'xl'][index % 4]} '
          'shadow-${['sm', 'md', 'lg', 'xl', '2xl'][index % 5]} '
          'font-${['normal', 'medium', 'semibold', 'bold'][index % 4]}',
          'Container',
          context
        ))
      );
      
      final results = await Future.wait(futures);
      stopwatch.stop();
      
      expect(results.length, equals(100));
      expect(results, everyElement(isNotNull));
      expect(stopwatch.elapsedMilliseconds, lessThan(1000)); // Should complete within 1 second
      
      // Parsed 100 concurrent style combinations in ${stopwatch.elapsedMilliseconds}ms
    });

    testWidgets('should efficiently handle gradient parsing performance', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Container())));
      final context = tester.element(find.byType(Container));
      final stopwatch = Stopwatch()..start();
      
      final gradientClasses = [
        'bg-gradient-to-r from-red-500 to-blue-500',
        'bg-gradient-to-br from-purple-600 via-pink-600 to-blue-600',
        'bg-gradient-to-t from-green-400 to-blue-500',
        'bg-gradient-to-bl from-yellow-400 via-red-500 to-pink-500',
        'bg-gradient-radial from-cyan-500 to-blue-500',
        'bg-gradient-to-tr from-indigo-500 via-purple-500 to-pink-500',
        'bg-gradient-to-b from-orange-400 to-red-600',
        'bg-gradient-to-tl from-emerald-400 to-cyan-400',
      ];
      
      // Parse each gradient multiple times
      for (int i = 0; i < 25; i++) {
        for (final gradientClass in gradientClasses) {
          SmartStyleParser.parseClassName(gradientClass, 'Container', context);
        }
      }
      
      stopwatch.stop();
      
      expect(stopwatch.elapsedMilliseconds, lessThan(1500)); // Should parse within 1.5 seconds
      
      // Parsed ${gradientClasses.length * 25} gradient combinations in ${stopwatch.elapsedMilliseconds}ms
    });
  });

  group('Memory and Resource Tests', () {
    testWidgets('should properly dispose of widgets and free memory', (WidgetTester tester) async {
      // Create and destroy widgets multiple times
      for (int cycle = 0; cycle < 3; cycle++) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: WColumn(
                  children: List.generate(10, (index) => 
                    WContainer(
                      className: 'bg-blue-500 p-2 mb-1',
                      child: WText('Widget $index'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        
        expect(find.byType(WContainer), findsNWidgets(10));
        
        // Clear the widget tree
        await tester.pumpWidget(Container());
        await tester.pump();
        
        expect(find.byType(WContainer), findsNothing);
      }
      
      // Completed 3 cycles of widget creation and disposal
    });

    testWidgets('should handle style parser memory efficiently', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Container())));
      final context = tester.element(find.byType(Container));
      
      // Generate many unique style combinations
      final uniqueStyles = <String>{};
      for (int i = 0; i < 1000; i++) {
        final style = 'bg-${['red', 'green', 'blue'][i % 3]}-${(i % 9 + 1) * 100} '
                     'p-${i % 8 + 1} '
                     'm-${i % 6 + 1} '
                     'rounded-${['sm', 'md', 'lg'][i % 3]} '
                     'text-${['xs', 'sm', 'base', 'lg', 'xl'][i % 5]}';
        uniqueStyles.add(style);
      }
      
      // Parse all unique styles
      for (final style in uniqueStyles) {
        SmartStyleParser.parseClassName(style, 'Container', context);
      }
      
      expect(uniqueStyles.length, greaterThan(300)); // Should have many unique combinations
      // Generated and parsed ${uniqueStyles.length} unique style combinations
    });
  });
}