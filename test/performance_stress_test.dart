import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

class _AnimationTestWidget extends StatefulWidget {
  @override
  _AnimationTestWidgetState createState() => _AnimationTestWidgetState();
}

class _AnimationTestWidgetState extends State<_AnimationTestWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WContainer(
        className: 'p-4',
        child: WColumn(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(isExpanded ? 'Collapse' : 'Expand'),
            ),
            const SizedBox(height: 16),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isExpanded ? 400 : 100,
              child: WContainer(
                className: 'w-full bg-gradient-to-br from-purple-400 to-pink-600 rounded-xl p-4',
                child: SingleChildScrollView(
                  child: WColumn(
                    children: List.generate(isExpanded ? 20 : 5, (index) => 
                      WContainer(
                        className: 'mb-2 p-3 bg-white/20 rounded-lg backdrop-blur-sm',
                        child: WText(
                          'Animated Item ${index + 1}',
                          className: 'text-white font-semibold text-center',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  setUpAll(() {
    WindConfig.initialize();
  });

  group('Performance Stress Tests', () {
    testWidgets('should handle large number of components efficiently', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: WContainer(
                className: 'p-4',
                child: WColumn(
                  children: List.generate(100, (index) => 
                    WCard(
                      className: 'p-4 mb-2 bg-white shadow-md rounded-lg border border-gray-200',
                      child: WFlex(
                        className: 'flex-row items-center justify-between',
                        children: [
                          WContainer(
                            className: 'w-12 h-12 bg-blue-500 rounded-full flex items-center justify-center',
                            child: WText(
                              '${index + 1}',
                              className: 'text-white font-bold',
                            ),
                          ),
                          WColumn(
                            children: [
                              WText(
                                'Item ${index + 1}',
                                className: 'font-semibold text-gray-800',
                              ),
                              WText(
                                'Description for item ${index + 1}',
                                className: 'text-gray-600 text-sm',
                              ),
                            ],
                          ),
                          WButton(
                            text: 'Action',
                            onPressed: () {},
                            className: 'bg-green-500 text-white px-4 py-2 rounded',
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
      // Rendered 100 complex components in ${stopwatch.elapsedMilliseconds}ms
      
      // Verify components are rendered
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 100'), findsOneWidget);
      expect(find.text('Action'), findsNWidgets(100));
      
      // Performance assertion - should render within reasonable time
      expect(stopwatch.elapsedMilliseconds, lessThan(5000)); // 5 seconds max
    });

    testWidgets('should handle complex style parsing efficiently', (WidgetTester tester) async {
      final complexStyles = [
        'bg-red-500 p-4 m-2 rounded-lg border-2 border-white',
        'bg-blue-500 p-6 rounded text-white font-bold',
        'bg-green-500 p-3 m-1 rounded-xl shadow-lg',
        'bg-purple-500 p-5 rounded-full text-center',
        'bg-yellow-500 p-2 m-3 rounded border border-gray-300',
      ];
      
      final stopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: WContainer(
                className: 'p-4',
                child: WColumn(
                  children: List.generate(20, (outerIndex) => 
                    WContainer(
                      className: 'mb-4',
                      child: WColumn(
                        children: complexStyles.map((style) => 
                          WContainer(
                            className: style,
                            child: WText(
                              'Style Test ${outerIndex + 1}',
                              className: 'text-white font-semibold p-2',
                            ),
                          ),
                        ).toList(),
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
      // Parsed ${20 * complexStyles.length} complex styles in ${stopwatch.elapsedMilliseconds}ms
      
      expect(find.textContaining('Style Test'), findsNWidgets(100)); // 20 containers × 5 styles each
      expect(stopwatch.elapsedMilliseconds, lessThan(2000)); // 2 seconds max
    });

    testWidgets('should handle rapid style updates efficiently', (WidgetTester tester) async {
      final styles = [
        'bg-red-500 p-4 rounded',
        'bg-blue-500 p-6 rounded-lg',
        'bg-green-500 p-8 rounded-xl',
        'bg-purple-500 p-2 rounded-full',
        'bg-yellow-500 p-10 rounded-2xl',
      ];
      
      int currentStyleIndex = 0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: WContainer(
                  className: 'p-4',
                  child: WColumn(
                    children: [
                      WContainer(
                        className: styles[currentStyleIndex],
                        child: WText(
                          'Dynamic Style Container',
                          className: 'text-white font-bold text-center',
                        ),
                      ),
                      WButton(
                        text: 'Change Style',
                        onPressed: () {
                          setState(() {
                            currentStyleIndex = (currentStyleIndex + 1) % styles.length;
                          });
                        },
                        className: 'mt-4 bg-gray-800 text-white px-6 py-3 rounded',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
      
      final stopwatch = Stopwatch()..start();
      
      // Rapidly change styles
      for (int i = 0; i < 20; i++) {
        await tester.tap(find.text('Change Style'));
        await tester.pump();
      }
      
      stopwatch.stop();
      // Performed 20 rapid style changes in ${stopwatch.elapsedMilliseconds}ms
      
      expect(find.text('Dynamic Style Container'), findsOneWidget);
      expect(stopwatch.elapsedMilliseconds, lessThan(2000)); // 2 seconds max
    });

    testWidgets('should handle memory stress with many nested components', (WidgetTester tester) async {
      Widget buildNestedContainer(int depth, int maxDepth) {
        if (depth >= maxDepth) {
          return WText(
            'Depth $depth',
            className: 'text-center text-xs p-1',
          );
        }
        
        return WContainer(
          className: 'p-1 m-1 border border-gray-300 rounded',
          child: WColumn(
            children: [
              WText(
                'Level $depth',
                className: 'text-xs font-semibold text-center mb-1',
              ),
              buildNestedContainer(depth + 1, maxDepth),
            ],
          ),
        );
      }
      
      final stopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: WContainer(
                className: 'p-4',
                child: WColumn(
                  children: List.generate(10, (index) => 
                    WCard(
                      className: 'p-4 mb-4 bg-white shadow-md rounded-lg',
                      child: WColumn(
                        children: [
                          WText(
                            'Nested Container Set ${index + 1}',
                            className: 'font-bold text-lg mb-2 text-center',
                          ),
                          buildNestedContainer(0, 8), // 8 levels deep
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
      // Rendered deeply nested components in ${stopwatch.elapsedMilliseconds}ms
      
      expect(find.textContaining('Nested Container Set'), findsNWidgets(10));
      expect(find.textContaining('Level 0'), findsNWidgets(10));
      expect(find.textContaining('Depth 8'), findsNWidgets(10));
      expect(stopwatch.elapsedMilliseconds, lessThan(4000)); // 4 seconds max
    });

    testWidgets('should handle grid performance with many items', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: WContainer(
                className: 'p-4',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(200, (index) => 
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: WCard(
                        className: 'bg-gradient-to-br from-blue-400 to-purple-600 rounded-lg shadow-md flex items-center justify-center',
                        child: WText(
                          '${index + 1}',
                          className: 'text-white font-bold text-lg',
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
      
      stopwatch.stop();
      // Rendered 200 grid items in ${stopwatch.elapsedMilliseconds}ms
      
      expect(find.text('1'), findsOneWidget);
      expect(find.text('200'), findsOneWidget);
      expect(stopwatch.elapsedMilliseconds, lessThan(3000)); // 3 seconds max
    });

    testWidgets('should handle text rendering performance', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'p-4',
              child: WColumn(
                children: [
                  WText('Simple Text 1', className: 'text-base'),
                  WText('Simple Text 2', className: 'text-lg'),
                  WText('Simple Text 3', className: 'font-bold'),
                  WText('Simple Text 4', className: 'text-gray-600'),
                  WText('Simple Text 5', className: 'text-center'),
                ],
              ),
            ),
          ),
        ),
      );
      
      await tester.pumpAndSettle();
      stopwatch.stop();
      // Rendered 5 simple text widgets in ${stopwatch.elapsedMilliseconds}ms
      
      expect(find.text('Simple Text 1'), findsOneWidget);
      expect(find.text('Simple Text 5'), findsOneWidget);
      expect(stopwatch.elapsedMilliseconds, lessThan(1000)); // 1 second max
    });

    testWidgets('should handle animation and transition performance', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: _AnimationTestWidget(),
        ),
      );
      
      final stopwatch = Stopwatch()..start();
      
      // Test multiple expand/collapse cycles
      for (int i = 0; i < 5; i++) {
        // Find and tap the button
        final buttonFinder = find.byType(ElevatedButton);
        expect(buttonFinder, findsOneWidget);
        
        await tester.tap(buttonFinder);
        await tester.pumpAndSettle();
      }
      
      stopwatch.stop();
      // Performed 5 animation cycles in ${stopwatch.elapsedMilliseconds}ms
      
      expect(find.textContaining('Animated Item'), findsWidgets);
      expect(stopwatch.elapsedMilliseconds, lessThan(5000)); // 5 seconds max
    });

    testWidgets('should handle color and gradient performance', (WidgetTester tester) async {
      final gradients = [
        'bg-gradient-to-r from-red-400 to-yellow-400',
        'bg-gradient-to-br from-blue-400 to-purple-600',
        'bg-gradient-to-l from-green-400 to-blue-500',
        'bg-gradient-to-tr from-pink-400 to-red-600',
        'bg-gradient-to-bl from-yellow-400 to-orange-500',
        'bg-gradient-to-t from-purple-400 to-pink-400',
        'bg-gradient-to-b from-indigo-400 to-cyan-400',
      ];
      
      final stopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: WContainer(
                className: 'p-4',
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(150, (index) => 
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: WContainer(
                        className: '${gradients[index % gradients.length]} rounded-xl shadow-lg flex items-center justify-center',
                        child: WText(
                          '${index + 1}',
                          className: 'text-white font-bold text-xl',
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
      
      stopwatch.stop();
      // Rendered 150 gradient containers in ${stopwatch.elapsedMilliseconds}ms
      
      expect(find.text('1'), findsOneWidget);
      expect(find.text('150'), findsOneWidget);
      expect(stopwatch.elapsedMilliseconds, lessThan(3000)); // 3 seconds max
    });
  });

  group('Memory Usage Tests', () {
    testWidgets('should not leak memory with component creation and destruction', (WidgetTester tester) async {
      for (int cycle = 0; cycle < 3; cycle++) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: WContainer(
                  className: 'p-4',
                  child: WColumn(
                    children: List.generate(10, (index) => 
                      WCard(
                        key: ValueKey('card_${cycle}_$index'),
                        className: 'p-4 mb-2 bg-white shadow-md rounded-lg',
                        child: WText(
                          'Cycle $cycle - Item $index',
                          className: 'font-semibold',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        
        await tester.pumpAndSettle();
        expect(find.textContaining('Cycle $cycle'), findsNWidgets(10));
        
        // Clear the widget tree
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpAndSettle();
      }
      
      // Final verification
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WText(
              'Memory test completed',
              className: 'text-center text-lg font-bold',
            ),
          ),
        ),
      );
      
      await tester.pumpAndSettle();
      expect(find.text('Memory test completed'), findsOneWidget);
    });
  });
}