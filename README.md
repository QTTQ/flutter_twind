# Flutter Twind

[![pub package](https://img.shields.io/pub/v/flutter_twind.svg)](https://pub.dev/packages/flutter_twind)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Flutter Twind is a Flutter UI component library inspired by Tailwind CSS, providing a utility-first styling system and rich pre-built components.

## 🚀 Features

- **🎨 Tailwind CSS-style Styling System** - Familiar className syntax
- **📱 Responsive Design** - Breakpoint and adaptive layout support
- **🎯 Type Safe** - Complete TypeScript-style type support
- **⚡ Hot Reload Friendly** - Real-time style updates in development mode
- **🎪 Rich Components** - 19+ pre-built components
- **🎨 Custom Themes** - Support for custom color systems
- **📦 Lightweight** - Zero external dependencies

## 📦 Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_twind: ^0.4.2
```

Then run:

```bash
flutter pub get
```

## 🏁 Quick Start

### 1. Initialize

```dart
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  // Initialize WindConfig
  WindConfig.initialize();
  
  runApp(MyApp());
}
```

### 2. Use Components

```dart
import 'package:flutter_twind/flutter_twind.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WContainer(
      className: 'p-6 m-4 bg-white rounded-lg shadow-md',
      child: WText(
        'Welcome to Flutter Twind!',
        className: 'text-xl font-bold text-blue-600 text-center',
      ),
    );
  }
}
```

## 📚 Component Library

### 🏗️ Layout Components

#### WContainer
Universal container component with full styling system support.

**Use Cases:**
- Creating card layouts
- Setting backgrounds and borders
- Controlling spacing and shadows

**Supported Style Classes:**
```dart
WContainer(
  className: 'p-6 m-4 bg-white rounded-lg shadow-md border border-gray-200',
  child: child,
)
```

#### WFlex / WRow / WColumn
Flex layout components with direction and alignment control.

**Use Cases:**
- Horizontal or vertical arrangement of child components
- Controlling alignment and spacing
- Responsive layouts

**Supported Style Classes:**
```dart
WRow(
  className: 'justify-center items-center gap-4 p-4',
  children: [child1, child2, child3],
)
```

#### WStack / WPositioned
Stacked layout components with absolute positioning support.

**Use Cases:**
- Overlapping element layouts
- Floating buttons
- Badges and labels

### 🎨 Display Components

#### WText
Text component with rich text styling support.

**Use Cases:**
- Title and body text display
- Different font sizes and colors
- Text alignment and decoration

**Supported Style Classes:**
```dart
WText(
  'Title Text',
  className: 'text-2xl font-bold text-blue-600 text-center underline',
)
```

#### WIcon
Icon component with color and size control.

**Use Cases:**
- Button icons
- Status indicators
- Decorative elements

#### WImage
Image component with border radius and size control.

**Use Cases:**
- Avatar display
- Product images
- Background images

#### WAvatar
Avatar component specifically for user avatar display.

**Use Cases:**
- User profiles
- Comment systems
- Contact lists

### 🎯 Interactive Components

#### WButton
Button component with multiple states and styles.

**Use Cases:**
- Form submission
- Action triggers
- Navigation buttons

**Supported Style Classes:**
```dart
WButton(
  text: 'Click Me',
  className: 'bg-blue-500 text-white px-6 py-3 rounded-lg shadow-md',
  onPressed: () => print('Button clicked'),
)
```

#### WInput
Input field component with placeholder and validation support.

**Use Cases:**
- Form input
- Search boxes
- User information collection

### 📋 List Components

#### WList / WListTile
List components with custom list item support.

**Use Cases:**
- Data lists
- Menu options
- Settings pages

### 🎪 Other Components

#### WCard
Card component with preset card styling.

#### WDivider
Divider component for content separation.

#### WAppBar
App bar component for page title bars.

#### WBadge
Badge component for quantity indicators.

#### WDialog
Dialog component for modal popups.

## 🎨 Styling System

### Color System

#### Basic Colors
```dart
// Basic colors
'bg-red-500'     // Red background
'text-blue-600'  // Blue text
'border-green-300' // Green border

// Opacity support
'bg-black/50'    // 50% opacity black
'text-red-500/80' // 80% opacity red
```

#### Custom Colors
```dart
// Hexadecimal colors
'bg-[#ff0000]'   // Red background
'text-[#333333]' // Dark gray text

// RGB colors
'bg-[rgb(255,0,0)]'     // RGB red
'bg-[rgba(255,0,0,0.5)]' // RGB with opacity

// HSL colors
'bg-[hsl(0,100%,50%)]'     // HSL red
'bg-[hsla(0,100%,50%,0.5)]' // HSL with opacity
```

### Spacing System

```dart
// Padding
'p-4'    // 16px padding all sides
'px-6'   // 24px horizontal padding
'py-2'   // 8px vertical padding
'pt-8'   // 32px top padding

// Margin
'm-4'    // 16px margin all sides
'mx-auto' // Horizontal center
'my-6'   // 24px vertical margin

// Arbitrary values
'p-[20px]'  // 20px padding
'm-[1.5rem]' // 1.5rem margin
```

### Size System

```dart
// Width and height
'w-full'     // 100% width
'h-screen'   // Screen height
'w-[200px]'  // 200px width
'h-[10rem]'  // 10rem height
```

### Typography System

```dart
// Font sizes
'text-xs'    // 12px
'text-sm'    // 14px
'text-base'  // 16px
'text-lg'    // 18px
'text-xl'    // 20px
'text-2xl'   // 24px

// Font weights
'font-thin'      // 100
'font-light'     // 300
'font-normal'    // 400
'font-medium'    // 500
'font-semibold'  // 600
'font-bold'      // 700
'font-extrabold' // 800
'font-black'     // 900

// Text alignment
'text-left'    // Left align
'text-center'  // Center align
'text-right'   // Right align
'text-justify' // Justify align
```

### Borders and Border Radius

```dart
// Borders
'border'           // 1px border
'border-2'         // 2px border
'border-blue-500'  // Blue border

// Border radius
'rounded'      // 4px radius
'rounded-lg'   // 8px radius
'rounded-xl'   // 12px radius
'rounded-full' // Fully rounded
```

### Shadow System

```dart
'shadow-sm'  // Small shadow
'shadow'     // Default shadow
'shadow-md'  // Medium shadow
'shadow-lg'  // Large shadow
'shadow-xl'  // Extra large shadow
'shadow-2xl' // 2X large shadow
'shadow-none' // No shadow
```

### Layout System

```dart
// Flex layout
'flex'           // Enable flex
'flex-row'       // Horizontal direction
'flex-col'       // Vertical direction

// Alignment
'justify-start'    // Main axis start
'justify-center'   // Main axis center
'justify-end'      // Main axis end
'justify-between'  // Main axis space between
'justify-around'   // Main axis space around
'justify-evenly'   // Main axis space evenly

'items-start'    // Cross axis start
'items-center'   // Cross axis center
'items-end'      // Cross axis end
'items-stretch'  // Cross axis stretch

// Spacing
'gap-4'  // 16px gap
'gap-6'  // 24px gap
```

### Opacity and Decoration

```dart
// Opacity
'opacity-0'   // Fully transparent
'opacity-50'  // 50% opacity
'opacity-100' // Fully opaque

// Text decoration
'underline'      // Underline
'line-through'   // Line through
'no-underline'   // No decoration

// Text transform
'uppercase'   // Uppercase
'lowercase'   // Lowercase
'capitalize'  // Capitalize

// Text overflow
'overflow-hidden'   // Hide overflow
'overflow-ellipsis' // Ellipsis
'line-clamp-2'      // Limit to 2 lines
```

## 📱 Responsive Design

Support for breakpoint prefixes for responsive layouts:

```dart
WContainer(
  className: 'p-4 sm:p-6 md:p-8 lg:p-12 xl:p-16',
  child: WText(
    'Responsive Text',
    className: 'text-sm sm:text-base md:text-lg lg:text-xl xl:text-2xl',
  ),
)
```

**Breakpoint Specifications:**
- `sm:` - 640px and above
- `md:` - 768px and above  
- `lg:` - 1024px and above
- `xl:` - 1280px and above
- `2xl:` - 1536px and above

## 🎨 Custom Themes

### Adding Custom Color Systems

```dart
void main() {
  // Initialize custom colors
  SmartStyleParser.initialize(customColors: {
    'brand': {
      '50': const Color(0xFFF0F9FF),
      '100': const Color(0xFFE0F2FE),
      '200': const Color(0xFFBAE6FD),
      '300': const Color(0xFF7DD3FC),
      '400': const Color(0xFF38BDF8),
      '500': const Color(0xFF0EA5E9),
      '600': const Color(0xFF0284C7),
      '700': const Color(0xFF0369A1),
      '800': const Color(0xFF075985),
      '900': const Color(0xFF0C4A6E),
    },
    'accent': {
      '100': const Color(0xFFFCE7F3),
      '300': const Color(0xFFF9A8D4),
      '500': const Color(0xFFEC4899),
      '700': const Color(0xFFBE185D),
      '900': const Color(0xFF831843),
    },
  });
  
  WindConfig.initialize();
  runApp(MyApp());
}
```

### Using Custom Colors

```dart
WContainer(
  className: 'bg-brand-500 p-6 rounded-lg',
  child: WText(
    'Custom Brand Color',
    className: 'text-white font-bold text-accent-300',
  ),
)
```

## 🔧 Development Mode

In development mode, the styling system will:
- Disable caching to support hot reload
- Output debug information
- Update styles in real-time

```dart
// Debug output in development mode
🔥 DEBUG Mode: Re-parsing styles - bg-blue-500 text-white p-4
```

## 📖 Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  WindConfig.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Twind Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WAppBar(
        title: WText('Flutter Twind', className: 'text-xl font-bold'),
        className: 'bg-blue-600',
      ),
      body: WContainer(
        className: 'p-6 bg-gray-50',
        child: WColumn(
          className: 'gap-6',
          children: [
            // Title card
            WCard(
              className: 'p-6 bg-white rounded-xl shadow-lg',
              child: WColumn(
                className: 'gap-4',
                children: [
                  WText(
                    'Welcome to Flutter Twind',
                    className: 'text-2xl font-bold text-gray-900 text-center',
                  ),
                  WText(
                    'Tailwind CSS-style Flutter component library',
                    className: 'text-gray-600 text-center',
                  ),
                ],
              ),
            ),
            
            // Button group
            WRow(
              className: 'gap-4 justify-center',
              children: [
                WButton(
                  text: 'Primary Button',
                  className: 'bg-blue-500 text-white px-6 py-3 rounded-lg shadow-md',
                  onPressed: () => print('Primary button clicked'),
                ),
                WButton(
                  text: 'Secondary Button',
                  className: 'bg-gray-200 text-gray-700 px-6 py-3 rounded-lg',
                  onPressed: () => print('Secondary button clicked'),
                ),
              ],
            ),
            
            // Input field
            WInput(
              placeholder: 'Enter content...',
              className: 'border border-gray-300 rounded-lg p-3',
            ),
            
            // Gradient background example
            WContainer(
              className: 'p-4 bg-gradient-to-r from-blue-500 to-purple-600 rounded-xl',
              child: WText(
                'Gradient Background Example',
                className: 'text-white text-xl font-bold text-center',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🤝 Contributing

Issues and Pull Requests are welcome!

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🔗 Related Links

- [GitHub Repository](https://github.com/QTTQ/flutter_twind)
- [pub.dev Page](https://pub.dev/packages/flutter_twind)
- [Issue Tracker](https://github.com/QTTQ/flutter_twind/issues)
- [Changelog](CHANGELOG.md)

---

**Flutter Twind v0.4.2** - Making Flutter development simpler and faster! 🚀