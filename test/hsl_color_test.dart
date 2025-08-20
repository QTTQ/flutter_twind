import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/utils/universal_style_parser.dart';

void main() {
  testWidgets('HSL Color Parser Tests', (WidgetTester tester) async {
    late BuildContext context;
    
    // 创建测试环境
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext ctx) {
          context = ctx;
          return Container();
        },
      ),
    ));

    // 测试基础 HSL 颜色
    print('🧪 Testing Basic HSL Colors...');
    
    // 测试红色 HSL
    final redStyles = UniversalStyleParser.parseClassName(
      'bg-[hsl(0,100,50)]',
      'Container',
      context,
    );
    final redColor = redStyles['backgroundColor'] as Color?;
    expect(redColor, isNotNull, reason: 'Red HSL color should be parsed');
    expect(redColor!.red, greaterThan(200), reason: 'Red component should be high');
    expect(redColor.green, lessThan(50), reason: 'Green component should be low');
    expect(redColor.blue, lessThan(50), reason: 'Blue component should be low');
    print('✅ Red HSL: $redColor');

    // 测试绿色 HSL
    final greenStyles = UniversalStyleParser.parseClassName(
      'bg-[hsl(120,100,50)]',
      'Container',
      context,
    );
    final greenColor = greenStyles['backgroundColor'] as Color?;
    expect(greenColor, isNotNull, reason: 'Green HSL color should be parsed');
    expect(greenColor!.green, greaterThan(200), reason: 'Green component should be high');
    expect(greenColor.red, lessThan(50), reason: 'Red component should be low');
    expect(greenColor.blue, lessThan(50), reason: 'Blue component should be low');
    print('✅ Green HSL: $greenColor');

    // 测试蓝色 HSL
    final blueStyles = UniversalStyleParser.parseClassName(
      'bg-[hsl(240,100,50)]',
      'Container',
      context,
    );
    final blueColor = blueStyles['backgroundColor'] as Color?;
    expect(blueColor, isNotNull, reason: 'Blue HSL color should be parsed');
    expect(blueColor!.blue, greaterThan(200), reason: 'Blue component should be high');
    expect(blueColor.red, lessThan(50), reason: 'Red component should be low');
    expect(blueColor.green, lessThan(50), reason: 'Green component should be low');
    print('✅ Blue HSL: $blueColor');

    // 测试 HSLA 透明度
    print('\n🧪 Testing HSLA Colors with Alpha...');
    
    // 测试半透明红色
    final redAlphaStyles = UniversalStyleParser.parseClassName(
      'bg-[hsla(0,100,50,0.5)]',
      'Container',
      context,
    );
    final redAlphaColor = redAlphaStyles['backgroundColor'] as Color?;
    expect(redAlphaColor, isNotNull, reason: 'HSLA red color should be parsed');
    expect(redAlphaColor!.alpha, closeTo(127, 10), reason: '50% alpha should be around 127');
    expect(redAlphaColor.red, greaterThan(200), reason: 'Red component should be high');
    print('✅ HSLA Red 50%: $redAlphaColor');

    // 测试 30% 透明度蓝色
    final blueAlphaStyles = UniversalStyleParser.parseClassName(
      'bg-[hsla(240,100,50,0.3)]',
      'Container',
      context,
    );
    final blueAlphaColor = blueAlphaStyles['backgroundColor'] as Color?;
    expect(blueAlphaColor, isNotNull, reason: 'HSLA blue color should be parsed');
    expect(blueAlphaColor!.alpha, closeTo(76, 10), reason: '30% alpha should be around 76');
    expect(blueAlphaColor.blue, greaterThan(200), reason: 'Blue component should be high');
    print('✅ HSLA Blue 30%: $blueAlphaColor');

    // 测试饱和度和亮度
    print('\n🧪 Testing Saturation and Lightness...');
    
    // 测试不同饱和度
    final fullSatStyles = UniversalStyleParser.parseClassName(
      'bg-[hsl(240,100,50)]',
      'Container',
      context,
    );
    final fullSatColor = fullSatStyles['backgroundColor'] as Color?;

    final halfSatStyles = UniversalStyleParser.parseClassName(
      'bg-[hsl(240,50,50)]',
      'Container',
      context,
    );
    final halfSatColor = halfSatStyles['backgroundColor'] as Color?;

    expect(fullSatColor, isNotNull);
    expect(halfSatColor, isNotNull);
    expect(fullSatColor!.blue, greaterThan(halfSatColor!.blue), 
           reason: 'Higher saturation should have more vivid color');
    print('✅ Saturation 100%: $fullSatColor');
    print('✅ Saturation 50%: $halfSatColor');

    // 测试不同亮度
    final lightStyles = UniversalStyleParser.parseClassName(
      'bg-[hsl(0,100,75)]',
      'Container',
      context,
    );
    final lightColor = lightStyles['backgroundColor'] as Color?;

    final darkStyles = UniversalStyleParser.parseClassName(
      'bg-[hsl(0,100,25)]',
      'Container',
      context,
    );
    final darkColor = darkStyles['backgroundColor'] as Color?;

    expect(lightColor, isNotNull);
    expect(darkColor, isNotNull);
    expect(lightColor!.red, greaterThan(darkColor!.red), 
           reason: 'Higher lightness should have brighter color');
    print('✅ Lightness 75%: $lightColor');
    print('✅ Lightness 25%: $darkColor');

    // 测试色相环
    print('\n🧪 Testing Color Wheel Hues...');
    final hueTests = [
      {'hue': 0, 'name': 'Red'},
      {'hue': 60, 'name': 'Yellow'},
      {'hue': 120, 'name': 'Green'},
      {'hue': 180, 'name': 'Cyan'},
      {'hue': 240, 'name': 'Blue'},
      {'hue': 300, 'name': 'Magenta'},
    ];

    for (final test in hueTests) {
      final styles = UniversalStyleParser.parseClassName(
        'bg-[hsl(${test['hue']},100,50)]',
        'Container',
        context,
      );
      final color = styles['backgroundColor'] as Color?;
      expect(color, isNotNull, reason: 'Hue ${test['hue']} should be parsed correctly');
      print('✅ ${test['name']} (${test['hue']}°): $color');
    }

    // 测试边界情况
    print('\n🧪 Testing Edge Cases...');
    final edgeCases = [
      {'hsl': 'hsl(0,0,0)', 'name': 'Black'},
      {'hsl': 'hsl(0,0,100)', 'name': 'White'},
      {'hsl': 'hsl(360,100,50)', 'name': '360° Red'},
      {'hsl': 'hsla(0,100,50,0)', 'name': 'Transparent'},
      {'hsl': 'hsla(0,100,50,1)', 'name': 'Opaque'},
    ];

    for (final test in edgeCases) {
      final styles = UniversalStyleParser.parseClassName(
        'bg-[${test['hsl']}]',
        'Container',
        context,
      );
      final color = styles['backgroundColor'] as Color?;
      expect(color, isNotNull, reason: 'Edge case ${test['hsl']} should be parsed');
      print('✅ ${test['name']}: $color');
    }

    // 测试文字和边框颜色
    print('\n🧪 Testing Text and Border Colors...');
    
    // 测试文字颜色
    final textStyles = UniversalStyleParser.parseClassName(
      'text-[hsl(240,100,50)]',
      'Text',
      context,
    );
    final textColor = textStyles['color'] as Color?;
    expect(textColor, isNotNull, reason: 'HSL text color should be parsed');
    expect(textColor!.blue, greaterThan(200), reason: 'Blue text color should be vivid');
    print('✅ Text Color: $textColor');

    // 测试边框颜色
    final borderStyles = UniversalStyleParser.parseClassName(
      'border-[hsl(120,100,50)] border',
      'Container',
      context,
    );
    final borderColor = borderStyles['borderColor'] as Color?;
    expect(borderColor, isNotNull, reason: 'HSL border color should be parsed');
    expect(borderColor!.green, greaterThan(200), reason: 'Green border color should be vivid');
    print('✅ Border Color: $borderColor');

    // 测试完成
    print('\n🎉 All HSL Color Parser Tests Passed!');
    print('📊 Test Summary:');
    print('   ✅ Basic HSL colors (red, green, blue)');
    print('   ✅ HSLA colors with alpha transparency');
    print('   ✅ Saturation and lightness variations');
    print('   ✅ Complete color wheel (0°-360°)');
    print('   ✅ Edge cases and boundary values');
    print('   ✅ Text and border color parsing');
    print('   ✅ Custom HSL to RGB conversion algorithm');
    print('\n🚀 HSL color parsing is working perfectly!');
  });
}