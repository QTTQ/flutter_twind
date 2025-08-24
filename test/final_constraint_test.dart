import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  group('最终约束功能测试', () {
    testWidgets('约束功能完整测试 - 无崩溃', (WidgetTester tester) async {
      // 初始化配置
      WindConfig.initialize();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // 基本宽度约束
                  WContainer(
                    className: 'min-w-100 bg-blue-500 p-4 m-2',
                    child: Text('最小宽度100', style: TextStyle(color: Colors.white)),
                  ),
                  
                  // 基本高度约束
                  WContainer(
                    className: 'min-h-80 bg-red-500 p-4 m-2 w-200',
                    child: Text('最小高度80', style: TextStyle(color: Colors.white)),
                  ),
                  
                  // 组合约束
                  WContainer(
                    className: 'min-w-150 max-w-250 min-h-60 max-h-120 bg-green-500 p-4 m-2',
                    child: Text('组合约束测试', style: TextStyle(color: Colors.white)),
                  ),
                  
                  // 无约束对照组
                  WContainer(
                    className: 'bg-yellow-500 p-4 m-2',
                    child: Text('无约束对照', style: TextStyle(color: Colors.black)),
                  ),
                  
                  // 嵌套约束
                  WContainer(
                    className: 'min-w-200 bg-purple-500 p-4 m-2',
                    child: Column(
                      children: [
                        Text('外层约束', style: TextStyle(color: Colors.white)),
                        WContainer(
                          className: 'min-w-100 max-w-150 bg-orange-500 p-2 m-1',
                          child: Text('内层约束', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // 验证所有组件都能正常渲染
      expect(find.text('最小宽度100'), findsOneWidget);
      expect(find.text('最小高度80'), findsOneWidget);
      expect(find.text('组合约束测试'), findsOneWidget);
      expect(find.text('无约束对照'), findsOneWidget);
      expect(find.text('外层约束'), findsOneWidget);
      expect(find.text('内层约束'), findsOneWidget);
      
      // 等待所有动画完成
      await tester.pumpAndSettle();
      
      // 验证没有异常
      expect(tester.takeException(), isNull);
    });

    testWidgets('边界值测试 - 零值和极值', (WidgetTester tester) async {
      WindConfig.initialize();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 零值测试
                WContainer(
                  className: 'min-w-0 min-h-0 bg-gray-500 p-1',
                  child: Text('零值测试'),
                ),
                
                // 极大值测试
                WContainer(
                  className: 'min-w-500 bg-indigo-500 p-2',
                  child: Text('极大值测试', style: TextStyle(color: Colors.white)),
                ),
                
                // 相等值测试
                WContainer(
                  className: 'min-w-100 max-w-100 bg-teal-500 p-2',
                  child: Text('相等约束', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('零值测试'), findsOneWidget);
      expect(find.text('极大值测试'), findsOneWidget);
      expect(find.text('相等约束'), findsOneWidget);
      
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });
}