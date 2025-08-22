# Flutter TailwindCSS-like Components / Flutter TailwindCSS 风格组件

**Language / 语言选择:**
- [English](#english-version)
- [中文版本](#中文版本)

---

## English Version

A Flutter package that provides TailwindCSS-like utility components for rapid UI development.

[![pub package](https://img.shields.io/pub/v/flutter_twind.svg)](https://pub.dev/packages/flutter_twind)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

### Features

- 🎨 **TailwindCSS-like Styling**: Familiar utility classes for rapid development
- 🧩 **Rich Components**: Pre-built components with consistent styling
- 🎯 **Type Safety**: Full Dart type safety with IntelliSense support
- 📱 **Responsive Design**: Built-in responsive design utilities
- 🔧 **Customizable**: Easy theme customization and extension
- ⚡ **Performance**: Optimized for Flutter's rendering engine

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_twind: ^0.3.3
```

Then run:

```bash
flutter pub get
```

### Quick Start

#### 1. Initialize WindConfig

```dart
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  // Initialize WindConfig before runApp
  WindConfig.initialize();
  runApp(MyApp());
}
```

#### 2. Basic Usage

```dart
import 'package:flutter_twind/flutter_twind.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WAppBar(
        title: WText('Flutter TailwindCSS'),
        className: 'bg-blue-600',
      ),
      body: WContainer(
        className: 'p-4 bg-gray-50',
        child: WColumn(
          children: [
            WCard(
              className: 'p-6 mb-4 bg-white rounded-lg shadow-md',
              child: WColumn(
                children: [
                  WText(
                    'Welcome to Flutter TailwindCSS',
                    className: 'text-xl font-bold text-gray-900 mb-2',
                  ),
                  WText(
                    'Build beautiful UIs with utility-first components',
                    className: 'text-gray-600',
                  ),
                ],
              ),
            ),
            WButton(
              text: 'Get Started',
              className: 'bg-blue-500 hover:bg-blue-600 text-white px-6 py-3 rounded-lg',
              onPressed: () => print('Button pressed'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Available Components

#### Layout Components

- **WContainer**: Container with styling support
- **WFlex**: Flexible layout component
- **WRow/WColumn**: Row and column layouts
- **WStack**: Stack layout for overlapping widgets
- **WPositioned**: Positioned widget for precise placement

#### Visual Components

- **WCard**: Card component with shadow and rounded corners
- **WText**: Text component with rich styling
- **WIcon**: Icon component with Material Design icons
- **WImage**: Image component with various display effects
- **WAvatar**: Circular avatar component
- **WDivider**: Divider component for content separation

#### Interactive Components

- **WButton**: Button component with multiple sizes and states
- **WInput**: Input field component with various types

#### List Components

- **WList**: Scrollable list component
- **WListTile**: Standard list item layout

#### Utility Components

- **WAppBar**: Application bar component
- **WBadge**: Badge component for notifications
- **WDialog**: Modal dialog component

### Utility Classes

#### Color Classes
```dart
// Background colors
'bg-white', 'bg-gray-100', 'bg-blue-500', 'bg-red-500'

// Text colors
'text-gray-900', 'text-blue-600', 'text-red-500'
```

#### Spacing Classes
```dart
// Padding
'p-1', 'p-2', 'p-4', 'p-6', 'p-8'
'px-4', 'py-2'  // Horizontal/vertical spacing

// Margin
'm-1', 'm-2', 'm-4', 'm-6', 'm-8'
'mx-4', 'my-2'  // Horizontal/vertical spacing
```

#### Size Classes
```dart
// Width
'w-full', 'w-1/2', 'w-32', 'w-64'

// Height
'h-full', 'h-32', 'h-64', 'h-screen'

// Font size
'text-xs', 'text-sm', 'text-base', 'text-lg', 'text-xl'
```

### Advanced Usage

#### Custom Theme Configuration

```dart
// Configure custom colors and styles
WindConfig.configure(
  colors: {
    'primary': Color(0xFF3B82F6),
    'secondary': Color(0xFF10B981),
  },
  spacing: {
    'xs': 4.0,
    'sm': 8.0,
    'md': 16.0,
    'lg': 24.0,
  },
);
```

#### Responsive Design

```dart
WContainer(
  className: 'p-2 md:p-4 lg:p-6',  // Different spacing for screen sizes
  child: WText(
    'Responsive text',
    className: 'text-sm md:text-base lg:text-lg',
  ),
)
```

### Contributing

We welcome all forms of contributions! Please read our [Contributing Guide](CONTRIBUTING.md) to learn how to participate in project development.

#### Development Setup

1. Fork this repository
2. Clone to local:
   ```bash
   git clone https://github.com/your-username/flutter_twind.git
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run tests:
   ```bash
   flutter test
   ```

### License

This project is licensed under the [MIT License](LICENSE).

### Contact

- 📧 Email: qttq369@gmail.com

---

## 中文版本

一个为 Flutter 提供类似 TailwindCSS 实用工具组件的包，用于快速 UI 开发。

[![pub package](https://img.shields.io/pub/v/flutter_twind.svg)](https://pub.dev/packages/flutter_twind)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

### 特性

- 🎨 **类 Tailwind CSS 样式系统** - 通过 className 属性快速应用样式
- 🧩 **丰富的组件库** - 包含布局、视觉、交互等各类组件
- 📱 **响应式设计** - 支持不同屏幕尺寸的自适应布局
- 🚀 **高性能** - 优化的样式解析器和渲染性能
- 🔧 **易于使用** - 简洁的 API 设计，快速上手
- 🎯 **类型安全** - 完整的 Dart 类型支持

## 📦 安装

在您的 `pubspec.yaml` 文件中添加依赖：

```yaml
dependencies:
  flutter_twind: ^0.3.3
```

然后运行：

```bash
flutter pub get
```

## 🚀 快速开始

### 1. 导入库

```dart
import 'package:flutter_twind/flutter_twind.dart';
```

### 2. 基础使用

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: WAppBar(
          title: WText('Flutter TWind Demo'),
          className: 'bg-blue-600',
        ),
        body: WContainer(
          className: 'p-4 bg-gray-50',
          child: WColumn(
            children: [
              WCard(
                className: 'mb-4 p-6',
                child: WColumn(
                  children: [
                    WText(
                      '欢迎使用 Flutter TWind',
                      className: 'text-xl font-bold text-gray-900 mb-2',
                    ),
                    WText(
                      '一个现代化的 Flutter UI 组件库',
                      className: 'text-gray-600 mb-4',
                    ),
                    WButton(
                      text: '开始使用',
                      className: 'bg-blue-500 hover:bg-blue-600',
                      onPressed: () => print('按钮被点击'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 3. 样式系统

Flutter TWind 使用类似 Tailwind CSS 的样式类名：

```dart
// 间距
WContainer(className: 'p-4 m-2')  // padding: 16px, margin: 8px

// 颜色
WText('Hello', className: 'text-blue-500 bg-white')

// 尺寸
WContainer(className: 'w-full h-32')  // width: 100%, height: 128px

// 圆角和阴影
WCard(className: 'rounded-lg shadow-md')
```

### 颜色类
```dart
// 背景颜色
'bg-white', 'bg-gray-100', 'bg-blue-500', 'bg-red-500'

// 文本颜色
'text-gray-900', 'text-blue-600', 'text-red-500'
```

### 间距类
```dart
// 内边距
'p-1', 'p-2', 'p-4', 'p-6', 'p-8'
'px-4', 'py-2'  // 水平/垂直间距

// 外边距
'm-1', 'm-2', 'm-4', 'm-6', 'm-8'
'mx-4', 'my-2'  // 水平/垂直间距
```

### 尺寸类
```dart
// 宽度
'w-full', 'w-1/2', 'w-32', 'w-64'

// 高度
'h-full', 'h-32', 'h-64', 'h-screen'

// 字体大小
'text-xs', 'text-sm', 'text-base', 'text-lg', 'text-xl'
```

## 🔧 高级用法

### 自定义主题

```dart
// 配置自定义颜色和样式
WindConfig.configure(
  colors: {
    'primary': Color(0xFF3B82F6),
    'secondary': Color(0xFF10B981),
  },
  spacing: {
    'xs': 4.0,
    'sm': 8.0,
    'md': 16.0,
    'lg': 24.0,
  },
);
```

### 响应式设计

```dart
WContainer(
  className: 'p-2 md:p-4 lg:p-6',  // 不同屏幕尺寸的间距
  child: WText(
    '响应式文本',
    className: 'text-sm md:text-base lg:text-lg',
  ),
)
```

## 🤝 贡献指南

我们欢迎所有形式的贡献！请阅读我们的 [贡献指南](CONTRIBUTING.md) 了解如何参与项目开发。

### 开发环境设置

1. Fork 这个仓库
2. 克隆到本地：
   ```bash
   git clone https://github.com/your-username/flutter_twind.git
   ```
3. 安装依赖：
   ```bash
   flutter pub get
   ```
4. 运行测试：
   ```bash
   flutter test
   ```

## 组件分类

### 🏗️ 布局组件

#### WContainer
容器组件，用于包装其他组件并提供样式装饰。

**主要属性：**
- `child`: 子组件
- `className`: 样式类名
- `width/height`: 宽度/高度
- `padding/margin`: 内边距/外边距
- `backgroundColor`: 背景颜色
- `borderRadius`: 圆角
- `boxShadow`: 阴影
- `border`: 边框

**使用示例：**
```dart
WContainer(
  className: "bg-white p-4 rounded-lg shadow-md",
  child: Text("Hello World"),
)
```

#### WFlex
Flex 布局组件，支持水平和垂直方向的弹性布局。

**主要属性：**
- `children`: 子组件列表
- `direction`: 布局方向 (Axis.horizontal/vertical)
- `mainAxisAlignment`: 主轴对齐方式
- `crossAxisAlignment`: 交叉轴对齐方式

**使用示例：**
```dart
WFlex(
  className: "p-4 bg-gray-100",
  direction: Axis.horizontal,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    WText("左侧"),
    WText("右侧"),
  ],
)
```

#### WRow / WColumn
行/列布局组件，分别用于水平和垂直排列子组件。

**使用示例：**
```dart
WRow(
  className: "p-4",
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    WIcon(Icons.star),
    SizedBox(width: 8),
    WText("评分"),
  ],
)
```

#### WStack
堆叠布局组件，允许子组件重叠显示。

**主要属性：**
- `alignment`: 对齐方式
- `fit`: 适应方式
- `clipBehavior`: 裁剪行为

#### WPositioned
定位组件，用于在 Stack 中精确定位子组件。

**主要属性：**
- `left/top/right/bottom`: 定位偏移
- `width/height`: 尺寸

### 🎨 视觉组件

#### WCard
卡片组件，提供阴影和圆角的容器效果。

**主要属性：**
- `child`: 子组件
- `onTap`: 点击回调
- `padding`: 内边距（默认：16px）
- `margin`: 外边距（默认：8px）
- `backgroundColor`: 背景颜色（默认：白色）
- `boxShadow`: 阴影（默认：中等阴影）
- `borderRadius`: 圆角（默认：大圆角）

**使用示例：**
```dart
WCard(
  className: "m-4 p-6",
  onTap: () => print("卡片被点击"),
  child: Column(
    children: [
      WText("卡片标题", className: "text-lg font-bold"),
      WText("卡片内容"),
    ],
  ),
)
```

#### WText
文本组件，支持丰富的文本样式。

**主要属性：**
- `text`: 文本内容
- `style`: 文本样式
- `color`: 文本颜色
- `fontSize`: 字体大小
- `fontWeight`: 字体粗细
- `textAlign`: 文本对齐
- `maxLines`: 最大行数
- `overflow`: 溢出处理

**使用示例：**
```dart
WText(
  "这是一段文本",
  className: "text-blue-600 text-lg font-semibold",
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
```

#### WIcon
图标组件，显示 Material Design 图标。

**主要属性：**
- `icon`: 图标数据
- `size`: 图标大小（默认：24）
- `color`: 图标颜色（默认：gray-700）

**使用示例：**
```dart
WIcon(
  Icons.favorite,
  className: "text-red-500",
  size: 32,
)
```

#### WImage
图片组件，支持各种图片显示效果。

**主要属性：**
- `image`: 图片提供者
- `width/height`: 尺寸
- `fit`: 适应方式
- `borderRadius`: 圆角
- `boxShadow`: 阴影

**使用示例：**
```dart
WImage(
  image: NetworkImage("https://example.com/image.jpg"),
  className: "rounded-lg shadow-md",
  width: 200,
  height: 150,
  fit: BoxFit.cover,
)
```

#### WAvatar
头像组件，显示圆形头像。

**主要属性：**
- `radius`: 半径（默认：20）
- `backgroundColor`: 背景颜色（默认：gray-300）
- `backgroundImage`: 背景图片
- `child`: 子组件（通常是文本或图标）

**使用示例：**
```dart
WAvatar(
  radius: 30,
  backgroundImage: NetworkImage("https://example.com/avatar.jpg"),
)
```

#### WDivider
分割线组件，用于分隔内容。

**主要属性：**
- `height`: 高度
- `thickness`: 厚度（默认：1）
- `color`: 颜色（默认：gray-200）
- `indent/endIndent`: 缩进

### 🔧 交互组件

#### WButton
按钮组件，支持多种尺寸和状态。

**主要属性：**
- `text`: 按钮文本
- `onPressed`: 点击回调
- `size`: 按钮尺寸（small/medium/large）
- `isLoading`: 加载状态
- `isDisabled`: 禁用状态
- `icon`: 图标
- `backgroundColor`: 背景颜色（默认：primary）
- `textColor`: 文本颜色（默认：白色）

**使用示例：**
```dart
WButton(
  text: "提交",
  className: "bg-blue-500 hover:bg-blue-600",
  size: ButtonSize.large,
  icon: Icon(Icons.send),
  onPressed: () => print("按钮被点击"),
)
```

#### WInput
输入框组件，支持各种输入类型。

**主要属性：**
- `placeholder`: 占位符文本
- `controller`: 文本控制器
- `onChanged`: 文本变化回调
- `obscureText`: 密码模式
- `keyboardType`: 键盘类型
- `prefixIcon/suffixIcon`: 前缀/后缀图标
- `errorText`: 错误文本
- `maxLines`: 最大行数

**使用示例：**
```dart
WInput(
  placeholder: "请输入用户名",
  className: "border-gray-300 focus:border-blue-500",
  prefixIcon: Icon(Icons.person),
  controller: _usernameController,
  onChanged: (value) => print("输入：$value"),
)
```

### 📋 列表组件

#### WList
列表组件，支持滚动和分隔符。

**主要属性：**
- `children`: 子组件列表
- `scrollDirection`: 滚动方向
- `shrinkWrap`: 收缩包装
- `physics`: 滚动物理效果
- `separator`: 分隔符组件

**使用示例：**
```dart
WList(
  className: "bg-white rounded-lg",
  separator: WDivider(),
  children: [
    WListTile(title: WText("项目 1")),
    WListTile(title: WText("项目 2")),
    WListTile(title: WText("项目 3")),
  ],
)
```

#### WListTile
列表项组件，标准的列表项布局。

**主要属性：**
- `leading`: 前导组件
- `title`: 标题组件
- `subtitle`: 副标题组件
- `trailing`: 尾随组件
- `onTap`: 点击回调
- `selected`: 选中状态
- `enabled`: 启用状态

**使用示例：**
```dart
WListTile(
  leading: WIcon(Icons.settings),
  title: WText("设置"),
  subtitle: WText("应用程序设置"),
  trailing: WIcon(Icons.arrow_forward_ios),
  onTap: () => Navigator.push(...),
)
```

### 🛠️ 功能组件

#### WAppBar
应用栏组件，提供标准的应用栏布局。

**主要属性：**
- `title`: 标题组件
- `actions`: 操作按钮列表
- `leading`: 前导组件
- `backgroundColor`: 背景颜色（默认：primary）
- `foregroundColor`: 前景颜色（默认：白色）
- `centerTitle`: 标题居中（默认：true）
- `elevation`: 阴影高度

**使用示例：**
```dart
WAppBar(
  title: WText("应用标题"),
  className: "bg-blue-600",
  actions: [
    IconButton(
      icon: WIcon(Icons.search),
      onPressed: () => print("搜索"),
    ),
  ],
)
```

#### WBadge
徽章组件，用于显示通知数量或状态。

**主要属性：**
- `child`: 被装饰的子组件
- `text`: 徽章文本
- `count`: 数量
- `showZero`: 是否显示零
- `backgroundColor`: 背景颜色（默认：red-500）
- `alignment`: 对齐位置
- `offset`: 偏移量

**使用示例：**
```dart
WBadge(
  count: 5,
  child: WIcon(Icons.notifications),
)
```

#### WDialog
对话框组件，用于显示模态对话框。

**主要属性：**
- `child`: 对话框内容
- `title`: 标题
- `actions`: 操作按钮
- `barrierDismissible`: 点击外部关闭
- `width/height`: 尺寸

**使用示例：**
```dart
// 显示对话框
WDialog.show(
  context: context,
  title: "确认删除",
  child: WText("确定要删除这个项目吗？"),
  actions: [
    WButton(
      text: "取消",
      onPressed: () => Navigator.pop(context),
    ),
    WButton(
      text: "删除",
      onPressed: () {
        // 执行删除操作
        Navigator.pop(context);
      },
    ),
  ],
);
```

## 样式系统

### className 属性

所有组件都支持 `className` 属性，用于应用预定义的样式类。样式类遵循类似 Tailwind CSS 的命名规范：

**间距类：**
- `p-4`: padding: 16px
- `m-2`: margin: 8px
- `px-4`: 水平 padding: 16px
- `py-2`: 垂直 padding: 8px

**颜色类：**
- `bg-white`: 白色背景
- `bg-primary`: 主色背景
- `text-gray-900`: 深灰色文本
- `text-blue-500`: 蓝色文本

**尺寸类：**
- `w-full`: 宽度 100%
- `h-32`: 高度 128px
- `text-lg`: 大字体
- `text-sm`: 小字体

**圆角类：**
- `rounded`: 小圆角
- `rounded-lg`: 大圆角
- `rounded-full`: 完全圆角

**阴影类：**
- `shadow-sm`: 小阴影
- `shadow-md`: 中等阴影
- `shadow-lg`: 大阴影

### 组合使用

```dart
WCard(
  className: "bg-white p-6 m-4 rounded-xl shadow-lg border border-gray-200",
  child: WColumn(
    children: [
      WText(
        "卡片标题",
        className: "text-xl font-bold text-gray-900 mb-2",
      ),
      WText(
        "这是卡片的描述内容",
        className: "text-gray-600 text-sm",
      ),
      SizedBox(height: 16),
      WButton(
        text: "了解更多",
        className: "bg-blue-500 hover:bg-blue-600 text-white px-6 py-3 rounded-lg",
        onPressed: () => print("按钮点击"),
      ),
    ],
  ),
)
```

### 提交规范

- 使用清晰的提交信息
- 遵循 [Conventional Commits](https://conventionalcommits.org/) 规范
- 确保所有测试通过
- 添加必要的文档

## 🐛 问题反馈

如果您发现了 bug 或有功能建议，请在 [GitHub Issues](https://github.com/QTTQ/flutter_twind/issues) 中提交。

## 📄 许可证

本项目采用 [MIT 许可证](LICENSE)。

## 🙏 致谢

- 感谢 [Tailwind CSS](https://tailwindcss.com/) 提供的设计灵感
- 感谢 [fluttersdk](https://wind.fluttersdk.com/) 提供的设计灵感
- 感谢 Flutter 团队提供的优秀框架
- 感谢所有贡献者的支持

## 📞 联系我们

- 📧 Email: qttq369@gmail.com

⭐ 如果这个项目对您有帮助，请给我们一个 star！      