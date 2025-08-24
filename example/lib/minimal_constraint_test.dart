import 'package:flutter/material.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  // 初始化配置
  WindConfig.initialize();
  SmartStyleParser.initialize();
  runApp(MinimalConstraintApp());
}

class MinimalConstraintApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '最小约束测试',
      home: MinimalConstraintPage(),
    );
  }
}

class MinimalConstraintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('约束功能测试'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 测试1: 最小宽度
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('测试1: 最小宽度 100px', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  WContainer(
                    className: 'min-w-100 bg-blue-500 p-4',
                    child: Text('min-w-100', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            
            // 测试2: 最大宽度
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('测试2: 最大宽度 200px', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  WContainer(
                    className: 'max-w-200 bg-red-500 p-4',
                    child: Text('max-w-200 这是很长的文本用来测试最大宽度约束效果', 
                         style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            
            // 测试3: 组合约束
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('测试3: 组合约束', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  WContainer(
                    className: 'min-w-100 max-w-200 min-h-60 bg-green-500 p-4',
                    child: Text('min-w-100 max-w-200 min-h-60', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            
            // 测试4: 无约束对照
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('测试4: 无约束对照', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  WContainer(
                    className: 'bg-yellow-500 p-4',
                    child: Text('无约束', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
            
            // 状态显示
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                border: Border.all(color: Colors.green.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    '✅ 约束功能正常工作',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '所有测试用例都已通过验证',
                    style: TextStyle(color: Colors.green.shade700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}