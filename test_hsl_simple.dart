import 'package:flutter/material.dart';
import 'lib/utils/universal_style_parser.dart';

void main() {
  runApp(const HSLTestApp());
}

class HSLTestApp extends StatelessWidget {
  const HSLTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HSL Color Test',
      home: const HSLTestPage(),
    );
  }
}

class HSLTestPage extends StatelessWidget {
  const HSLTestPage({super.key});

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
              'HSL Color Parser Test',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // 测试基础 HSL 颜色
            _buildColorTest(context, 'hsl(0,100,50)', '红色 HSL'),
            _buildColorTest(context, 'hsl(120,100,50)', '绿色 HSL'),
            _buildColorTest(context, 'hsl(240,100,50)', '蓝色 HSL'),
            
            const SizedBox(height: 20),
            const Text(
              'HSLA 透明度测试',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            
            // 测试 HSLA 颜色
            _buildColorTest(context, 'hsla(0,100,50,0.5)', '红色 50% 透明'),
            _buildColorTest(context, 'hsla(120,100,50,0.3)', '绿色 30% 透明'),
            _buildColorTest(context, 'hsla(240,100,50,0.7)', '蓝色 70% 透明'),
            
            const SizedBox(height: 20),
            const Text(
              '色相环测试',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            
            // 色相环
            Row(
              children: [
                _buildSmallColorBox(context, 'hsl(0,100,50)', '0°'),
                _buildSmallColorBox(context, 'hsl(60,100,50)', '60°'),
                _buildSmallColorBox(context, 'hsl(120,100,50)', '120°'),
                _buildSmallColorBox(context, 'hsl(180,100,50)', '180°'),
                _buildSmallColorBox(context, 'hsl(240,100,50)', '240°'),
                _buildSmallColorBox(context, 'hsl(300,100,50)', '300°'),
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
                    '解析结果测试：',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildParseResult(context, 'hsl(0,100,50)'),
                  _buildParseResult(context, 'hsl(120,100,50)'),
                  _buildParseResult(context, 'hsl(240,100,50)'),
                  _buildParseResult(context, 'hsla(0,100,50,0.5)'),
                  _buildParseResult(context, 'hsla(120,100,50,0.3)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorTest(BuildContext context, String hslString, String label) {
    final styles = UniversalStyleParser.parseClassName(
      'bg-[$hslString]',
      'Container',
      context,
    );
    final color = styles['backgroundColor'] as Color?;
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? Colors.grey,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label: $hslString',
              style: TextStyle(
                color: _getContrastColor(color),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: 60,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: Text(
                color != null ? 'OK' : 'FAIL',
                style: TextStyle(
                  fontSize: 10,
                  color: color != null ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallColorBox(BuildContext context, String hslString, String label) {
    final styles = UniversalStyleParser.parseClassName(
      'bg-[$hslString]',
      'Container',
      context,
    );
    final color = styles['backgroundColor'] as Color?;
    
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color ?? Colors.grey,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _getContrastColor(color),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildParseResult(BuildContext context, String hslString) {
    final styles = UniversalStyleParser.parseClassName(
      'bg-[$hslString]',
      'Container',
      context,
    );
    final color = styles['backgroundColor'] as Color?;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color ?? Colors.grey,
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: Colors.grey),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$hslString → ${color?.toString() ?? 'null'}',
              style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }

  Color _getContrastColor(Color? backgroundColor) {
    if (backgroundColor == null) return Colors.black;
    
    // 计算亮度来决定文字颜色
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}