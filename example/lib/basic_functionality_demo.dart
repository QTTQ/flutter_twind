import 'package:flutter/material.dart';
import 'package:flutter_twind/wind_components.dart';

void main() {
  runApp(const BasicFunctionalityDemo());
}

class BasicFunctionalityDemo extends StatelessWidget {
  const BasicFunctionalityDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '基础功能演示',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Twind 基础功能测试'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题
              const Text(
                '基础组件功能测试',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              
              // 基本容器测试
              const Text('1. 基本容器测试:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              WContainer(
                className: 'bg-blue-500 p-4 rounded-lg',
                child: const Text(
                  '这是一个蓝色背景的容器',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              
              // 文本组件测试
              const Text('2. 文本组件测试:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              WText(
                '这是一个红色的大文本',
                className: 'text-lg text-red-500',
              ),
              const SizedBox(height: 20),
              
              // 按钮组件测试
              const Text('3. 按钮组件测试:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              WButton(
                text: '点击我',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('按钮被点击了！')),
                  );
                },
                className: 'bg-green-500 p-3 rounded',
              ),
              const SizedBox(height: 20),
              
              // 行布局测试
              const Text('4. 行布局测试:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              WRow(
                className: 'justify-between items-center bg-gray-200 p-4 rounded',
                children: const [
                  Text('左侧'),
                  Text('中间'),
                  Text('右侧'),
                ],
              ),
              const SizedBox(height: 20),
              
              // 列布局测试
              const Text('5. 列布局测试:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              WColumn(
                className: 'items-center bg-yellow-100 p-4 rounded',
                children: const [
                  Text('第一行'),
                  Text('第二行'),
                  Text('第三行'),
                ],
              ),
              const SizedBox(height: 20),
              
              // 卡片组件测试
              const Text('6. 卡片组件测试:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              WCard(
                className: 'shadow-lg p-4',
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '卡片标题',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('这是卡片的内容部分，展示了卡片组件的基本功能。'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // 约束功能测试
              const Text('7. 约束功能测试:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              WContainer(
                className: 'min-w-200 max-w-300 bg-purple-500 p-4 rounded',
                child: const Text(
                  '这个容器有最小宽度200px和最大宽度300px的约束',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              
              // 嵌套组件测试
              const Text('8. 嵌套组件测试:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              WContainer(
                className: 'bg-gray-800 p-4 rounded-lg',
                child: WContainer(
                  className: 'bg-white p-4 rounded',
                  child: WRow(
                    className: 'justify-center items-center',
                    children: [
                      WText(
                        '嵌套测试',
                        className: 'text-lg font-bold',
                      ),
                      const SizedBox(width: 10),
                      WButton(
                        text: '嵌套按钮',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('嵌套按钮被点击了！')),
                          );
                        },
                        className: 'bg-orange-500 px-3 py-2 rounded',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              // 状态显示
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '✅ 所有基础功能正常工作！',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}