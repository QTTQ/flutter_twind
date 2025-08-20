import 'package:flutter/material.dart';
import 'lib/utils/universal_style_parser.dart';

void main() {
  runApp(const HSLColorTestApp());
}

class HSLColorTestApp extends StatelessWidget {
  const HSLColorTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HSL Color Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HSLColorTestPage(),
    );
  }
}

class HSLColorTestPage extends StatelessWidget {
  const HSLColorTestPage({super.key});

  // 测试 HSL 颜色解析的辅助方法
  Color? testHSLColor(String hslString, BuildContext context) {
    // 直接调用解析方法
    return UniversalStyleParser.parseClassName(
      'bg-[$hslString]',
      'Container',
      context,
    )['backgroundColor'] as Color?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HSL Color Test'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'HSL Color Tests',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // HSL 基础颜色测试
            const Text(
              '1. HSL 基础颜色测试',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            
            // 红色 HSL
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: testHSLColor('hsl(0,100,50)',context),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'HSL Red: hsl(0, 100%, 50%)',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            
            // 绿色 HSL
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: testHSLColor('hsl(120,100,50)',context),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'HSL Green: hsl(120, 100%, 50%)',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            
            // 蓝色 HSL
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: testHSLColor('hsl(240,100,50)',context),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'HSL Blue: hsl(240, 100%, 50%)',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // HSLA 透明度测试
            const Text(
              '2. HSLA 透明度测试',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            
            // 半透明红色
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: testHSLColor('hsla(0,100,50,0.5)', context),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: const Text(
                'HSLA Red 50%: hsla(0, 100%, 50%, 0.5)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            
            // 半透明蓝色
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: testHSLColor('hsla(240,100,50,0.3)',context),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: const Text(
                'HSLA Blue 30%: hsla(240, 100%, 50%, 0.3)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            
            // 半透明绿色
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: testHSLColor('hsla(120,100,50,0.7)',context),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: const Text(
                'HSLA Green 70%: hsla(120, 100%, 50%, 0.7)',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // HSL 饱和度测试
            const Text(
              '3. HSL 饱和度测试 (蓝色 240°)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: testHSLColor('hsl(240,100,50)',context),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Saturation 100%',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: testHSLColor('hsl(240,75,50)',context),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Saturation 75%',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: testHSLColor('hsl(240,50,50)',context),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Saturation 50%',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: testHSLColor('hsl(240,25,50)',context),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Saturation 25%',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // HSL 亮度测试
            const Text(
              '4. HSL 亮度测试 (红色 0°)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: testHSLColor('hsl(0,100,75)',context),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Lightness 75%',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: testHSLColor('hsl(0,100,50)',context),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Lightness 50%',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: testHSLColor('hsl(0,100,25)',context),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Lightness 25%',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // HSL 色相环测试
            const Text(
              '5. HSL 色相环测试',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: testHSLColor('hsl(0,100,50)',context),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('0°', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: testHSLColor('hsl(60,100,50)',context),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('60°', style: TextStyle(color: Colors.black, fontSize: 10)),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: testHSLColor('hsl(120,100,50)',context),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('120°', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: testHSLColor('hsl(180,100,50)',context),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('180°', style: TextStyle(color: Colors.black, fontSize: 10)),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: testHSLColor('hsl(240,100,50)',context),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('240°', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: testHSLColor('hsl(300,100,50)',context),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('300°', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // 测试结果显示
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '测试结果：',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('HSL Red: ${testHSLColor('hsl(0,100,50)',context)}'),
                  Text('HSL Green: ${testHSLColor('hsl(120,100,50)',context)}'),
                  Text('HSL Blue: ${testHSLColor('hsl(240,100,50)',context)}'),
                  Text('HSLA Red 50%: ${testHSLColor('hsla(0,100,50,0.5)',context)}'),
                  const SizedBox(height: 8),
                  const Text(
                    '说明：',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text('• HSL 格式：hsl(色相, 饱和度%, 亮度%)'),
                  const Text('• HSLA 格式：hsla(色相, 饱和度%, 亮度%, 透明度)'),
                  const Text('• 色相范围：0-360度'),
                  const Text('• 饱和度范围：0-100%'),
                  const Text('• 亮度范围：0-100%'),
                  const Text('• 透明度范围：0.0-1.0'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}