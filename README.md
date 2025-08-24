# Flutter Twind

A powerful Flutter package that brings **TailwindCSS-style utility classes** to Flutter development, enabling rapid UI development with familiar CSS-like syntax and **full arbitrary value support**.

## 🚀 Features

- 🎨 **Complete TailwindCSS-style Classes**: Use familiar utility classes like `bg-blue-500`, `text-center`, `p-4`
- 🔧 **Arbitrary Value Support**: Use custom values with `bg-[#ff0000]`, `w-[200px]`, `p-[1rem]`
- 🎯 **Extended Color Palette**: 10+ color series with 9 shades each (purple, yellow, orange, pink, etc.)
- 📐 **Gap Spacing**: Modern layout with `gap-4`, `gap-[30px]` for WColumn and WRow
- 🔥 **Hot Reload Support**: Instant style updates during development
- 🧩 **Rich Component Library**: Pre-built components with TailwindCSS styling
- 📱 **Responsive Design**: Built-in responsive utilities
- 🎯 **Type Safe**: Full Dart type safety with IntelliSense support
- ⚡ **Performance Optimized**: Efficient style parsing and rendering
- 🎭 **Text Decorations**: Support for underline, line-through, text transform
- 👻 **Opacity Control**: Predefined and arbitrary opacity values

## 🎨 Supported Arbitrary Values

### Colors
```dart
// Hex colors
WContainer(className: 'bg-[#ff6b6b] text-[#ffffff]')

// RGB colors  
WContainer(className: 'bg-[rgb(255,107,107)] border-[rgb(52,152,219)]')

// RGBA with transparency
WContainer(className: 'bg-[rgba(255,107,107,0.5)]')

// HSL colors
WContainer(className: 'bg-[hsl(348,100%,61%)]')

// HSLA with transparency
WContainer(className: 'bg-[hsla(348,100%,61%,0.6)]')
```

### Sizes & Spacing
```dart
// Pixel values
WContainer(className: 'w-[200px] h-[100px] p-[15px] m-[20px]')

// Rem values
WContainer(className: 'w-[10rem] p-[1.5rem]')

// Em values  
WContainer(className: 'w-[8em] p-[2em]')

// Gap spacing
WColumn(className: 'gap-[30px]', children: [...])
WRow(className: 'gap-[2rem]', children: [...])
```

### Opacity
```dart
// Predefined opacity
WContainer(className: 'opacity-50 bg-blue-500')

// Arbitrary opacity
WContainer(className: 'opacity-[0.6] bg-red-500')
```

## 🎯 Extended Color Palette

Flutter Twind now supports **16 complete color series**, including custom color schemes:

### Standard Color Series
- **Primary**: `primary-50` to `primary-900`
- **Blue**: `blue-50` to `blue-900`  
- **Red**: `red-50` to `red-900`
- **Green**: `green-50` to `green-900`
- **Purple**: `purple-50` to `purple-900` ✨
- **Yellow**: `yellow-50` to `yellow-900` ✨
- **Orange**: `orange-50` to `orange-900` ✨
- **Pink**: `pink-50` to `pink-900` ✨
- **Indigo**: `indigo-50` to `indigo-900` ✨
- **Teal**: `teal-50` to `teal-900` ✨
- **Cyan**: `cyan-50` to `cyan-900` ✨
- **Lime**: `lime-50` to `lime-900` ✨
- **Rose**: `rose-50` to `rose-900` ✨
- **Emerald**: `emerald-50` to `emerald-900` ✨
- **Gray**: `gray-50` to `gray-900`

### Custom Color Schemes ✨ NEW
- **Brand**: `brand-50` to `brand-900` - Custom brand colors
- **Accent**: `accent-50` to `accent-900` - Custom accent colors

```dart
// Using custom brand colors
WContainer(className: 'bg-brand-500 text-white')
WContainer(className: 'bg-brand-100 border-brand-300')

// Using custom accent colors
WContainer(className: 'bg-accent-600 text-white')
WContainer(className: 'bg-accent-50 text-accent-800')

// With transparency modifiers
WContainer(className: 'bg-brand-500/20 border-accent-400/50')
```

![Custom Color Schemes Demo](https://github.com/user-attachments/assets/custom-colors-demo.png)
*Custom brand and accent color schemes with transparency support*

## 📦 Quick Start

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_twind: ^0.3.6
```

### Basic Usage

```dart
import 'package:flutter_twind/flutter_twind.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: WContainer(
          className: 'flex-1 justify-center items-center bg-gray-100',
          child: WCard(
            className: 'p-6 m-4 bg-white rounded-lg shadow-lg border-2 border-[#e3e3e3]',
            child: WColumn(
              className: 'gap-4',
              children: [
                WText(
                  'Hello Flutter Twind!',
                  className: 'text-2xl font-bold text-[#2563eb] mb-2 underline',
                ),
                WContainer(
                  className: 'w-[300px] h-[50px] bg-purple-500 rounded-lg opacity-90',
                  child: WText(
                    'Arbitrary Values Support!',
                    className: 'text-white text-center font-semibold',
                  ),
                ),
                WButton(
                  'Get Started',
                  className: 'bg-[#10b981] text-white px-[24px] py-[12px] rounded-lg hover:opacity-80',
                  onPressed: () => print('Button pressed!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

### Advanced Usage with Gap Spacing

```dart
WColumn(
  className: 'gap-[20px] p-[1.5rem]',
  children: [
    WContainer(className: 'w-[200px] h-[80px] bg-[#ff6b6b] rounded-lg'),
    WContainer(className: 'w-[200px] h-[80px] bg-[rgb(78,205,196)] rounded-lg'),
    WContainer(className: 'w-[200px] h-[80px] bg-[hsl(258,89%,66%)] rounded-lg'),
  ],
)
```

## 🧩 Available Components

### Layout Components
- **WContainer**: Flexible container with TailwindCSS styling
- **WRow**: Horizontal layout with gap support
- **WColumn**: Vertical layout with gap support
- **WStack**: Stack layout for overlapping widgets

### Text Components
- **WText**: Styled text with full typography support

### Interactive Components
- **WButton**: Customizable button with hover effects
- **WInput**: Styled input field

### Display Components
- **WIcon**: Icon with styling support
- **WAvatar**: User avatar component
- **WBadge**: Notification badge
- **WCard**: Card container with shadow and border

### List Components
- **WList**: Styled list container
- **WListTile**: List item with leading, title, and trailing
- **WDivider**: Visual separator

### Navigation Components
- **WAppBar**: Application bar with styling

## 🎨 Styling System

### Colors
```dart
// Predefined colors
WContainer(className: 'bg-blue-500 text-white')
WContainer(className: 'bg-purple-200 text-purple-800')

// Arbitrary colors
WContainer(className: 'bg-[#ff6b6b] text-[#ffffff]')
WContainer(className: 'bg-[rgb(255,107,107)] border-[hsl(0,100%,50%)]')
```

### Spacing
```dart
// Predefined spacing
WContainer(className: 'p-4 m-2 gap-6')

// Arbitrary spacing
WContainer(className: 'p-[15px] m-[1.5rem] gap-[30px]')
```

### Sizing
```dart
// Predefined sizes
WContainer(className: 'w-full h-32')

// Arbitrary sizes
WContainer(className: 'w-[200px] h-[100px]')
```

### Typography
```dart
// Text styling
WText('Hello', className: 'text-2xl font-bold text-center')
WText('World', className: 'text-[#ff0000] underline uppercase')
```

### Borders & Effects
```dart
// Borders
WContainer(className: 'border-2 border-blue-500 rounded-lg')
WContainer(className: 'border-[#ff0000] border-4 rounded-[10px]')

// Shadows & Opacity
WContainer(className: 'shadow-lg opacity-75')
WContainer(className: 'shadow-xl opacity-[0.6]')
```

## 🔥 Hot Reload Support

Flutter Twind supports hot reload for instant style updates:

1. Modify any `className` property
2. Press `r` in your terminal or IDE
3. See changes instantly without full restart

```dart
// Change this:
WContainer(className: 'bg-blue-500 p-4')

// To this:
WContainer(className: 'bg-[#ff6b6b] p-[20px]')

// Press 'r' and see instant changes!
```

## 📚 Examples

### Card Layout
```dart
WCard(
  className: 'p-6 bg-white rounded-xl shadow-lg border border-gray-200',
  child: WColumn(
    className: 'gap-4',
    children: [
      WText('Card Title', className: 'text-xl font-bold text-gray-800'),
      WText('Card content goes here...', className: 'text-gray-600'),
      WButton(
        'Action',
        className: 'bg-blue-500 text-white px-4 py-2 rounded-lg self-start',
        onPressed: () {},
      ),
    ],
  ),
)
```

### Form Layout
```dart
WColumn(
  className: 'gap-4 p-6',
  children: [
    WInput(
      placeholder: 'Enter your name',
      className: 'border border-gray-300 rounded-lg p-3',
    ),
    WInput(
      placeholder: 'Enter your email',
      className: 'border border-gray-300 rounded-lg p-3',
    ),
    WButton(
      'Submit',
      className: 'bg-green-500 text-white py-3 rounded-lg font-semibold',
      onPressed: () {},
    ),
  ],
)
```

### Grid Layout
```dart
WRow(
  className: 'gap-4 flex-wrap',
  children: [
    WContainer(
      className: 'w-[150px] h-[100px] bg-red-500 rounded-lg',
    ),
    WContainer(
      className: 'w-[150px] h-[100px] bg-green-500 rounded-lg',
    ),
    WContainer(
      className: 'w-[150px] h-[100px] bg-blue-500 rounded-lg',
    ),
  ],
)
```

## 🛠️ Development

### Running the Example

```bash
cd example
flutter run -d chrome
```

### Testing

```bash
flutter test
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed list of changes and updates.

---

**Flutter Twind** - Bringing the power of TailwindCSS to Flutter development! 🚀