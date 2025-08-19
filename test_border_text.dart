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
        appBar: AppBar(title: Text('Border and Text Test')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 测试 border-red
              WContainer(
                className: 'w-20 h-20 border-2 border-red rounded-lg bg-white',
                child: Center(child: Text('Border Red')),
              ),
              SizedBox(height: 20),

              // 测试 text-center
              WContainer(
                className: 'w-64 h-20 border-2 border-red rounded-lg bg-white flex justify-center items-center',
                child: WText(
                  'Centered Text',
                  className: 'text-center text-lg font-bold text-blue',
                ),
              ),
              SizedBox(height: 20),
              WContainer(
                className:
                    'w-8 h-8 rounded-full bg-gray-300 flex justify-center items-center border-2 border-red',
                child: WText(
                  '1',
                  className: 'text-black text-sm font-medium text-center',
                ),
              ),
              SizedBox(height: 20),

              // 测试你的原始代码场景
              WContainer(
                className:
                    'w-8 h-8 rounded-full bg-gray-300 flex justify-center items-center border-2 border-red',
                child: WText(
                  '1',
                  className: 'text-black text-sm font-medium text-center',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
