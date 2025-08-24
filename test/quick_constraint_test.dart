import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  group('快速约束测试', () {
    testWidgets('基本约束功能测试', (WidgetTester tester) async {
      // 初始化
      WindConfig.initialize();
      SmartStyleParser.initialize();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                // 测试最小宽度
                WContainer(
                  className: 'min-w-100 bg-blue-500 p-2',
                  child: Text('最小宽度100', style: TextStyle(color: Colors.white)),
                ),
                
                // 测试最大宽度
                WContainer(
                  className: 'max-w-150 bg-red-500 p-2',
                  child: Text('最大宽度150 这是很长的文本测试', style: TextStyle(color: Colors.white)),
                ),
                
                // 测试组合约束
                WContainer(
                  className: 'min-w-80 max-w-120 min-h-50 bg-green-500 p-2',
                  child: Text('组合约束', style: TextStyle(color: Colors.white)),
                ),
                
                // 测试无约束
                WContainer(
                  className: 'bg-yellow-500 p-2',
                  child: Text('无约束', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      );

      // 验证组件渲染
      expect(find.text('最小宽度100'), findsOneWidget);
      expect(find.text('最大宽度150 这是很长的文本测试'), findsOneWidget);
      expect(find.text('组合约束'), findsOneWidget);
      expect(find.text('无约束'), findsOneWidget);
      
      // 等待渲染完成
      await tester.pumpAndSettle();
      
      // 验证没有异常
      expect(tester.takeException(), isNull);
      
      print('✅ 所有约束功能测试通过！');
    });
  });
}