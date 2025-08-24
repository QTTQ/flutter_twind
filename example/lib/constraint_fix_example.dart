import 'package:flutter/material.dart';
import 'package:flutter_twind/flutter_twind.dart';

/// 展示修复后的约束处理示例
class ConstraintFixExample extends StatelessWidget {
  const ConstraintFixExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('约束修复示例'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '修复后的 WStack 组件',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 安全的 WStack 使用示例
            WContainer(
              className: 'p-4 bg-gray-100 rounded-lg',
              height: 200,
              child: WStack(
                className: 'bg-white rounded-lg shadow-md',
                children: [
                  // 背景图片
                  WImage(
                    image: const NetworkImage('https://picsum.photos/300/200'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  // 覆盖层文本
                  WPositioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: WContainer(
                      className: 'p-3 bg-black bg-opacity-50 rounded-lg',
                      child: const Text(
                        '安全的 Stack 布局',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            const Text(
              '修复后的 WContainer 组件',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 安全的 WContainer 使用示例
            WContainer(
              className: 'p-6 bg-blue-50 rounded-xl shadow-lg',
              constraints: const BoxConstraints(
                minHeight: 100,
                maxHeight: 300,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 48),
                  const SizedBox(height: 12),
                  const Text(
                    '约束问题已修复',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '现在可以安全地使用 WContainer 和 WStack 组件，不会出现无限高度约束错误。',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            const Text(
              '修复后的 WImage 组件',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 安全的 WImage 在 Stack 中的使用
            SizedBox(
              height: 150,
              child: WStack(
                children: [
                  WImage(
                    image: const NetworkImage('https://picsum.photos/400/150'),
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  WPositioned(
                    top: 12,
                    right: 12,
                    child: WContainer(
                      className: 'p-2 bg-white rounded-full shadow-md',
                      child: const Icon(Icons.favorite, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 最佳实践提示
            WContainer(
              className: 'p-4 bg-yellow-50 border border-yellow-200 rounded-lg',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        '最佳实践',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('1. 在使用 WStack 时，为容器指定明确的高度'),
                  const Text('2. 在 Stack 中使用 WImage 时，确保有合适的尺寸约束'),
                  const Text('3. 避免在无限高度的容器中嵌套 Stack 组件'),
                  const Text('4. 使用 LayoutBuilder 来动态处理约束问题'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}