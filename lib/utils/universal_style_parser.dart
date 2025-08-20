import 'package:flutter/material.dart';
import 'wind_config.dart';

/// Universal style parser for Wind UI components.
///
/// This class provides comprehensive style parsing capabilities including:
/// - Color parsing (hex, rgb, rgba, hsl, hsla, named colors)
/// - Spacing and sizing
/// - Typography
/// - Responsive design
/// - Component-specific styles
class UniversalStyleParser {
  /// Parse className string and return style properties.
  ///
  /// [className] - Space-separated class names
  /// [componentType] - Type of component for specific parsing
  /// [context] - Build context for responsive design
  /// [customParser] - Optional custom parsing rules
  static Map<String, dynamic> parseClassName(
    String className,
    String componentType,
    BuildContext context, {
    Map<String, dynamic>? customParser,
  }) {
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

  /// Parse common styles (colors, spacing, sizing, etc.)
  static Map<String, dynamic> _parseCommonStyles(
    String className,
    BuildContext context,
  ) {
    Map<String, dynamic> styles = {};

    if (className.isEmpty) return styles;

    List<String> classes = className.split(' ');

    // 过滤响应式类名
    List<String> filteredClasses = _filterResponsiveClasses(classes, context);

    for (String cls in filteredClasses) {
      cls = cls.trim();
      if (cls.isEmpty) continue;

      // 解析背景颜色
      if (cls.startsWith('bg-')) {
        String colorPart = cls.substring(3);
        Color? color = _parseColor(colorPart);
        if (color != null) {
          styles['backgroundColor'] = color;
        }
      }
      // 解析文字颜色
      else if (cls.startsWith('text-')) {
        String colorPart = cls.substring(5);
        Color? color = _parseColor(colorPart);
        if (color != null) {
          styles['color'] = color;
        }
      }
      // 解析边框颜色和宽度
      else if (cls.startsWith('border-') &&
          !cls.startsWith('border-t-') &&
          !cls.startsWith('border-r-') &&
          !cls.startsWith('border-b-') &&
          !cls.startsWith('border-l-')) {
        String borderPart = cls.substring(7);

        // 先尝试解析颜色
        Color? color = _parseColor(borderPart);
        if (color != null) {
          styles['borderColor'] = color;
          // 如果没有设置边框宽度，默认设置为1
          if (!styles.containsKey('borderWidth')) {
            styles['borderWidth'] = 1.0;
          }
        } else {
          // 如果不是颜色，尝试解析边框宽度
          double? width = double.tryParse(borderPart);
          if (width != null) {
            styles['borderWidth'] = width;
          }
        }
      }
      // 解析基础边框
      else if (cls == 'border') {
        styles['borderWidth'] = 1.0;
        if (!styles.containsKey('borderColor')) {
          styles['borderColor'] = Colors.grey;
        }
      }
      // 解析内边距
      else if (cls.startsWith('p-')) {
        double? padding = _parseSpacing(cls.substring(2));
        if (padding != null) {
          styles['padding'] = EdgeInsets.all(padding);
        }
      } else if (cls.startsWith('px-')) {
        double? padding = _parseSpacing(cls.substring(3));
        if (padding != null) {
          styles['paddingHorizontal'] = padding;
        }
      } else if (cls.startsWith('py-')) {
        double? padding = _parseSpacing(cls.substring(3));
        if (padding != null) {
          styles['paddingVertical'] = padding;
        }
      } else if (cls.startsWith('pt-')) {
        double? padding = _parseSpacing(cls.substring(3));
        if (padding != null) {
          styles['paddingTop'] = padding;
        }
      } else if (cls.startsWith('pr-')) {
        double? padding = _parseSpacing(cls.substring(3));
        if (padding != null) {
          styles['paddingRight'] = padding;
        }
      } else if (cls.startsWith('pb-')) {
        double? padding = _parseSpacing(cls.substring(3));
        if (padding != null) {
          styles['paddingBottom'] = padding;
        }
      } else if (cls.startsWith('pl-')) {
        double? padding = _parseSpacing(cls.substring(3));
        if (padding != null) {
          styles['paddingLeft'] = padding;
        }
      }
      // 解析外边距
      else if (cls.startsWith('m-')) {
        double? margin = _parseSpacing(cls.substring(2));
        if (margin != null) {
          styles['margin'] = EdgeInsets.all(margin);
        }
      } else if (cls.startsWith('mx-')) {
        double? margin = _parseSpacing(cls.substring(3));
        if (margin != null) {
          styles['marginHorizontal'] = margin;
        }
      } else if (cls.startsWith('my-')) {
        double? margin = _parseSpacing(cls.substring(3));
        if (margin != null) {
          styles['marginVertical'] = margin;
        }
      } else if (cls.startsWith('mt-')) {
        double? margin = _parseSpacing(cls.substring(3));
        if (margin != null) {
          styles['marginTop'] = margin;
        }
      } else if (cls.startsWith('mr-')) {
        double? margin = _parseSpacing(cls.substring(3));
        if (margin != null) {
          styles['marginRight'] = margin;
        }
      } else if (cls.startsWith('mb-')) {
        double? margin = _parseSpacing(cls.substring(3));
        if (margin != null) {
          styles['marginBottom'] = margin;
        }
      } else if (cls.startsWith('ml-')) {
        double? margin = _parseSpacing(cls.substring(3));
        if (margin != null) {
          styles['marginLeft'] = margin;
        }
      }
      // 解析宽度
      else if (cls.startsWith('w-')) {
        double? width = _parseSize(cls.substring(2));
        if (width != null) {
          styles['width'] = width;
        }
      }
      // 解析高度
      else if (cls.startsWith('h-')) {
        double? height = _parseSize(cls.substring(2));
        if (height != null) {
          styles['height'] = height;
        }
      }
      // 解析字体大小和文字对齐
      else if (cls.startsWith('text-')) {
        String textPart = cls.substring(5);

        // 首先检查是否为对齐样式
        switch (textPart) {
          case 'left':
            styles['textAlign'] = TextAlign.left;
            break;
          case 'center':
            styles['textAlign'] = TextAlign.center;
            break;
          case 'right':
            styles['textAlign'] = TextAlign.right;
            break;
          case 'justify':
            styles['textAlign'] = TextAlign.justify;
            break;
          case 'start':
            styles['textAlign'] = TextAlign.start;
            break;
          case 'end':
            styles['textAlign'] = TextAlign.end;
            break;
          default:
            // 如果不是对齐样式，先尝试解析字体大小
            double? fontSize = _parseFontSize(textPart);
            if (fontSize != null) {
              styles['fontSize'] = fontSize;
            } else {
              // 如果不是字体大小，尝试解析颜色
              Color? color = _parseColor(textPart);
              if (color != null) {
                styles['color'] = color;
              }
            }
        }
      }
      // 解析基础 flex 类名
      else if (cls == 'flex') {
        styles['display'] = 'flex';
      }
      // 解析容器居中对齐
      else if (cls == 'center') {
        styles['alignment'] = Alignment.center;
      }
      // 解析字体粗细
      else if (cls.startsWith('font-')) {
        FontWeight? fontWeight = _parseFontWeight(cls.substring(5));
        if (fontWeight != null) {
          styles['fontWeight'] = fontWeight;
        }
      }
      // 解析圆角
      else if (cls.startsWith('rounded')) {
        if (cls == 'rounded') {
          styles['borderRadius'] = BorderRadius.circular(4);
        } else if (cls.startsWith('rounded-')) {
          String radiusPart = cls.substring(8);
          double? radius = _parseSpacing(radiusPart);
          if (radius != null) {
            styles['borderRadius'] = BorderRadius.circular(radius);
          } else if (radiusPart == 'full') {
            styles['borderRadius'] = BorderRadius.circular(9999);
          }
        }
      }
      // 解析阴影
      else if (cls.startsWith('shadow')) {
        List<BoxShadow>? shadow = _parseShadow(cls);
        if (shadow != null) {
          styles['boxShadow'] = shadow;
        }
      }
      // 解析透明度
      else if (cls.startsWith('opacity-')) {
        double? opacity = double.tryParse(cls.substring(8));
        if (opacity != null) {
          styles['opacity'] = opacity / 100;
        }
      }
      // 解析 Flex 属性
      else if (cls.startsWith('flex-')) {
        String flexPart = cls.substring(5);
        if (flexPart == 'row') {
          styles['direction'] = Axis.horizontal;
        } else if (flexPart == 'col') {
          styles['direction'] = Axis.vertical;
        } else if (flexPart == 'wrap') {
          styles['wrap'] = true;
        } else {
          int? flex = int.tryParse(flexPart);
          if (flex != null) {
            styles['flex'] = flex;
          }
        }
      }
      // 解析对齐方式
      else if (cls.startsWith('justify-')) {
        String justifyPart = cls.substring(8);
        switch (justifyPart) {
          case 'start':
            styles['mainAxisAlignment'] = MainAxisAlignment.start;
            break;
          case 'center':
            styles['mainAxisAlignment'] = MainAxisAlignment.center;
            break;
          case 'end':
            styles['mainAxisAlignment'] = MainAxisAlignment.end;
            break;
          case 'between':
            styles['mainAxisAlignment'] = MainAxisAlignment.spaceBetween;
            break;
          case 'around':
            styles['mainAxisAlignment'] = MainAxisAlignment.spaceAround;
            break;
          case 'evenly':
            styles['mainAxisAlignment'] = MainAxisAlignment.spaceEvenly;
            break;
        }
      } else if (cls.startsWith('items-')) {
        String itemsPart = cls.substring(6);
        switch (itemsPart) {
          case 'start':
            styles['crossAxisAlignment'] = CrossAxisAlignment.start;
            break;
          case 'center':
            styles['crossAxisAlignment'] = CrossAxisAlignment.center;
            break;
          case 'end':
            styles['crossAxisAlignment'] = CrossAxisAlignment.end;
            break;
          case 'stretch':
            styles['crossAxisAlignment'] = CrossAxisAlignment.stretch;
            break;
        }
      }
    }

    // 在解析完所有样式后，如果有边框颜色和宽度，构建 Border 对象
    if (styles.containsKey('borderColor') &&
        styles.containsKey('borderWidth')) {
      styles['border'] = Border.all(
        color: styles['borderColor'],
        width: styles['borderWidth'],
      );
    }

    return styles;
  }

  /// Filter responsive classes based on screen size
  static List<String> _filterResponsiveClasses(
    List<String> classes,
    BuildContext context,
  ) {
    List<String> filteredClasses = [];
    double screenWidth = MediaQuery.of(context).size.width;

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

  /// Check if breakpoint should be applied
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

  /// Parse color from various formats
  static Color? _parseColor(String colorName) {
    // 1. 检查是否为方括号包裹的自定义值
    if (colorName.startsWith('[') && colorName.endsWith(']')) {
      String customValue = colorName.substring(1, colorName.length - 1);

      // 解析十六进制颜色
      if (customValue.startsWith('#')) {
        return _parseHexColor(customValue);
      }

      // 解析 RGB/RGBA 颜色
      if (customValue.startsWith('rgb(') || customValue.startsWith('rgba(')) {
        return _parseRgbColor(customValue);
      }

      // 解析 HSL/HSLA 颜色
      if (customValue.startsWith('hsl(') || customValue.startsWith('hsla(')) {
        return _parseHslColor(customValue);
      }

      return null;
    }

    // 2. 尝试从 Wind 配置中获取颜色
    Color? windColor = Wind.getColor(colorName);
    if (windColor != null) {
      return windColor;
    }

    // 3. 回退到基础颜色映射
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
      case 'grey':
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

  /// Parse hexadecimal color
  static Color? _parseHexColor(String hex) {
    try {
      // 移除 # 符号
      String hexCode = hex.replaceFirst('#', '');

      // 处理 3 位十六进制颜色（如 #fff）
      if (hexCode.length == 3) {
        hexCode = hexCode.split('').map((char) => char + char).join();
      }

      // 处理 6 位十六进制颜色（如 #ffffff）
      if (hexCode.length == 6) {
        hexCode = 'FF' + hexCode; // 添加 alpha 通道
      }

      // 处理 8 位十六进制颜色（如 #ffffffff）
      if (hexCode.length == 8) {
        int value = int.parse(hexCode, radix: 16);
        return Color(value);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Parse RGB/RGBA color
  static Color? _parseRgbColor(String rgb) {
    try {
      // 移除所有空格
      String cleanRgb = rgb.replaceAll(' ', '');

      // 解析 rgb(255, 255, 255) 格式
      RegExp rgbRegex = RegExp(r'rgb\((\d+),(\d+),(\d+)\)');
      Match? match = rgbRegex.firstMatch(cleanRgb);

      if (match != null) {
        int r = int.parse(match.group(1)!);
        int g = int.parse(match.group(2)!);
        int b = int.parse(match.group(3)!);

        // 确保 RGB 值在有效范围内 (0.2.6)
        r = r.clamp(0, 255);
        g = g.clamp(0, 255);
        b = b.clamp(0, 255);

        return Color.fromRGBO(r, g, b, 1.0);
      }

      // 解析 rgba(255, 255, 255, 0.5) 格式
      RegExp rgbaRegex = RegExp(r'rgba\((\d+),(\d+),(\d+),([0-9]*\.?[0-9]+)\)');
      Match? rgbaMatch = rgbaRegex.firstMatch(cleanRgb);

      if (rgbaMatch != null) {
        int r = int.parse(rgbaMatch.group(1)!);
        int g = int.parse(rgbaMatch.group(2)!);
        int b = int.parse(rgbaMatch.group(3)!);
        double a = double.parse(rgbaMatch.group(4)!);

        // 确保值在有效范围内
        r = r.clamp(0, 255);
        g = g.clamp(0, 255);
        b = b.clamp(0, 255);
        a = a.clamp(0.0, 1.0);

        return Color.fromRGBO(r, g, b, a);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Parse HSL/HSLA color
  static Color? _parseHslColor(String hsl) {
    try {
      String cleanHsl = hsl.replaceAll(' ', '').replaceAll('%', '');

      // 解析 hsl(360, 100, 50) 格式
      RegExp hslRegex = RegExp(r'hsl\((\d+),(\d+),(\d+)\)');
      Match? match = hslRegex.firstMatch(cleanHsl);

      if (match != null) {
        double h = double.parse(match.group(1)!) / 360.0;
        double s = double.parse(match.group(2)!) / 100.0;
        double l = double.parse(match.group(3)!) / 100.0;

        return HSLColor.fromAHSL(1.0, h * 360, s, l).toColor();
      }

      // 解析 hsla(360, 100, 50, 0.5) 格式
      RegExp hslaRegex = RegExp(r'hsla\((\d+),(\d+),(\d+),([0-9]*\.?[0-9]+)\)');
      Match? hslaMatch = hslaRegex.firstMatch(cleanHsl);

      if (hslaMatch != null) {
        double h = double.parse(hslaMatch.group(1)!) / 360.0;
        double s = double.parse(hslaMatch.group(2)!) / 100.0;
        double l = double.parse(hslaMatch.group(3)!) / 100.0;
        double a = double.parse(hslaMatch.group(4)!);

        return HSLColor.fromAHSL(a, h * 360, s, l).toColor();
      }

      return null;
    } catch (e) {
      return null;
    }
  }


  /// Parse spacing values
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
      case '32':
        return 128;
      case '40':
        return 160;
      case '48':
        return 192;
      case '56':
        return 224;
      case '64':
        return 256;
      default:
        return double.tryParse(value);
    }
  }

  /// Parse size values
  static double? _parseSize(String value) {
    if (value == 'full') return double.infinity;
    if (value == 'screen') return double.infinity;
    return _parseSpacing(value);
  }

  /// Parse font size
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

  /// Parse font weight
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

  /// Parse box shadow
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
      case 'shadow-sm':
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ];
      case 'shadow-lg':
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ];
      case 'shadow-xl':
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ];
      case 'shadow-2xl':
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ];
      case 'shadow-none':
        return [];
      default:
        return null;
    }
  }

  /// Parse component-specific styles
  static Map<String, dynamic> _parseComponentSpecificStyles(
    String className,
    String componentType,
  ) {
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

  /// Container specific styles
  static Map<String, dynamic> _parseContainerStyles(String className) {
    Map<String, dynamic> styles = {};
    List<String> classes = className.split(' ');

    Color? borderColor;
    double? borderWidth;

    for (String cls in classes) {
      if (cls == 'border') {
        borderWidth = 1.0;
        borderColor = borderColor ?? Colors.grey;
      } else if (cls.startsWith('border-')) {
        String borderPart = cls.substring(7);

        // 尝试解析颜色
        Color? color = _parseColor(borderPart);
        if (color != null) {
          borderColor = color;
          borderWidth = borderWidth ?? 1.0;
        } else {
          // 尝试解析宽度
          double? width = double.tryParse(borderPart);
          if (width != null) {
            borderWidth = width;
            borderColor = borderColor ?? Colors.grey;
          }
        }
      }
    }

    // 如果有边框设置，创建 Border 对象
    if (borderWidth != null && borderColor != null) {
      styles['border'] = Border.all(color: borderColor, width: borderWidth);
    }

    return styles;
  }

  /// Text specific styles
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
      } else if (cls == 'uppercase') {
        styles['textTransform'] = 'uppercase';
      } else if (cls == 'lowercase') {
        styles['textTransform'] = 'lowercase';
      } else if (cls == 'capitalize') {
        styles['textTransform'] = 'capitalize';
      }
    }

    return styles;
  }

  /// Button specific styles
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
      } else if (cls == 'btn-outline') {
        styles['side'] = const BorderSide(color: Colors.blue);
        styles['backgroundColor'] = Colors.transparent;
        styles['foregroundColor'] = Colors.blue;
      }
    }

    return styles;
  }

  /// Card specific styles
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

  /// List specific styles
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

  /// ListTile specific styles
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

  /// AppBar specific styles
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

  /// TextField specific styles
  static Map<String, dynamic> _parseTextFieldStyles(String className) {
    Map<String, dynamic> styles = {};
    List<String> classes = className.split(' ');

    for (String cls in classes) {
      if (cls == 'outlined') {
        styles['border'] = const OutlineInputBorder();
      } else if (cls == 'filled') {
        styles['filled'] = true;
      }
    }

    return styles;
  }

  /// Icon specific styles
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

  /// Image specific styles
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
      } else if (cls == 'object-fit-width') {
        styles['fit'] = BoxFit.fitWidth;
      } else if (cls == 'object-fit-height') {
        styles['fit'] = BoxFit.fitHeight;
      }
    }

    return styles;
  }

  /// Stack specific styles
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
      } else if (cls == 'stack-left') {
        styles['alignment'] = Alignment.centerLeft;
      } else if (cls == 'stack-right') {
        styles['alignment'] = Alignment.centerRight;
      }
    }

    return styles;
  }

  /// Positioned specific styles
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
