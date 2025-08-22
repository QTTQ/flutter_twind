# Flutter Twind 热重载指南

## 🔥 智能热重载功能

Flutter Twind 现在支持智能热重载！在开发时修改样式后按 "r" 键即可立即看到效果，无需完全重启应用。

## 🚀 工作原理

我们的智能解析器 `SmartStyleParser` 会根据当前环境自动调整行为：

- **开发模式** (`kDebugMode = true`)：每次都重新解析样式，支持热重载
- **生产模式** (`kDebugMode = false`)：使用缓存机制，优化性能

## 📝 使用方法

### 1. 初始化

```dart
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  // 只需要初始化WindConfig
  WindConfig.initialize();
  runApp(MyApp());
}
```

### 2. 使用组件

```dart
WContainer(
  className: 'p-4 bg-blue-100 rounded-lg',
  child: WText(
    'Hello World',
    className: 'text-lg font-bold text-blue-600',
  ),
)
```

### 3. 热重载测试

1. 修改 `className` 属性，例如：
   - 将 `bg-blue-100` 改为 `bg-red-100`
   - 将 `text-lg` 改为 `text-2xl`
   - 将 `p-4` 改为 `p-6`

2. 按 **"r"** 键进行热重载

3. 观察样式立即更新！

## 🧪 测试应用

运行测试应用来验证热重载功能：

```bash
flutter run test_hot_reload.dart -d chrome --web-port=8083
```

## ✨ 支持的样式类

### 背景颜色
- `bg-{color}`: bg-white, bg-blue-100, bg-red-500, etc.

### 文字样式
- `text-{size}`: text-xs, text-sm, text-lg, text-xl, text-2xl
- `text-{color}`: text-gray-900, text-blue-600, text-red-500
- `text-{align}`: text-left, text-center, text-right
- `font-{weight}`: font-normal, font-medium, font-bold

### 间距
- `p-{size}`: p-1, p-2, p-4, p-6, p-8 (内边距)
- `m-{size}`: m-1, m-2, m-4, m-6, m-8 (外边距)
- `px-{size}`, `py-{size}`: 水平/垂直内边距
- `mx-{size}`, `my-{size}`: 水平/垂直外边距

### 圆角
- `rounded`: 小圆角
- `rounded-lg`: 大圆角
- `rounded-xl`: 超大圆角
- `rounded-full`: 完全圆形

### 阴影
- `shadow-sm`: 小阴影
- `shadow-md`: 中等阴影
- `shadow-lg`: 大阴影
- `shadow-xl`: 超大阴影

### 布局
- `flex`, `flex-row`, `flex-col`: Flex布局
- `justify-{align}`: justify-start, justify-center, justify-end
- `items-{align}`: items-start, items-center, items-end
- `gap-{size}`: 子元素间距

### 尺寸
- `w-{size}`: 宽度
- `h-{size}`: 高度

### 响应式设计
- `sm:`, `md:`, `lg:`, `xl:`, `2xl:` 前缀

## 🎯 性能优化

- **开发时**：每次重新解析，确保热重载正常工作
- **生产时**：智能缓存，避免重复解析，提升性能
- **响应式**：根据屏幕尺寸自动应用相应样式

## 🔧 高级功能

### 清空缓存（开发时使用）

```dart
SmartStyleParser.clearCache();
```

### 自定义颜色

在 `WindConfig.initialize()` 中可以自定义颜色：

```dart
WindConfig.initialize(); // 使用默认配置
```

## 🐛 故障排除

### 热重载不工作？

1. 确保使用了正确的初始化代码
2. 检查是否在开发模式下运行
3. 尝试手动清空缓存：`SmartStyleParser.clearCache()`

### 样式不生效？

1. 检查类名拼写是否正确
2. 确保颜色名称在配置中存在
3. 查看控制台是否有错误信息

## 📚 更多示例

查看 `example/main.dart` 和 `test_hot_reload.dart` 获取更多使用示例。

---

🎉 现在你可以享受流畅的热重载开发体验了！