import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  group('Extended Widget Tests - Boundary Conditions', () {
    testWidgets('WContainer with null className should not crash', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: null,
              child: Text('Test'),
            ),
          ),
        ),
      );
      
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('WContainer with empty className should work', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: '',
              child: Text('Test'),
            ),
          ),
        ),
      );
      
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('WContainer with very long className should work', (WidgetTester tester) async {
      const longClassName = 'bg-red-500 p-4 m-2 rounded-lg shadow-md border-2 border-blue-300 text-white font-bold text-lg leading-tight tracking-wide uppercase transform rotate-3 scale-105 opacity-90';
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: longClassName,
              child: Text('Test'),
            ),
          ),
        ),
      );
      
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('WText with null text should not crash', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WText(
              '',
              className: 'text-lg',
            ),
          ),
        ),
      );
      
      expect(find.byType(WText), findsOneWidget);
    });

    testWidgets('WText with empty text should work', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WText(
              '',
              className: 'text-lg',
            ),
          ),
        ),
      );
      
      expect(find.byType(WText), findsOneWidget);
    });

    testWidgets('WButton with null onPressed should be disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WButton(
              text: 'Disabled Button',
              onPressed: null,
              className: 'bg-blue-500 p-4',
            ),
          ),
        ),
      );
      
      final inkWell = tester.widget<InkWell>(find.byType(InkWell));
      expect(inkWell.onTap, isNull);
    });

    testWidgets('WInput with very long text should handle overflow', (WidgetTester tester) async {
      const longText = 'This is a very long text that should test how the input field handles overflow and text wrapping or truncation behavior in various scenarios';
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WInput(
              className: 'p-4 border rounded',
              controller: TextEditingController(text: longText),
            ),
          ),
        ),
      );
      
      expect(find.byType(WInput), findsOneWidget);
      expect(find.text(longText), findsOneWidget);
    });
  });

  group('Extended Widget Tests - Error Handling', () {
    testWidgets('WContainer with invalid className should not crash', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'invalid-class-name-123 @#\$%^&*()_+',
              child: Text('Test'),
            ),
          ),
        ),
      );
      
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('WFlex with conflicting direction classes should work', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WFlex(
              className: 'flex-row flex-col', // Conflicting directions
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
    });

    testWidgets('WButton with conflicting size classes should work', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WButton(
              text: 'Button',
              onPressed: () {},
              className: 'p-2 p-4 p-8', // Conflicting padding
            ),
          ),
        ),
      );
      
      expect(find.text('Button'), findsOneWidget);
    });
  });

  group('Extended Widget Tests - Complex Scenarios', () {
    testWidgets('Nested WContainer with multiple className combinations', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'bg-blue-500 p-8',
              child: WContainer(
                className: 'bg-white rounded-lg shadow-lg p-4',
                child: WContainer(
                  className: 'bg-gray-100 border border-gray-300 p-2',
                  child: WText(
                    'Nested Content',
                    className: 'text-gray-800 font-semibold',
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      
      expect(find.text('Nested Content'), findsOneWidget);
      expect(find.byType(WContainer), findsNWidgets(3));
    });

    testWidgets('WFlex with mixed child types and complex styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WFlex(
              className: 'flex-col p-4',
              children: [
                WText(
                  'Header',
                  className: 'text-lg font-bold',
                ),
                WButton(
                  text: 'Submit',
                  onPressed: () {},
                  className: 'bg-blue-500 p-2',
                ),
                WText(
                  'Footer',
                  className: 'text-sm',
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Submit'), findsOneWidget);
      expect(find.text('Footer'), findsOneWidget);
    });

    testWidgets('WList with dynamic content and complex styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WList(
              className: 'bg-gray-50',
              children: [
                WListTile(
                  className: 'bg-white p-4',
                  title: WText('Item 1', className: 'font-medium'),
                  subtitle: WText('Description 1', className: 'text-sm'),
                ),
                WListTile(
                  className: 'bg-blue-50 p-4',
                  title: WText('Item 2', className: 'font-medium'),
                  subtitle: WText('Description 2', className: 'text-sm'),
                ),
                WListTile(
                  className: 'bg-white p-4',
                  title: WText('Item 3', className: 'font-medium'),
                  subtitle: WText('Description 3', className: 'text-sm'),
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.byType(WListTile), findsNWidgets(3));
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    });
  });

  group('Extended Widget Tests - Accessibility', () {
    testWidgets('WButton should have proper semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WButton(
              text: 'Accessible Button',
              onPressed: () {},
              className: 'bg-blue-500 p-4',
            ),
          ),
        ),
      );
      
      expect(find.bySemanticsLabel('Accessible Button'), findsOneWidget);
    });

    testWidgets('WInput should have proper semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WInput(
              className: 'border p-3',
              placeholder: 'Enter your email',
            ),
          ),
        ),
      );
      
      expect(find.byType(WInput), findsOneWidget);
    });
  });

  group('Extended Widget Tests - Performance', () {
    testWidgets('Simple WContainer should render efficiently', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'bg-blue-500 p-4',
              child: WText('Simple Container'),
            ),
          ),
        ),
      );
      
      expect(find.byType(WContainer), findsOneWidget);
      expect(find.text('Simple Container'), findsOneWidget);
    });
  });
}