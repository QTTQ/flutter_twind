import 'package:flutter/material.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  // 初始化WindConfig
  WindConfig.initialize();
  runApp(const IconStyleTestApp());
}

class IconStyleTestApp extends StatelessWidget {
  const IconStyleTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Icon Style Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const IconStyleTestPage(),
    );
  }
}

class IconStyleTestPage extends StatelessWidget {
  const IconStyleTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WIcon样式测试'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('测试WIcon组件的样式支持：', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            
            // 测试 text-red-900 颜色
            Row(
              children: [
                const Text('text-red-900: '),
                WIcon(
                  Icons.star,
                  className: 'text-red-900',
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // 测试 text-lg 大小
            Row(
              children: [
                const Text('text-lg (18px): '),
                WIcon(
                  Icons.star,
                  className: 'text-lg',
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // 测试 ml-10 边距
            Row(
              children: [
                const Text('ml-10 (40px margin): '),
                WIcon(
                  Icons.star,
                  className: 'ml-10',
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // 测试组合样式
            Row(
              children: [
                const Text('组合样式 text-red-900 text-lg ml-10: '),
                WIcon(
                  Icons.star,
                  className: 'text-red-900 text-lg ml-10',
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // 对比：使用直接属性
            Row(
              children: [
                const Text('直接属性 (red-900, 18px): '),
                WIcon(
                  Icons.star,
                  color: const Color(0xFF7F1D1D), // red-900
                  size: 18,
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // 测试其他颜色
            const Text('其他颜色测试：', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                WIcon(Icons.star, className: 'text-blue-500'),
                const SizedBox(width: 10),
                WIcon(Icons.star, className: 'text-green-500'),
                const SizedBox(width: 10),
                WIcon(Icons.star, className: 'text-yellow-500'),
                const SizedBox(width: 10),
                WIcon(Icons.star, className: 'text-purple-500'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}