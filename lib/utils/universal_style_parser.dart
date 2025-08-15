import 'package:flutter/material.dart';

class UniversalStyleParser {
  // 通用解析逻辑
  static Map<String, dynamic> parseClassName(
    String className, 
    String componentType, 
    BuildContext context,
    {Map<String, dynamic>? customParser}
  ) {
    // 1. 先执行通用解析（响应式、基础样式、动画等）
    var styles = _parseCommonStyles(className, context);
    
    // 2. 执行组件特定解析
    styles.addAll(_parseComponentSpecificStyles(className, componentType));
    
    // 3. 如果组件提供了自定义解析器，则执行
    if (customParser != null) {
      styles.addAll(customParser);
    }
    
    return styles;
  }
  
  // 通用样式解析（颜色、间距、尺寸等）
  static Map<String, dynamic> _parseCommonStyles(String className, BuildContext context) {
    Map<String, dynamic> styles = {};
    
    if (className.isEmpty) return styles;
    
    List<String> classes = className.split(' ');
    
    // 过滤响应式类名
    List<String> filteredClasses = _filterResponsiveClasses(classes, context);
    
    for (String cls in filteredClasses) {
      cls = cls.trim();
      if (cls.isEmpty) continue;
      
      // 解析颜色
      if (cls.startsWith('bg-')) {
        styles['backgroundColor'] = _parseColor(cls.substring(3));
      } else if (cls.startsWith('text-')) {
        String colorPart = cls.substring(5);
        if (_isColor(colorPart)) {
          styles['color'] = _parseColor(colorPart);
        }
      }
      
      // 解析间距
      else if (cls.startsWith('p-')) {
        double? padding = _parseSpacing(cls.substring(2));
        if (padding != null) {
          styles['padding'] = EdgeInsets.all(padding);
        }
      } else if (cls.startsWith('px-')) {
        double? padding = _parseSpacing(cls.substring(3));
        if (padding != null) {
          styles['paddingHorizontal'] = EdgeInsets.symmetric(horizontal: padding);
        }
      } else if (cls.startsWith('py-')) {
        double? padding = _parseSpacing(cls.substring(3));
        if (padding != null) {
          styles['paddingVertical'] = EdgeInsets.symmetric(vertical: padding);
        }
      } else if (cls.startsWith('m-')) {
        double? margin = _parseSpacing(cls.substring(2));
        if (margin != null) {
          styles['margin'] = EdgeInsets.all(margin);
        }
      }
      
      // 解析尺寸
      else if (cls.startsWith('w-')) {
        double? width = _parseSize(cls.substring(2));
        if (width != null) {
          styles['width'] = width;
        }
      } else if (cls.startsWith('h-')) {
        double? height = _parseSize(cls.substring(2));
        if (height != null) {
          styles['height'] = height;
        }
      }
      
      // 解析圆角
      else if (cls.startsWith('rounded')) {
        if (cls == 'rounded') {
          styles['borderRadius'] = BorderRadius.circular(4.0);
        } else if (cls.startsWith('rounded-')) {
          String radiusPart = cls.substring(8);
          double? radius = _parseSpacing(radiusPart);
          if (radius != null) {
            styles['borderRadius'] = BorderRadius.circular(radius);
          }
        }
      }
      
      // 解析字体大小
      else if (cls.startsWith('text-')) {
        String sizePart = cls.substring(5);
        double? fontSize = _parseFontSize(sizePart);
        if (fontSize != null) {
          styles['fontSize'] = fontSize;
        }
      }
      
      // 解析字体粗细
      else if (cls.startsWith('font-')) {
        FontWeight? fontWeight = _parseFontWeight(cls.substring(5));
        if (fontWeight != null) {
          styles['fontWeight'] = fontWeight;
        }
      }
      
      // 解析对齐方式
      else if (cls == 'text-center') {
        styles['textAlign'] = TextAlign.center;
      } else if (cls == 'text-left') {
        styles['textAlign'] = TextAlign.left;
      } else if (cls == 'text-right') {
        styles['textAlign'] = TextAlign.right;
      }
      
      // 解析阴影
      else if (cls.startsWith('shadow')) {
        styles['boxShadow'] = _parseShadow(cls);
      }
      
      // 解析动画
      else if (cls.startsWith('animate-')) {
        styles.addAll(_parseAnimation(cls));
      }
    }
    
    return styles;
  }
  
  // 组件特定样式解析
  static Map<String, dynamic> _parseComponentSpecificStyles(String className, String componentType) {
    switch (componentType) {
      case 'Container':
        return _parseContainerStyles(className);
      case 'Text':
        return _parseTextStyles(className);
      case 'Button':
        return _parseButtonStyles(className);
      case 'Card':
        return _parseCardStyles(className);
      case 'List':
        return _parseListStyles(className);
      case 'ListTile':
        return _parseListTileStyles(className);
      case 'AppBar':
        return _parseAppBarStyles(className);
      case 'TextField':
        return _parseTextFieldStyles(className);
      case 'Icon':
        return _parseIconStyles(className);
      case 'Image':
        return _parseImageStyles(className);
      case 'Stack':
        return _parseStackStyles(className);
      case 'Positioned':
        return _parsePositionedStyles(className);
      default:
        return {};
    }
  }
  
  // 过滤响应式类名
  static List<String> _filterResponsiveClasses(List<String> classes, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<String> filteredClasses = [];
    
    for (String cls in classes) {
      if (cls.contains(':')) {
        List<String> parts = cls.split(':');
        if (parts.length == 2) {
          String breakpoint = parts[0];
          String actualClass = parts[1];
          
          if (_shouldApplyBreakpoint(breakpoint, screenWidth)) {
            filteredClasses.add(actualClass);
          }
        }
      } else {
        filteredClasses.add(cls);
      }
    }
    
    return filteredClasses;
  }
  
  // 判断是否应用断点
  static bool _shouldApplyBreakpoint(String breakpoint, double screenWidth) {
    switch (breakpoint) {
      case 'sm':
        return screenWidth >= 640;
      case 'md':
        return screenWidth >= 768;
      case 'lg':
        return screenWidth >= 1024;
      case 'xl':
        return screenWidth >= 1280;
      case '2xl':
        return screenWidth >= 1536;
      default:
        return true;
    }
  }
  
  // 解析颜色
  static Color? _parseColor(String colorName) {
    switch (colorName) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'indigo':
        return Colors.indigo;
      case 'gray':
        return Colors.grey;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'transparent':
        return Colors.transparent;
      default:
        return null;
    }
  }
  
  // 判断是否为颜色
  static bool _isColor(String value) {
    List<String> colors = ['red', 'blue', 'green', 'yellow', 'purple', 'pink', 'indigo', 'gray', 'black', 'white', 'transparent'];
    return colors.contains(value);
  }
  
  // 解析间距
  static double? _parseSpacing(String value) {
    switch (value) {
      case '0':
        return 0;
      case '1':
        return 4;
      case '2':
        return 8;
      case '3':
        return 12;
      case '4':
        return 16;
      case '5':
        return 20;
      case '6':
        return 24;
      case '8':
        return 32;
      case '10':
        return 40;
      case '12':
        return 48;
      case '16':
        return 64;
      case '20':
        return 80;
      case '24':
        return 96;
      default:
        return double.tryParse(value);
    }
  }
  
  // 解析尺寸
  static double? _parseSize(String value) {
    if (value == 'full') return double.infinity;
    if (value == 'screen') return double.infinity;
    return _parseSpacing(value);
  }
  
  // 解析字体大小
  static double? _parseFontSize(String value) {
    switch (value) {
      case 'xs':
        return 12;
      case 'sm':
        return 14;
      case 'base':
        return 16;
      case 'lg':
        return 18;
      case 'xl':
        return 20;
      case '2xl':
        return 24;
      case '3xl':
        return 30;
      case '4xl':
        return 36;
      case '5xl':
        return 48;
      case '6xl':
        return 60;
      default:
        return null;
    }
  }
  
  // 解析字体粗细
  static FontWeight? _parseFontWeight(String value) {
    switch (value) {
      case 'thin':
        return FontWeight.w100;
      case 'light':
        return FontWeight.w300;
      case 'normal':
        return FontWeight.w400;
      case 'medium':
        return FontWeight.w500;
      case 'semibold':
        return FontWeight.w600;
      case 'bold':
        return FontWeight.w700;
      case 'extrabold':
        return FontWeight.w800;
      case 'black':
        return FontWeight.w900;
      default:
        return null;
    }
  }
  
  // 解析阴影
  static List<BoxShadow>? _parseShadow(String value) {
    switch (value) {
      case 'shadow':
      case 'shadow-md':
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ];
      case 'shadow-lg':
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ];
      case 'shadow-xl':
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ];
      default:
        return null;
    }
  }
  
  // 解析动画
  static Map<String, dynamic> _parseAnimation(String className) {
    Map<String, dynamic> animationStyles = {};
    
    if (className.startsWith('animate-')) {
      String animationType = className.substring(8);
      switch (animationType) {
        case 'pulse':
          animationStyles['animation'] = 'pulse';
          break;
        case 'bounce':
          animationStyles['animation'] = 'bounce';
          break;
        case 'spin':
          animationStyles['animation'] = 'spin';
          break;
        case 'ping':
          animationStyles['animation'] = 'ping';
          break;
      }
    }
    
    return animationStyles;
  }
  
  // Container 特定样式
  static Map<String, dynamic> _parseContainerStyles(String className) {
    Map<String, dynamic> styles = {};
    List<String> classes = className.split(' ');
    
    for (String cls in classes) {
      if (cls.startsWith('border')) {
        if (cls == 'border') {
          styles['border'] = Border.all(color: Colors.grey, width: 1);
        } else if (cls.startsWith('border-')) {
          String borderPart = cls.substring(7);
          double? width = double.tryParse(borderPart);
          if (width != null) {
            styles['border'] = Border.all(color: Colors.grey, width: width);
          }
        }
      }
    }
    
    return styles;
  }
  
  // Text 特定样式
  static Map<String, dynamic> _parseTextStyles(String className) {
    Map<String, dynamic> styles = {};
    List<String> classes = className.split(' ');
    
    for (String cls in classes) {
      if (cls == 'italic') {
        styles['fontStyle'] = FontStyle.italic;
      } else if (cls == 'underline') {
        styles['decoration'] = TextDecoration.underline;
      } else if (cls == 'line-through') {
        styles['decoration'] = TextDecoration.lineThrough;
      }
    }
    
    return styles;
  }
  
  // Button 特定样式
  static Map<String, dynamic> _parseButtonStyles(String className) {
    Map<String, dynamic> styles = {};
    List<String> classes = className.split(' ');
    
    for (String cls in classes) {
      if (cls == 'btn-primary') {
        styles['backgroundColor'] = Colors.blue;
        styles['foregroundColor'] = Colors.white;
      } else if (cls == 'btn-secondary') {
        styles['backgroundColor'] = Colors.grey;
        styles['foregroundColor'] = Colors.white;
      }
    }
    
    return styles;
  }
  
  // Card 特定样式
  static Map<String, dynamic> _parseCardStyles(String className) {
    Map<String, dynamic> styles = {};
    List<String> classes = className.split(' ');
    
    for (String cls in classes) {
      if (cls.startsWith('elevation-')) {
        double? elevation = double.tryParse(cls.substring(10));
        if (elevation != null) {
          styles['elevation'] = elevation;
        }
      }
    }
    
    return styles;
  }
  
  // List 特定样式
  static Map<String, dynamic> _parseListStyles(String className) {
    Map<String, dynamic> styles = {};
    List<String> classes = className.split(' ');
    
    for (String cls in classes) {
      if (cls == 'list-horizontal') {
        styles['scrollDirection'] = Axis.horizontal;
      } else if (cls == 'list-vertical') {
        styles['scrollDirection'] = Axis.vertical;
      }
    }
    
    return styles;
  }
  
  // ListTile 特定样式
  static Map<String, dynamic> _parseListTileStyles(String className) {
    Map<String, dynamic> styles = {};
    List<String> classes = className.split(' ');
    
    for (String cls in classes) {
      if (cls == 'dense') {
        styles['dense'] = true;
      }
    }
    
    return styles;
  }
  
  // AppBar 特定样式
  static Map<String, dynamic> _parseAppBarStyles(String className) {
    Map<String, dynamic> styles = {};
    List<String> classes = className.split(' ');
    
    for (String cls in classes) {
      if (cls == 'center-title') {
        styles['centerTitle'] = true;
      }
    }
    
    return styles;
  }
  
  // TextField 特定样式
  static Map<String, dynamic> _parseTextFieldStyles(String className) {
    Map<String, dynamic> styles = {};
    List<String> classes = className.split(' ');
    
    for (String cls in classes) {
      if (cls == 'outlined') {
        styles['border'] = const OutlineInputBorder();
      }
    }
    
    return styles;
  }
  
  // Icon 特定样式
  static Map<String, dynamic> _parseIconStyles(String className) {
    Map<String, dynamic> styles = {};
    List<String> classes = className.split(' ');
    
    for (String cls in classes) {
      if (cls.startsWith('icon-')) {
        double? size = _parseSpacing(cls.substring(5));
        if (size != null) {
          styles['size'] = size;
        }
      }
    }
    
    return styles;
  }
  
  // Image 特定样式
  static Map<String, dynamic> _parseImageStyles(String className) {
    Map<String, dynamic> styles = {};
    List<String> classes = className.split(' ');
    
    for (String cls in classes) {
      if (cls == 'object-cover') {
        styles['fit'] = BoxFit.cover;
      } else if (cls == 'object-contain') {
        styles['fit'] = BoxFit.contain;
      } else if (cls == 'object-fill') {
        styles['fit'] = BoxFit.fill;
      }
    }
    
    return styles;
  }
  
  // Stack 特定样式
  static Map<String, dynamic> _parseStackStyles(String className) {
    Map<String, dynamic> styles = {};
    List<String> classes = className.split(' ');
    
    for (String cls in classes) {
      if (cls == 'stack-center') {
        styles['alignment'] = Alignment.center;
      } else if (cls == 'stack-top') {
        styles['alignment'] = Alignment.topCenter;
      } else if (cls == 'stack-bottom') {
        styles['alignment'] = Alignment.bottomCenter;
      }
    }
    
    return styles;
  }
  
  // Positioned 特定样式
  static Map<String, dynamic> _parsePositionedStyles(String className) {
    Map<String, dynamic> styles = {};
    List<String> classes = className.split(' ');
    
    for (String cls in classes) {
      if (cls.startsWith('top-')) {
        double? top = _parseSpacing(cls.substring(4));
        if (top != null) {
          styles['top'] = top;
        }
      } else if (cls.startsWith('bottom-')) {
        double? bottom = _parseSpacing(cls.substring(7));
        if (bottom != null) {
          styles['bottom'] = bottom;
        }
      } else if (cls.startsWith('left-')) {
        double? left = _parseSpacing(cls.substring(5));
        if (left != null) {
          styles['left'] = left;
        }
      } else if (cls.startsWith('right-')) {
        double? right = _parseSpacing(cls.substring(6));
        if (right != null) {
          styles['right'] = right;
        }
      }
    }
    
    return styles;
  }
}