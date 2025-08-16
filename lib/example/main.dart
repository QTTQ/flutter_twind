import 'package:flutter/material.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  // 初始化Wind UI配置
  WindConfig.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TWind Demo',
      home: Scaffold(
        appBar: WAppBar(
          title: WText('Flutter TWind'),
          className: 'bg-blue-600',
        ),
        body: WContainer(
          className: 'p-4 bg-gray-50',
          child: WColumn(
            children: [
              WCard(
                className: 'mb-4 p-6',
                child: WText(
                  'Hello Flutter TWind!',
                  className: 'text-xl font-bold text-gray-900',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}