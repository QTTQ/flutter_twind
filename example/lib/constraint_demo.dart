import 'package:flutter/material.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  // 初始化配置
  WindConfig.initialize();
  SmartStyleParser.initialize();
  runApp(ConstraintDemoApp());
}

class ConstraintDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Twind Constraint Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: ConstraintDemoPage(),
    );
  }
}

class ConstraintDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('约束功能演示'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '约束功能演示',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            
            // 宽度约束演示
            _buildSection(
              '宽度约束',
              [
                _buildDemo(
                  '最小宽度 100px',
                  WContainer(
                    className: 'min-w-100 bg-blue-500 p-4',
                    child: Text('min-w-100', style: TextStyle(color: Colors.white)),
                  ),
                ),
                _buildDemo(
                  '最大宽度 200px',
                  WContainer(
                    className: 'max-w-200 bg-red-500 p-4',
                    child: Text('max-w-200 这是一段很长的文本用来测试最大宽度约束效果', 
                         style: TextStyle(color: Colors.white)),
                  ),
                ),
                _buildDemo(
                  '宽度范围 100-200px',
                  WContainer(
                    className: 'min-w-100 max-w-200 bg-green-500 p-4',
                    child: Text('min-w-100 max-w-200', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            
            // 高度约束演示
            _buildSection(
              '高度约束',
              [
                _buildDemo(
                  '最小高度 80px',
                  WContainer(
                    className: 'min-h-80 bg-purple-500 p-4 w-200',
                    child: Text('min-h-80', style: TextStyle(color: Colors.white)),
                  ),
                ),
                _buildDemo(
                  '最大高度 60px',
                  WContainer(
                    className: 'max-h-60 bg-orange-500 p-4 w-200',
                    child: Text('max-h-60 这是很多内容\n换行\n更多内容\n测试最大高度', 
                         style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            
            // 组合约束演示
            _buildSection(
              '组合约束',
              [
                _buildDemo(
                  '完整约束组合',
                  WContainer(
                    className: 'min-w-150 max-w-250 min-h-100 max-h-150 bg-indigo-500 p-4',
                    child: Text(
                      '组合约束:\nmin-w-150 max-w-250\nmin-h-100 max-h-150',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                _buildDemo(
                  '嵌套约束',
                  WContainer(
                    className: 'min-w-200 max-w-300 bg-teal-500 p-4',
                    child: Column(
                      children: [
                        Text('外层容器约束', style: TextStyle(color: Colors.white)),
                        SizedBox(height: 8),
                        WContainer(
                          className: 'min-w-100 max-w-150 bg-yellow-500 p-2',
                          child: Text('内层容器约束', style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // 边界情况演示
            _buildSection(
              '边界情况',
              [
                _buildDemo(
                  '零约束',
                  WContainer(
                    className: 'min-w-0 min-h-0 bg-gray-500 p-2',
                    child: Text('零约束', style: TextStyle(color: Colors.white)),
                  ),
                ),
                _buildDemo(
                  '极大约束',
                  WContainer(
                    className: 'min-w-300 bg-pink-500 p-4',
                    child: Text('大宽度约束', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSection(String title, List<Widget> demos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        SizedBox(height: 12),
        ...demos,
        SizedBox(height: 24),
      ],
    );
  }
  
  Widget _buildDemo(String description, Widget demo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: demo,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}