# Flutter Twind Components Documentation

**Flutter Twind v0.4.2** - Complete Component Documentation 📚

## 📋 Component Overview

Flutter Twind provides **19 core components** covering all aspects of Flutter UI development:

### 🏗️ Layout Components (6)
- **WContainer** - Universal container with styling support
- **WFlex** - Flexible layout container
- **WRow** - Horizontal layout container
- **WColumn** - Vertical layout container
- **WStack** - Stacked layout container
- **WPositioned** - Absolute positioning container

### 🎨 Display Components (6)
- **WText** - Text display with rich styling
- **WIcon** - Icon display with color and size control
- **WImage** - Image display with border radius and size control
- **WAvatar** - User avatar display
- **WCard** - Card layout with preset styling
- **WDivider** - Content separator

### 🎯 Interactive Components (2)
- **WButton** - Button with multiple states and styles
- **WInput** - Input field with placeholder and validation

### 📋 List Components (2)
- **WList** - List container
- **WListTile** - List item component

### 🎪 Other Components (3)
- **WAppBar** - Application bar
- **WBadge** - Badge and indicator
- **WDialog** - Modal dialog

---

## 🏗️ Layout Components

### WContainer
**Universal container component with complete styling system support**

#### Use Cases
- Creating card layouts and containers
- Setting backgrounds, borders, and shadows
- Controlling spacing and positioning
- Building complex layout structures

#### Supported Properties
```dart
WContainer({
  Key? key,
  Widget? child,
  String className = '',
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  Color? color,
  Decoration? decoration,
  double? width,
  double? height,
  AlignmentGeometry? alignment,
})
```

#### Style Classes Support
```dart
// Background and colors
'bg-blue-500'           // Background color
'bg-gradient-to-r'      // Gradient background
'from-blue-500'         // Gradient start color
'to-purple-600'         // Gradient end color

// Spacing
'p-6'                   // Padding
'px-4 py-2'            // Horizontal and vertical padding
'm-4'                   // Margin
'mx-auto'              // Horizontal centering

// Size
'w-full'               // Full width
'h-[200px]'            // Custom height
'w-[300px]'            // Custom width

// Borders and radius
'border'               // Border
'border-2'             // Border width
'border-blue-500'      // Border color
'rounded-lg'           // Border radius
'rounded-full'         // Fully rounded

// Shadows
'shadow-md'            // Medium shadow
'shadow-lg'            // Large shadow
'shadow-xl'            // Extra large shadow

// Opacity
'opacity-50'           // 50% opacity
'bg-black/20'          // Background with opacity
```

#### Example Usage
```dart
// Basic container
WContainer(
  className: 'p-6 m-4 bg-white rounded-lg shadow-md',
  child: Text('Content'),
)

// Gradient container
WContainer(
  className: 'p-8 bg-gradient-to-r from-blue-500 to-purple-600 rounded-xl',
  child: Text('Gradient Background'),
)

// Custom size container
WContainer(
  className: 'w-[300px] h-[200px] bg-gray-100 border-2 border-blue-500 rounded-lg',
  child: Center(child: Text('Custom Size')),
)
```

### WFlex
**Flexible layout container with direction and alignment control**

#### Use Cases
- Creating flexible layouts with dynamic sizing
- Controlling child widget distribution
- Building responsive layouts

#### Supported Properties
```dart
WFlex({
  Key? key,
  required List<Widget> children,
  String className = '',
  Axis direction = Axis.horizontal,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  MainAxisSize mainAxisSize = MainAxisSize.max,
})
```

#### Style Classes Support
```dart
// Direction
'flex-row'             // Horizontal direction
'flex-col'             // Vertical direction

// Main axis alignment
'justify-start'        // Start alignment
'justify-center'       // Center alignment
'justify-end'          // End alignment
'justify-between'      // Space between
'justify-around'       // Space around
'justify-evenly'       // Space evenly

// Cross axis alignment
'items-start'          // Start alignment
'items-center'         // Center alignment
'items-end'            // End alignment
'items-stretch'        // Stretch alignment

// Spacing
'gap-4'                // Gap between children
'gap-6'                // Larger gap
```

### WRow / WColumn
**Horizontal and vertical layout containers**

#### Use Cases
- Simple horizontal or vertical arrangement
- Quick layout without flex complexity
- Building form layouts

#### Example Usage
```dart
// Horizontal layout
WRow(
  className: 'justify-center items-center gap-4 p-4',
  children: [
    WButton(text: 'Button 1'),
    WButton(text: 'Button 2'),
    WButton(text: 'Button 3'),
  ],
)

// Vertical layout
WColumn(
  className: 'items-center gap-6 p-6',
  children: [
    WText('Title', className: 'text-2xl font-bold'),
    WText('Subtitle', className: 'text-gray-600'),
    WButton(text: 'Action Button'),
  ],
)
```

### WStack / WPositioned
**Stacked layout with absolute positioning support**

#### Use Cases
- Overlapping element layouts
- Floating buttons and badges
- Complex layered interfaces

#### Example Usage
```dart
WStack(
  children: [
    WContainer(
      className: 'w-[200px] h-[200px] bg-blue-500 rounded-lg',
    ),
    WPositioned(
      top: 10,
      right: 10,
      child: WBadge(
        text: '5',
        className: 'bg-red-500 text-white',
      ),
    ),
  ],
)
```

---

## 🎨 Display Components

### WText
**Text component with rich styling support**

#### Use Cases
- Displaying titles, body text, and labels
- Creating text with different sizes, colors, and styles
- Text alignment and decoration

#### Supported Properties
```dart
WText(
  String text, {
  Key? key,
  String className = '',
  TextStyle? style,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
})
```

#### Style Classes Support
```dart
// Font sizes
'text-xs'              // 12px
'text-sm'              // 14px
'text-base'            // 16px
'text-lg'              // 18px
'text-xl'              // 20px
'text-2xl'             // 24px
'text-3xl'             // 30px

// Font weights
'font-thin'            // 100
'font-light'           // 300
'font-normal'          // 400
'font-medium'          // 500
'font-semibold'        // 600
'font-bold'            // 700
'font-extrabold'       // 800
'font-black'           // 900

// Colors
'text-red-500'         // Red text
'text-blue-600'        // Blue text
'text-gray-700'        // Gray text
'text-[#ff0000]'       // Custom hex color

// Alignment
'text-left'            // Left align
'text-center'          // Center align
'text-right'           // Right align
'text-justify'         // Justify align

// Decoration
'underline'            // Underline
'line-through'         // Strike through
'no-underline'         // No decoration

// Transform
'uppercase'            // Uppercase
'lowercase'            // Lowercase
'capitalize'           // Capitalize

// Overflow
'overflow-ellipsis'    // Ellipsis overflow
'line-clamp-2'         // Limit to 2 lines
```

#### Example Usage
```dart
// Title text
WText(
  'Main Title',
  className: 'text-3xl font-bold text-gray-900 text-center mb-4',
)

// Body text
WText(
  'This is body text with custom styling.',
  className: 'text-base text-gray-700 leading-relaxed',
)

// Custom color text
WText(
  'Custom Color Text',
  className: 'text-[#ff6b6b] font-semibold text-lg',
)
```

### WIcon
**Icon component with color and size control**

#### Use Cases
- Button icons and decorative elements
- Status indicators
- Navigation icons

#### Supported Properties
```dart
WIcon(
  IconData icon, {
  Key? key,
  String className = '',
  double? size,
  Color? color,
})
```

#### Style Classes Support
```dart
// Colors
'text-red-500'         // Red icon
'text-blue-600'        // Blue icon
'text-gray-400'        // Gray icon

// Sizes (through text size classes)
'text-sm'              // Small icon
'text-lg'              // Large icon
'text-2xl'             // Extra large icon
```

### WImage
**Image component with border radius and size control**

#### Use Cases
- Product images and photos
- Avatar images
- Background images

#### Supported Properties
```dart
WImage(
  String src, {
  Key? key,
  String className = '',
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
})
```

#### Style Classes Support
```dart
// Size
'w-[200px]'            // Custom width
'h-[150px]'            // Custom height
'w-full'               // Full width

// Border radius
'rounded'              // Small radius
'rounded-lg'           // Large radius
'rounded-full'         // Circular

// Borders
'border-2'             // Border width
'border-gray-300'      // Border color
```

### WAvatar
**Avatar component for user profile images**

#### Use Cases
- User profiles and contact lists
- Comment systems
- Team member displays

#### Example Usage
```dart
WAvatar(
  imageUrl: 'https://example.com/avatar.jpg',
  className: 'w-12 h-12 rounded-full border-2 border-gray-300',
)
```

---

## 🎯 Interactive Components

### WButton
**Button component with multiple states and styles**

#### Use Cases
- Form submission and actions
- Navigation buttons
- Call-to-action elements

#### Supported Properties
```dart
WButton({
  Key? key,
  required String text,
  String className = '',
  VoidCallback? onPressed,
  Widget? child,
  bool enabled = true,
})
```

#### Style Classes Support
```dart
// Background colors
'bg-blue-500'          // Blue background
'bg-red-600'           // Red background
'bg-gray-200'          // Gray background

// Text colors
'text-white'           // White text
'text-gray-700'        // Gray text

// Padding
'px-6 py-3'            // Horizontal and vertical padding
'p-4'                  // All-around padding

// Border radius
'rounded'              // Small radius
'rounded-lg'           // Large radius
'rounded-full'         // Pill shape

// Shadows
'shadow-md'            // Medium shadow
'shadow-lg'            // Large shadow

// States (handled automatically)
'hover:bg-blue-600'    // Hover state
'active:bg-blue-700'   // Active state
'disabled:opacity-50'  // Disabled state
```

#### Example Usage
```dart
// Primary button
WButton(
  text: 'Primary Action',
  className: 'bg-blue-500 text-white px-6 py-3 rounded-lg shadow-md',
  onPressed: () => print('Primary button clicked'),
)

// Secondary button
WButton(
  text: 'Secondary Action',
  className: 'bg-gray-200 text-gray-700 px-6 py-3 rounded-lg border',
  onPressed: () => print('Secondary button clicked'),
)

// Danger button
WButton(
  text: 'Delete',
  className: 'bg-red-500 text-white px-4 py-2 rounded font-semibold',
  onPressed: () => print('Delete action'),
)
```

### WInput
**Input field component with placeholder and validation support**

#### Use Cases
- Form input fields
- Search boxes
- User data collection

#### Supported Properties
```dart
WInput({
  Key? key,
  String className = '',
  String? placeholder,
  String? value,
  ValueChanged<String>? onChanged,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
})
```

#### Style Classes Support
```dart
// Borders
'border'               // Default border
'border-2'             // Thick border
'border-gray-300'      // Border color
'border-blue-500'      // Focus border color

// Padding
'p-3'                  // Internal padding
'px-4 py-2'           // Horizontal and vertical padding

// Border radius
'rounded'              // Small radius
'rounded-lg'           // Large radius

// Background
'bg-white'             // White background
'bg-gray-50'           // Light gray background

// Focus states
'focus:border-blue-500' // Focus border color
'focus:ring-2'         // Focus ring
```

#### Example Usage
```dart
// Basic input
WInput(
  placeholder: 'Enter your name',
  className: 'border border-gray-300 rounded-lg p-3 w-full',
  onChanged: (value) => print('Input: $value'),
)

// Styled input
WInput(
  placeholder: 'Search...',
  className: 'border-2 border-blue-200 rounded-full px-4 py-2 bg-blue-50',
  onChanged: (value) => print('Search: $value'),
)
```

---

## 📋 List Components

### WList
**List container for displaying multiple items**

#### Use Cases
- Data lists and menus
- Settings pages
- Navigation lists

#### Supported Properties
```dart
WList({
  Key? key,
  required List<Widget> children,
  String className = '',
  ScrollPhysics? physics,
  bool shrinkWrap = false,
})
```

### WListTile
**Individual list item component**

#### Use Cases
- Menu items and options
- Contact list items
- Settings entries

#### Example Usage
```dart
WList(
  className: 'bg-white rounded-lg shadow-sm',
  children: [
    WListTile(
      title: WText('Item 1', className: 'font-medium'),
      subtitle: WText('Description 1', className: 'text-gray-600'),
      className: 'p-4 border-b border-gray-100',
    ),
    WListTile(
      title: WText('Item 2', className: 'font-medium'),
      subtitle: WText('Description 2', className: 'text-gray-600'),
      className: 'p-4',
    ),
  ],
)
```

---

## 🎪 Other Components

### WCard
**Card component with preset styling**

#### Use Cases
- Content cards and panels
- Product displays
- Information containers

#### Example Usage
```dart
WCard(
  className: 'p-6 bg-white rounded-xl shadow-lg border border-gray-100',
  child: WColumn(
    className: 'gap-4',
    children: [
      WText('Card Title', className: 'text-xl font-bold'),
      WText('Card content goes here.', className: 'text-gray-600'),
    ],
  ),
)
```

### WDivider
**Divider component for content separation**

#### Use Cases
- Section separators
- Visual content breaks
- List item separators

#### Example Usage
```dart
WDivider(
  className: 'border-gray-200 my-4',
)
```

### WAppBar
**Application bar component**

#### Use Cases
- Page headers and navigation
- Title bars
- Action button containers

#### Example Usage
```dart
WAppBar(
  title: WText('Page Title', className: 'text-xl font-bold text-white'),
  className: 'bg-blue-600 px-4 py-3',
  actions: [
    WButton(
      text: 'Action',
      className: 'text-white',
      onPressed: () => print('Action pressed'),
    ),
  ],
)
```

### WBadge
**Badge component for indicators and counters**

#### Use Cases
- Notification counters
- Status indicators
- Labels and tags

#### Example Usage
```dart
WBadge(
  text: '5',
  className: 'bg-red-500 text-white text-xs px-2 py-1 rounded-full',
)
```

### WDialog
**Modal dialog component**

#### Use Cases
- Confirmation dialogs
- Form modals
- Information popups

#### Example Usage
```dart
WDialog(
  title: WText('Confirm Action', className: 'text-lg font-bold'),
  content: WText('Are you sure you want to proceed?'),
  className: 'bg-white rounded-lg p-6 shadow-xl',
  actions: [
    WButton(
      text: 'Cancel',
      className: 'bg-gray-200 text-gray-700 px-4 py-2 rounded',
      onPressed: () => Navigator.pop(context),
    ),
    WButton(
      text: 'Confirm',
      className: 'bg-blue-500 text-white px-4 py-2 rounded ml-2',
      onPressed: () => print('Confirmed'),
    ),
  ],
)
```

---

## 🎯 Best Practices

### Component Selection Guide

#### When to use WContainer
- Need full styling control
- Building custom layouts
- Creating card-like structures
- Applying backgrounds and borders

#### When to use WFlex/WRow/WColumn
- Simple linear layouts
- Need alignment control
- Building responsive layouts
- Distributing space between children

#### When to use WText
- Any text display needs
- Need rich text styling
- Custom fonts and colors
- Text alignment and decoration

#### When to use WButton
- User interactions and actions
- Form submissions
- Navigation triggers
- Call-to-action elements

### Style Naming Conventions

#### Consistent Naming
```dart
// Good: Consistent and clear
'bg-blue-500 text-white p-4 rounded-lg'

// Avoid: Inconsistent spacing
'bg-blue-500  text-white p-4   rounded-lg'
```

#### Logical Grouping
```dart
// Good: Grouped by category
'bg-blue-500 text-white'     // Colors
'p-4 m-2'                    // Spacing
'rounded-lg shadow-md'       // Appearance

// Good: Complete styling
'bg-blue-500 text-white px-6 py-3 rounded-lg shadow-md font-semibold'
```

### Performance Considerations

#### Efficient Styling
- Use consistent class names for better caching
- Avoid overly complex nested layouts
- Prefer built-in components over custom widgets when possible

#### Development Mode
- Debug output helps identify styling issues
- Hot reload works seamlessly with style changes
- Cache is disabled in development for real-time updates

---

## 📖 Complete Integration Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_twind/flutter_twind.dart';

class CompleteExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WAppBar(
        title: WText('Flutter Twind Demo', className: 'text-xl font-bold text-white'),
        className: 'bg-blue-600',
      ),
      body: WContainer(
        className: 'p-6 bg-gray-50',
        child: WColumn(
          className: 'gap-6',
          children: [
            // Header card
            WCard(
              className: 'p-6 bg-white rounded-xl shadow-lg',
              child: WColumn(
                className: 'gap-4 items-center',
                children: [
                  WAvatar(
                    imageUrl: 'https://example.com/avatar.jpg',
                    className: 'w-20 h-20 rounded-full',
                  ),
                  WText(
                    'Welcome Back!',
                    className: 'text-2xl font-bold text-gray-900',
                  ),
                  WText(
                    'Ready to build something amazing?',
                    className: 'text-gray-600 text-center',
                  ),
                ],
              ),
            ),
            
            // Action buttons
            WRow(
              className: 'gap-4 justify-center',
              children: [
                WButton(
                  text: 'Get Started',
                  className: 'bg-blue-500 text-white px-6 py-3 rounded-lg shadow-md font-semibold',
                  onPressed: () => print('Get Started'),
                ),
                WButton(
                  text: 'Learn More',
                  className: 'bg-white text-blue-500 border-2 border-blue-500 px-6 py-3 rounded-lg font-semibold',
                  onPressed: () => print('Learn More'),
                ),
              ],
            ),
            
            // Input section
            WCard(
              className: 'p-6 bg-white rounded-lg shadow-sm',
              child: WColumn(
                className: 'gap-4',
                children: [
                  WText(
                    'Quick Input',
                    className: 'text-lg font-semibold text-gray-900',
                  ),
                  WInput(
                    placeholder: 'Enter something...',
                    className: 'border border-gray-300 rounded-lg p-3 w-full',
                  ),
                  WButton(
                    text: 'Submit',
                    className: 'bg-green-500 text-white px-4 py-2 rounded-lg w-full',
                    onPressed: () => print('Submit'),
                  ),
                ],
              ),
            ),
            
            // List section
            WCard(
              className: 'bg-white rounded-lg shadow-sm overflow-hidden',
              child: WColumn(
                children: [
                  WContainer(
                    className: 'p-4 bg-gray-50 border-b border-gray-200',
                    child: WText(
                      'Recent Items',
                      className: 'font-semibold text-gray-900',
                    ),
                  ),
                  WList(
                    children: [
                      WListTile(
                        title: WText('Item 1', className: 'font-medium'),
                        subtitle: WText('Description for item 1', className: 'text-gray-600'),
                        className: 'p-4 border-b border-gray-100',
                      ),
                      WListTile(
                        title: WText('Item 2', className: 'font-medium'),
                        subtitle: WText('Description for item 2', className: 'text-gray-600'),
                        className: 'p-4 border-b border-gray-100',
                      ),
                      WListTile(
                        title: WText('Item 3', className: 'font-medium'),
                        subtitle: WText('Description for item 3', className: 'text-gray-600'),
                        className: 'p-4',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

**Flutter Twind v0.4.2** - Complete component documentation for building beautiful Flutter apps! 🚀