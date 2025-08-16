import 'package:flutter/material.dart';
import 'lib/flutter_twind.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('测试 Border 和 Text Center')),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // 测试 border-red
              WContainer(
                className: 'w-20 h-20 border-2 border-red rounded-lg bg-white',
                child: Center(child: Text('红色边框')),
              ),
              SizedBox(height: 20),
              
              // 测试 text-center
              WContainer(
                className: 'w-full h-16 bg-gray-100 p-4',
                child: WText(
                  '居中文本测试',
                  className: 'text-center text-lg font-bold',
                ),
              ),
              SizedBox(height: 20),
              
              // 测试你的原始场景
              Row(
                children: [
                  WContainer(
                    className: 'w-8 h-8 rounded-full bg-red-500 flex justify-center items-center',
                    child: Icon(Icons.check, color: Colors.white, size: 16),
                  ),
                  SizedBox(width: 10),
                  WContainer(
                    className: 'w-8 h-8 rounded-full bg-gray-300 flex justify-center items-center border-2 border-red',
                    child: WText('2', className: 'text-white text-sm font-medium text-center'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}