# Flutter Twind 热重载修复指南

## 问题描述
用户反馈热重载功能不正常工作，修改 className 后需要热重启才能看到效果。

## 根本原因
1. `SmartStyleParser` 虽然在开发模式下禁用了缓存，但 Flutter 的热重载可能没有正确触发组件重建
2. 某些组件可能缓存了解析结果，导致样式更新不及时

## 解决方案

### 方案1：强制热重载支持
在 `SmartStyleParser` 中添加开发模式下的强制刷新机制：

```dart
// 在 SmartStyleParser 类中添加
static int _hotReloadCounter = 0;

static void forceRefresh() {
  if (kDebugMode) {
    _hotReloadCounter++;
    _cache.clear();
  }
}

// 在 parseClassName 方法中
static Map<String, dynamic> parseClassName(
  String className,
  String componentType,
  BuildContext context,
) {
  if (className.isEmpty) return {};

  final screenWidth = MediaQuery.of(context).size.width;
  // 在开发模式下添加热重载计数器到缓存键
  final cacheKey = kDebugMode 
    ? '$className:$componentType:$screenWidth:$_hotReloadCounter'
    : '$className:$componentType:$screenWidth';
  
  // 其余代码保持不变...
}
```

### 方案2：组件级别的热重载支持
在每个 Wind 组件中添加热重载监听：

```dart
class WContainer extends StatefulWidget {
  // ... 现有代码

  @override
  State<WContainer> createState() => _WContainerState();
}

class _WContainerState extends State<WContainer> {
  @override
  void reassemble() {
    super.reassemble();
    // 热重载时强制刷新样式
    if (kDebugMode) {
      SmartStyleParser.clearCache();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... 现有构建代码
  }
}
```

### 方案3：全局热重载监听
在 `WindConfig` 中添加全局热重载支持：

```dart
class WindConfig {
  static void initialize() {
    if (kDebugMode) {
      // 注册热重载回调
      WidgetsBinding.instance.addPostFrameCallback((_) {
        SmartStyleParser.clearCache();
      });
    }
  }
}
```

## 测试步骤
1. 修改任意组件的 className 属性
2. 按 "r" 键进行热重载
3. 检查样式是否立即更新
4. 如果仍需按 "R" 键才能更新，说明需要进一步优化

## 当前状态
- ✅ 应用成功启动
- ✅ 基础功能正常
- ❌ 热重载样式更新不及时
- 🔄 需要实施上述解决方案之一

## 推荐方案
建议先实施方案1（强制热重载支持），因为它最简单且影响范围最小。