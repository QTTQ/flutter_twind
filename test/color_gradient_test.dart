import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';


void main() {
  setUpAll(() {
    WindConfig.initialize();
    SmartStyleParser.initialize();
  });

  group('Custom Color System Tests', () {
    testWidgets('should support custom brand colors', (WidgetTester tester) async {
      // Add custom brand colors
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
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WColumn(
              children: [
                WContainer(
                  className: 'bg-brand-500 p-4 mb-2',
                  child: WText('Brand 500', className: 'text-white text-center'),
                ),
                WContainer(
                  className: 'bg-brand-700 p-4 mb-2',
                  child: WText('Brand 700', className: 'text-white text-center'),
                ),
                WText(
                  'Brand Text',
                  className: 'text-brand-600 font-bold text-lg',
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Brand 500'), findsOneWidget);
      expect(find.text('Brand 700'), findsOneWidget);
      expect(find.text('Brand Text'), findsOneWidget);
    });

    testWidgets('should support custom accent colors', (WidgetTester tester) async {
      // Add custom accent colors
      SmartStyleParser.addColorSystem('accent', {
        '100': const Color(0xFFFEF3C7),
        '200': const Color(0xFFFDE68A),
        '300': const Color(0xFFFCD34D),
        '400': const Color(0xFFFBBF24),
        '500': const Color(0xFFF59E0B),
        '600': const Color(0xFFD97706),
        '700': const Color(0xFFB45309),
        '800': const Color(0xFF92400E),
        '900': const Color(0xFF78350F),
      });
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WFlex(
              className: 'flex-row flex-wrap gap-2 p-4',
              children: List.generate(9, (index) => 
                WContainer(
                  className: 'bg-accent-${(index + 1) * 100} p-3 rounded',
                  child: WText(
                    '${(index + 1) * 100}',
                    className: index < 3 ? 'text-gray-800' : 'text-white',
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      
      expect(find.byType(WContainer), findsNWidgets(9));
      for (int i = 1; i <= 9; i++) {
        expect(find.text('${i * 100}'), findsOneWidget);
      }
    });

    testWidgets('should support multiple custom color systems', (WidgetTester tester) async {
      // Add multiple custom color systems
      SmartStyleParser.addColorSystem('primary', {
        '500': const Color(0xFF3B82F6),
        '600': const Color(0xFF2563EB),
        '700': const Color(0xFF1D4ED8),
      });
      
      SmartStyleParser.addColorSystem('secondary', {
        '500': const Color(0xFF10B981),
        '600': const Color(0xFF059669),
        '700': const Color(0xFF047857),
      });
      
      SmartStyleParser.addColorSystem('danger', {
        '500': const Color(0xFFEF4444),
        '600': const Color(0xFFDC2626),
        '700': const Color(0xFFB91C1C),
      });
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WColumn(
              className: 'p-4 space-y-4',
              children: [
                WButton(
                  text: 'Primary Button',
                  onPressed: () {},
                  className: 'bg-primary-500 hover:bg-primary-600 text-white p-3 rounded',
                ),
                WButton(
                  text: 'Secondary Button',
                  onPressed: () {},
                  className: 'bg-secondary-500 hover:bg-secondary-600 text-white p-3 rounded',
                ),
                WButton(
                  text: 'Danger Button',
                  onPressed: () {},
                  className: 'bg-danger-500 hover:bg-danger-600 text-white p-3 rounded',
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Primary Button'), findsOneWidget);
      expect(find.text('Secondary Button'), findsOneWidget);
      expect(find.text('Danger Button'), findsOneWidget);
    });
  });

  group('Gradient Background Tests', () {
    testWidgets('should support linear gradients to right', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'bg-gradient-to-r from-blue-500 to-purple-600 p-8',
              child: WText(
                'Linear Gradient Right',
                className: 'text-white text-center text-xl font-bold',
              ),
            ),
          ),
        ),
      );
      
      expect(find.text('Linear Gradient Right'), findsOneWidget);
      expect(find.byType(WContainer), findsOneWidget);
    });

    testWidgets('should support linear gradients to bottom', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'bg-gradient-to-b from-red-400 to-yellow-500 p-8',
              child: WText(
                'Linear Gradient Bottom',
                className: 'text-white text-center text-xl font-bold',
              ),
            ),
          ),
        ),
      );
      
      expect(find.text('Linear Gradient Bottom'), findsOneWidget);
    });

    testWidgets('should support diagonal gradients', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WColumn(
              children: [
                WContainer(
                  className: 'bg-gradient-to-br from-green-400 to-blue-600 p-6 mb-4',
                  child: WText(
                    'Bottom Right Gradient',
                    className: 'text-white text-center font-semibold',
                  ),
                ),
                WContainer(
                  className: 'bg-gradient-to-tl from-pink-500 to-orange-400 p-6 mb-4',
                  child: WText(
                    'Top Left Gradient',
                    className: 'text-white text-center font-semibold',
                  ),
                ),
                WContainer(
                  className: 'bg-gradient-to-tr from-purple-500 to-cyan-400 p-6',
                  child: WText(
                    'Top Right Gradient',
                    className: 'text-white text-center font-semibold',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Bottom Right Gradient'), findsOneWidget);
      expect(find.text('Top Left Gradient'), findsOneWidget);
      expect(find.text('Top Right Gradient'), findsOneWidget);
    });

    testWidgets('should support gradients with via colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WColumn(
              children: [
                WContainer(
                  className: 'bg-gradient-to-r from-red-500 via-yellow-500 to-green-500 p-6 mb-4',
                  child: WText(
                    'Three Color Gradient',
                    className: 'text-white text-center font-bold',
                  ),
                ),
                WContainer(
                  className: 'bg-gradient-to-b from-blue-600 via-purple-600 to-pink-600 p-6',
                  child: WText(
                    'Vertical Three Color',
                    className: 'text-white text-center font-bold',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Three Color Gradient'), findsOneWidget);
      expect(find.text('Vertical Three Color'), findsOneWidget);
    });

    testWidgets('should support radial gradients', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'bg-gradient-radial from-yellow-400 to-red-600 p-8',
              child: WText(
                'Radial Gradient',
                className: 'text-white text-center text-xl font-bold',
              ),
            ),
          ),
        ),
      );
      
      expect(find.text('Radial Gradient'), findsOneWidget);
    });
  });

  group('Arbitrary Color Values Tests', () {
    testWidgets('should support hex color values', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WColumn(
              children: [
                WContainer(
                  className: 'bg-[#ff6b6b] p-4 mb-2',
                  child: WText('Hex Color', className: 'text-white text-center'),
                ),
                WContainer(
                  className: 'bg-[#4ecdc4] p-4 mb-2',
                  child: WText('Another Hex', className: 'text-white text-center'),
                ),
                WText(
                  'Hex Text Color',
                  className: 'text-[#ff6b6b] font-bold text-lg',
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Hex Color'), findsOneWidget);
      expect(find.text('Another Hex'), findsOneWidget);
      expect(find.text('Hex Text Color'), findsOneWidget);
    });

    testWidgets('should support RGB color values', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WColumn(
              children: [
                WContainer(
                  className: 'bg-[rgb(255,107,107)] p-4 mb-2',
                  child: WText('RGB Color', className: 'text-white text-center'),
                ),
                WContainer(
                  className: 'bg-[rgb(78,205,196)] p-4 mb-2',
                  child: WText('Another RGB', className: 'text-white text-center'),
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('RGB Color'), findsOneWidget);
      expect(find.text('Another RGB'), findsOneWidget);
    });

    testWidgets('should support RGBA color values with opacity', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WColumn(
              children: [
                WContainer(
                  className: 'bg-[rgba(255,107,107,0.8)] p-4 mb-2',
                  child: WText('RGBA Color', className: 'text-white text-center'),
                ),
                WContainer(
                  className: 'bg-[rgba(78,205,196,0.6)] p-4 mb-2',
                  child: WText('Transparent RGBA', className: 'text-white text-center'),
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('RGBA Color'), findsOneWidget);
      expect(find.text('Transparent RGBA'), findsOneWidget);
    });

    testWidgets('should support HSL color values', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WColumn(
              children: [
                WContainer(
                  className: 'bg-[hsl(0,100%,70%)] p-4 mb-2',
                  child: WText('HSL Red', className: 'text-white text-center'),
                ),
                WContainer(
                  className: 'bg-[hsl(120,100%,50%)] p-4 mb-2',
                  child: WText('HSL Green', className: 'text-white text-center'),
                ),
                WContainer(
                  className: 'bg-[hsl(240,100%,50%)] p-4 mb-2',
                  child: WText('HSL Blue', className: 'text-white text-center'),
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('HSL Red'), findsOneWidget);
      expect(find.text('HSL Green'), findsOneWidget);
      expect(find.text('HSL Blue'), findsOneWidget);
    });

    testWidgets('should support HSLA color values with opacity', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WColumn(
              children: [
                WContainer(
                  className: 'bg-[hsla(0,100%,70%,0.7)] p-4 mb-2',
                  child: WText('HSLA Red', className: 'text-white text-center'),
                ),
                WContainer(
                  className: 'bg-[hsla(120,100%,50%,0.5)] p-4 mb-2',
                  child: WText('HSLA Green', className: 'text-white text-center'),
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('HSLA Red'), findsOneWidget);
      expect(find.text('HSLA Green'), findsOneWidget);
    });
  });

  group('Color Opacity Tests', () {
    testWidgets('should support color opacity modifiers', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WColumn(
              children: [
                WContainer(
                  className: 'bg-red-500/25 p-4 mb-2',
                  child: WText('25% Opacity', className: 'text-gray-800 text-center'),
                ),
                WContainer(
                  className: 'bg-blue-500/50 p-4 mb-2',
                  child: WText('50% Opacity', className: 'text-white text-center'),
                ),
                WContainer(
                  className: 'bg-green-500/75 p-4 mb-2',
                  child: WText('75% Opacity', className: 'text-white text-center'),
                ),
                WText(
                  'Text with Opacity',
                  className: 'text-purple-600/60 font-bold text-lg',
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('25% Opacity'), findsOneWidget);
      expect(find.text('50% Opacity'), findsOneWidget);
      expect(find.text('75% Opacity'), findsOneWidget);
      expect(find.text('Text with Opacity'), findsOneWidget);
    });
  });

  group('Complex Color Combinations Tests', () {
    testWidgets('should handle complex color and gradient combinations', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WContainer(
              className: 'bg-gradient-to-br from-purple-600 via-pink-600 to-blue-600 p-8',
              child: WColumn(
                className: 'space-y-4',
                children: [
                  WCard(
                    className: 'bg-white/90 backdrop-blur-sm p-6 rounded-xl shadow-2xl',
                    child: WColumn(
                      children: [
                        WText(
                          'Gradient Card',
                          className: 'text-gray-800 text-2xl font-bold mb-4',
                        ),
                        WText(
                          'This card has a semi-transparent background over a gradient.',
                          className: 'text-gray-600 mb-4',
                        ),
                        WButton(
                          text: 'Gradient Button',
                          onPressed: () {},
                          className: 'bg-gradient-to-r from-pink-500 to-violet-500 text-white px-6 py-3 rounded-lg font-semibold',
                        ),
                      ],
                    ),
                  ),
                  WContainer(
                    className: 'bg-black/20 backdrop-blur-md p-4 rounded-lg border border-white/30',
                    child: WText(
                      'Glassmorphism Effect',
                      className: 'text-white text-center font-semibold',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      
      expect(find.text('Gradient Card'), findsOneWidget);
      expect(find.text('Gradient Button'), findsOneWidget);
      expect(find.text('Glassmorphism Effect'), findsOneWidget);
    });

    testWidgets('should create color palette showcase', (WidgetTester tester) async {
      final shades = [100, 300, 500, 700, 900];
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: WContainer(
                className: 'p-4',
                child: WColumn(
                  children: [
                    WText(
                      'Color Palette Showcase',
                      className: 'text-3xl font-bold text-center mb-8',
                    ),
                    // 简化测试，只测试一个颜色
                    WContainer(
                      className: 'mb-6',
                      child: WColumn(
                        children: [
                          WText(
                            'RED',
                            className: 'text-lg font-semibold mb-2',
                          ),
                          WFlex(
                            className: 'flex-row gap-1',
                            children: shades.map((shade) => 
                              WContainer(
                                className: 'bg-red-$shade flex-1 h-16 rounded flex items-center justify-center',
                                child: WText(
                                  '$shade',
                                  className: shade >= 500 ? 'text-white font-semibold' : 'text-gray-800 font-semibold',
                                ),
                              ),
                            ).toList(),
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
      
      expect(find.text('Color Palette Showcase'), findsOneWidget);
      expect(find.text('RED'), findsOneWidget);
      // 验证shade文本也能找到
      expect(find.text('100'), findsOneWidget);
      expect(find.text('500'), findsOneWidget);
    });
  });
}