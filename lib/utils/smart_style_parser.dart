import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'wind_config.dart';

/// 智能样式解析器
/// 
/// 开发模式(kDebugMode=true)：每次重新解析，支持热重载
/// 生产模式(kDebugMode=false)：使用缓存，优化性能
class SmartStyleParser {
  // 生产环境缓存
  static final Map<String, Map<String, dynamic>> _cache = {};
  
  // 自定义颜色系统
  static final Map<String, Map<String, Color>> _customColors = {};
  
  /// 初始化方法，允许用户添加自定义色系
  /// 
  /// [customColors] - 自定义颜色映射
  /// 例如: {
  ///   'brand': {
  ///     '50': Color(0xFFF0F9FF),
  ///     '100': Color(0xFFE0F2FE),
  ///     '500': Color(0xFF0EA5E9),
  ///     '900': Color(0xFF0C4A6E),
  ///   }
  /// }
  static void initialize({Map<String, Map<String, Color>>? customColors}) {
    if (customColors != null) {
      _customColors.clear();
      _customColors.addAll(customColors);
    }
  }
  
  /// 添加单个色系
  /// 
  /// [colorName] - 颜色名称，如 'brand'
  /// [colorShades] - 颜色色阶映射，如 {'50': Color(0xFFF0F9FF), '500': Color(0xFF0EA5E9)}
  static void addColorSystem(String colorName, Map<String, Color> colorShades) {
    _customColors[colorName] = colorShades;
  }
  
  /// 获取自定义颜色
  static Color? getCustomColor(String colorName) {
    // 检查是否包含色阶，如 brand-500
    if (colorName.contains('-')) {
      List<String> parts = colorName.split('-');
      if (parts.length == 2) {
        String baseName = parts[0];
        String shade = parts[1];
        return _customColors[baseName]?[shade];
      }
    }
    
    // 检查基础颜色名
    return _customColors[colorName]?['500'] ?? _customColors[colorName]?.values.first;
  }
  
  /// Parse className string and return style properties.
  ///
  /// [className] - Space-separated class names
  /// [componentType] - Type of component for specific parsing
  /// [context] - Build context for responsive design
  static Map<String, dynamic> parseClassName(
    String className,
    String componentType,
    BuildContext context,
  ) {
    if (className.isEmpty) return {};

    // 生成缓存键
    final screenWidth = MediaQuery.of(context).size.width;
    final cacheKey = '$className:$componentType:$screenWidth';
    
    // 生产环境使用缓存，开发环境每次重新解析以支持热重载
    if (!kDebugMode && _cache.containsKey(cacheKey)) {
      return Map<String, dynamic>.from(_cache[cacheKey]!);
    }

    var styles = <String, dynamic>{};
    
    // 解析响应式类名
    List<String> classes = _filterResponsiveClasses(className.split(' '), context);
    
    // 解析基础样式
    for (String cls in classes) {
      cls = cls.trim();
      if (cls.isEmpty) continue;
      
      _parseBasicStyles(cls, styles);
    }
    
    // 处理渐变背景
    _processGradient(styles);
    
    // 生产环境缓存结果
    if (!kDebugMode) {
      _cache[cacheKey] = Map<String, dynamic>.from(styles);
    }
    
    return styles;
  }
  
  /// 清空缓存（用于开发时手动清理）
  static void clearCache() {
    _cache.clear();
  }
  
  /// 过滤响应式类名
  static List<String> _filterResponsiveClasses(List<String> classes, BuildContext context) {
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
  
  /// 检查断点是否应该应用
  static bool _shouldApplyBreakpoint(String breakpoint, double screenWidth) {
    switch (breakpoint) {
      case 'sm': return screenWidth >= 640;
      case 'md': return screenWidth >= 768;
      case 'lg': return screenWidth >= 1024;
      case 'xl': return screenWidth >= 1280;
      case '2xl': return screenWidth >= 1536;
      default: return true;
    }
  }
  
  /// 解析基础样式
  static void _parseBasicStyles(String cls, Map<String, dynamic> styles) {
    // 渐变背景方向
    if (cls.startsWith('bg-gradient-')) {
      _parseGradientDirection(cls, styles);
    }
    // 渐变起始颜色
    else if (cls.startsWith('from-')) {
      Color? color = _parseColor(cls.substring(5));
      if (color != null) styles['gradientFrom'] = color;
    }
    // 渐变中间颜色
    else if (cls.startsWith('via-')) {
      Color? color = _parseColor(cls.substring(4));
      if (color != null) styles['gradientVia'] = color;
    }
    // 渐变结束颜色
    else if (cls.startsWith('to-')) {
      Color? color = _parseColor(cls.substring(3));
      if (color != null) styles['gradientTo'] = color;
    }
    // 背景颜色
    else if (cls.startsWith('bg-')) {
      Color? color = _parseColor(cls.substring(3));
      if (color != null) styles['backgroundColor'] = color;
    }
    // 文字颜色
    else if (cls.startsWith('text-')) {
      String part = cls.substring(5);
      // 先检查是否是对齐
      switch (part) {
        case 'left': styles['textAlign'] = TextAlign.left; break;
        case 'center': styles['textAlign'] = TextAlign.center; break;
        case 'right': styles['textAlign'] = TextAlign.right; break;
        case 'justify': styles['textAlign'] = TextAlign.justify; break;
        default:
          // 检查字体大小
          double? fontSize = _parseFontSize(part);
          if (fontSize != null) {
            styles['fontSize'] = fontSize;
          } else {
            // 解析颜色
            Color? color = _parseColor(part);
            if (color != null) styles['color'] = color;
          }
      }
    }
    // 内边距
    else if (cls.startsWith('p-')) {
      double? padding = _parseSpacing(cls.substring(2));
      if (padding != null) styles['padding'] = EdgeInsets.all(padding);
    }
    else if (cls.startsWith('px-')) {
      double? padding = _parseSpacing(cls.substring(3));
      if (padding != null) styles['paddingHorizontal'] = padding;
    }
    else if (cls.startsWith('py-')) {
      double? padding = _parseSpacing(cls.substring(3));
      if (padding != null) styles['paddingVertical'] = padding;
    }
    else if (cls.startsWith('pt-')) {
      double? padding = _parseSpacing(cls.substring(3));
      if (padding != null) styles['paddingTop'] = padding;
    }
    else if (cls.startsWith('pb-')) {
      double? padding = _parseSpacing(cls.substring(3));
      if (padding != null) styles['paddingBottom'] = padding;
    }
    else if (cls.startsWith('pl-')) {
      double? padding = _parseSpacing(cls.substring(3));
      if (padding != null) styles['paddingLeft'] = padding;
    }
    else if (cls.startsWith('pr-')) {
      double? padding = _parseSpacing(cls.substring(3));
      if (padding != null) styles['paddingRight'] = padding;
    }
    // 外边距
    else if (cls.startsWith('m-')) {
      double? margin = _parseSpacing(cls.substring(2));
      if (margin != null) styles['margin'] = EdgeInsets.all(margin);
    }
    else if (cls.startsWith('mx-')) {
      double? margin = _parseSpacing(cls.substring(3));
      if (margin != null) styles['marginHorizontal'] = margin;
    }
    else if (cls.startsWith('my-')) {
      double? margin = _parseSpacing(cls.substring(3));
      if (margin != null) styles['marginVertical'] = margin;
    }
    else if (cls.startsWith('mt-')) {
      double? margin = _parseSpacing(cls.substring(3));
      if (margin != null) styles['marginTop'] = margin;
    }
    else if (cls.startsWith('mb-')) {
      double? margin = _parseSpacing(cls.substring(3));
      if (margin != null) styles['marginBottom'] = margin;
    }
    else if (cls.startsWith('ml-')) {
      double? margin = _parseSpacing(cls.substring(3));
      if (margin != null) styles['marginLeft'] = margin;
    }
    else if (cls.startsWith('mr-')) {
      double? margin = _parseSpacing(cls.substring(3));
      if (margin != null) styles['marginRight'] = margin;
    }
    // 圆角
    else if (cls.startsWith('rounded')) {
      if (cls == 'rounded') {
        styles['borderRadius'] = BorderRadius.circular(4);
      } else if (cls.startsWith('rounded-')) {
        String radiusPart = cls.substring(8);
        if (radiusPart == 'full') {
          styles['borderRadius'] = BorderRadius.circular(9999);
        } else if (radiusPart == 'xl') {
          styles['borderRadius'] = BorderRadius.circular(12);
        } else {
          double? radius = _parseSpacing(radiusPart);
          if (radius != null) {
            styles['borderRadius'] = BorderRadius.circular(radius);
          }
        }
      }
    }
    // 字体粗细
    else if (cls.startsWith('font-')) {
      FontWeight? fontWeight = _parseFontWeight(cls.substring(5));
      if (fontWeight != null) styles['fontWeight'] = fontWeight;
    }
    // 阴影
    else if (cls.startsWith('shadow')) {
      List<BoxShadow>? shadow = _parseShadow(cls);
      if (shadow != null) styles['boxShadow'] = shadow;
    }
    // 边框
    else if (cls == 'border') {
      styles['border'] = Border.all(color: wColor('gray-300'), width: 1.0);
    }
    else if (cls.startsWith('border-')) {
      String borderPart = cls.substring(7);
      
      // 边框宽度 border-2, border-4
      if (RegExp(r'^\d+$').hasMatch(borderPart)) {
        double width = double.tryParse(borderPart) ?? 1.0;
        styles['border'] = Border.all(color: wColor('gray-300'), width: width);
      }
      // 边框颜色 border-red-500, border-[#ff0000]
      else {
        Color? color = _parseColor(borderPart);
        if (color != null) {
          styles['border'] = Border.all(color: color, width: 1.0);
        }
      }
    }
    // 宽度和高度
    else if (cls.startsWith('w-')) {
      double? width = _parseSize(cls.substring(2));
      if (width != null) styles['width'] = width;
    }
    else if (cls.startsWith('min-w-')) {
      double? minWidth = _parseSize(cls.substring(6));
      if (minWidth != null) styles['minWidth'] = minWidth;
    }
    else if (cls.startsWith('max-w-')) {
      double? maxWidth = _parseSize(cls.substring(6));
      if (maxWidth != null) styles['maxWidth'] = maxWidth;
    }
    else if (cls.startsWith('h-')) {
      double? height = _parseSize(cls.substring(2));
      if (height != null) styles['height'] = height;
    }
    else if (cls.startsWith('min-h-')) {
      double? minHeight = _parseSize(cls.substring(6));
      if (minHeight != null) styles['minHeight'] = minHeight;
    }
    else if (cls.startsWith('max-h-')) {
      double? maxHeight = _parseSize(cls.substring(6));
      if (maxHeight != null) styles['maxHeight'] = maxHeight;
    }
    // Flex相关
    else if (cls.startsWith('flex')) {
      if (cls == 'flex') {
        styles['display'] = 'flex';
      } else if (cls == 'flex-row') {
        styles['flexDirection'] = Axis.horizontal;
      } else if (cls == 'flex-col') {
        styles['flexDirection'] = Axis.vertical;
      }
    }
    // 对齐
    else if (cls.startsWith('justify-')) {
      String alignPart = cls.substring(8);
      switch (alignPart) {
        case 'start': styles['mainAxisAlignment'] = MainAxisAlignment.start; break;
        case 'center': styles['mainAxisAlignment'] = MainAxisAlignment.center; break;
        case 'end': styles['mainAxisAlignment'] = MainAxisAlignment.end; break;
        case 'between': styles['mainAxisAlignment'] = MainAxisAlignment.spaceBetween; break;
        case 'around': styles['mainAxisAlignment'] = MainAxisAlignment.spaceAround; break;
        case 'evenly': styles['mainAxisAlignment'] = MainAxisAlignment.spaceEvenly; break;
      }
    }
    else if (cls.startsWith('items-')) {
      String alignPart = cls.substring(6);
      switch (alignPart) {
        case 'start': styles['crossAxisAlignment'] = CrossAxisAlignment.start; break;
        case 'center': styles['crossAxisAlignment'] = CrossAxisAlignment.center; break;
        case 'end': styles['crossAxisAlignment'] = CrossAxisAlignment.end; break;
        case 'stretch': styles['crossAxisAlignment'] = CrossAxisAlignment.stretch; break;
      }
    }
    // 间距
    else if (cls.startsWith('gap-')) {
      double? gap = _parseSpacing(cls.substring(4));
      if (gap != null) styles['gap'] = gap;
    }
    // 透明度
    else if (cls.startsWith('opacity-')) {
      String opacityPart = cls.substring(8);
      double? opacity = _parseOpacity(opacityPart);
      if (opacity != null) styles['opacity'] = opacity;
    }
    // 文本装饰
    else if (cls == 'underline') {
      styles['decoration'] = TextDecoration.underline;
    }
    else if (cls == 'line-through') {
      styles['decoration'] = TextDecoration.lineThrough;
    }
    else if (cls == 'no-underline') {
      styles['decoration'] = TextDecoration.none;
    }
    // 文本变换
    else if (cls == 'uppercase') {
      styles['textTransform'] = 'uppercase';
    }
    else if (cls == 'lowercase') {
      styles['textTransform'] = 'lowercase';
    }
    else if (cls == 'capitalize') {
      styles['textTransform'] = 'capitalize';
    }
    // 溢出处理
    else if (cls == 'overflow-hidden') {
      styles['overflow'] = TextOverflow.clip;
    }
    else if (cls == 'overflow-ellipsis') {
      styles['overflow'] = TextOverflow.ellipsis;
    }
    // 最大行数
    else if (cls.startsWith('line-clamp-')) {
      String linePart = cls.substring(11);
      int? maxLines = int.tryParse(linePart);
      if (maxLines != null) {
        styles['maxLines'] = maxLines;
        styles['overflow'] = TextOverflow.ellipsis;
      }
    }
  }
  
  /// 解析渐变方向
  static void _parseGradientDirection(String cls, Map<String, dynamic> styles) {
    if (cls == 'bg-gradient-to-r') {
      styles['gradientDirection'] = 'to-r';
    } else if (cls == 'bg-gradient-to-l') {
      styles['gradientDirection'] = 'to-l';
    } else if (cls == 'bg-gradient-to-t') {
      styles['gradientDirection'] = 'to-t';
    } else if (cls == 'bg-gradient-to-b') {
      styles['gradientDirection'] = 'to-b';
    } else if (cls == 'bg-gradient-to-tr') {
      styles['gradientDirection'] = 'to-tr';
    } else if (cls == 'bg-gradient-to-tl') {
      styles['gradientDirection'] = 'to-tl';
    } else if (cls == 'bg-gradient-to-br') {
      styles['gradientDirection'] = 'to-br';
    } else if (cls == 'bg-gradient-to-bl') {
      styles['gradientDirection'] = 'to-bl';
    }
  }
  
  /// 处理渐变背景
  static void _processGradient(Map<String, dynamic> styles) {
    if (styles.containsKey('gradientDirection') && 
        (styles.containsKey('gradientFrom') || styles.containsKey('gradientTo'))) {
      
      Color fromColor = styles['gradientFrom'] ?? Colors.transparent;
      Color toColor = styles['gradientTo'] ?? Colors.transparent;
      Color? viaColor = styles['gradientVia'];
      
      List<Color> colors = [fromColor];
      if (viaColor != null) {
        colors.add(viaColor);
      }
      colors.add(toColor);
      
      Alignment begin = Alignment.centerLeft;
      Alignment end = Alignment.centerRight;
      
      switch (styles['gradientDirection']) {
        case 'to-r':
          begin = Alignment.centerLeft;
          end = Alignment.centerRight;
          break;
        case 'to-l':
          begin = Alignment.centerRight;
          end = Alignment.centerLeft;
          break;
        case 'to-t':
          begin = Alignment.bottomCenter;
          end = Alignment.topCenter;
          break;
        case 'to-b':
          begin = Alignment.topCenter;
          end = Alignment.bottomCenter;
          break;
        case 'to-tr':
          begin = Alignment.bottomLeft;
          end = Alignment.topRight;
          break;
        case 'to-tl':
          begin = Alignment.bottomRight;
          end = Alignment.topLeft;
          break;
        case 'to-br':
          begin = Alignment.topLeft;
          end = Alignment.bottomRight;
          break;
        case 'to-bl':
          begin = Alignment.topRight;
          end = Alignment.bottomLeft;
          break;
      }
      
      styles['gradient'] = LinearGradient(
        begin: begin,
        end: end,
        colors: colors,
      );
      
      // 移除背景颜色，使用渐变
      styles.remove('backgroundColor');
    }
  }
  
  /// 解析颜色
  static Color? _parseColor(String colorName) {
    // 处理任意值颜色 [#ffffff], [rgb(255,0,0)], [hsl(0,100%,50%)] 等
    if (colorName.startsWith('[') && colorName.endsWith(']')) {
      String colorValue = colorName.substring(1, colorName.length - 1);
      return _parseArbitraryColor(colorValue);
    }
    
    // 处理透明度修饰符 white/70, red-500/50
    if (colorName.contains('/')) {
      List<String> parts = colorName.split('/');
      if (parts.length == 2) {
        String baseColorName = parts[0];
        String opacityStr = parts[1];
        
        // 解析透明度值
        double? opacity = _parseOpacityValue(opacityStr);
        if (opacity == null) return null;
        
        // 获取基础颜色
        Color? baseColor = _parseBaseColor(baseColorName);
        if (baseColor == null) return null;
        
        // 应用透明度
        return baseColor.withValues(alpha: opacity);
      }
    }
    
    // 解析基础颜色（不带透明度）
    return _parseBaseColor(colorName);
  }
  
  /// 解析基础颜色（不带透明度修饰符）
  static Color? _parseBaseColor(String colorName) {
    // 检查自定义颜色系统
    Color? customColor = getCustomColor(colorName);
    if (customColor != null) return customColor;
    
    // 从Wind配置获取颜色
    Color? windColor = Wind.getColor(colorName);
    if (windColor != null) return windColor;
    
    // 基础颜色
    switch (colorName) {
      case 'red': return Colors.red;
      case 'blue': return Colors.blue;
      case 'green': return Colors.green;
      case 'yellow': return Colors.yellow;
      case 'purple': return Colors.purple;
      case 'pink': return Colors.pink;
      case 'gray': case 'grey': return Colors.grey;
      case 'black': return Colors.black;
      case 'white': return Colors.white;
      case 'transparent': return Colors.transparent;
      default: return null;
    }
  }
  
  /// 解析透明度值
  static double? _parseOpacityValue(String opacityStr) {
    // 处理百分比 70 -> 0.7
    if (RegExp(r'^\d+$').hasMatch(opacityStr)) {
      int percentage = int.tryParse(opacityStr) ?? 0;
      if (percentage >= 0 && percentage <= 100) {
        return percentage / 100.0;
      }
    }
    
    // 处理小数 0.7
    double? opacity = double.tryParse(opacityStr);
    if (opacity != null && opacity >= 0.0 && opacity <= 1.0) {
      return opacity;
    }
    
    return null;
  }
  
  /// 解析任意值颜色
  static Color? _parseArbitraryColor(String colorValue) {
    try {
      // 十六进制颜色 #ffffff 或 #fff
      if (colorValue.startsWith('#')) {
        String hex = colorValue.substring(1);
        
        // 处理 3 位十六进制 #fff -> #ffffff
        if (hex.length == 3) {
          hex = hex.split('').map((char) => char + char).join('');
        }
        
        if (hex.length == 6) {
          int value = int.parse(hex, radix: 16);
          return Color(0xFF000000 | value);
        } else if (hex.length == 8) {
          // 包含透明度的十六进制 #ffffffff
          int value = int.parse(hex, radix: 16);
          return Color(value);
        }
      }
      
      // RGB 颜色 rgb(255,0,0)
      else if (colorValue.startsWith('rgb(') && colorValue.endsWith(')')) {
        String rgbValues = colorValue.substring(4, colorValue.length - 1);
        List<String> values = rgbValues.split(',').map((s) => s.trim()).toList();
        
        if (values.length == 3) {
          int r = int.parse(values[0]);
          int g = int.parse(values[1]);
          int b = int.parse(values[2]);
          return Color.fromRGBO(r, g, b, 1.0);
        }
      }
      
      // RGBA 颜色 rgba(255,0,0,0.5)
      else if (colorValue.startsWith('rgba(') && colorValue.endsWith(')')) {
        String rgbaValues = colorValue.substring(5, colorValue.length - 1);
        List<String> values = rgbaValues.split(',').map((s) => s.trim()).toList();
        
        if (values.length == 4) {
          int r = int.parse(values[0]);
          int g = int.parse(values[1]);
          int b = int.parse(values[2]);
          double a = double.parse(values[3]);
          return Color.fromRGBO(r, g, b, a);
        }
      }
      
      // HSL 颜色 hsl(0,100%,50%)
      else if (colorValue.startsWith('hsl(') && colorValue.endsWith(')')) {
        String hslValues = colorValue.substring(4, colorValue.length - 1);
        List<String> values = hslValues.split(',').map((s) => s.trim()).toList();
        
        if (values.length == 3) {
          double h = double.parse(values[0]);
          double s = double.parse(values[1].replaceAll('%', '')) / 100.0;
          double l = double.parse(values[2].replaceAll('%', '')) / 100.0;
          return _hslToColor(h, s, l, 1.0);
        }
      }
      
      // HSLA 颜色 hsla(0,100%,50%,0.5)
      else if (colorValue.startsWith('hsla(') && colorValue.endsWith(')')) {
        String hslaValues = colorValue.substring(5, colorValue.length - 1);
        List<String> values = hslaValues.split(',').map((s) => s.trim()).toList();
        
        if (values.length == 4) {
          double h = double.parse(values[0]);
          double s = double.parse(values[1].replaceAll('%', '')) / 100.0;
          double l = double.parse(values[2].replaceAll('%', '')) / 100.0;
          double a = double.parse(values[3]);
          return _hslToColor(h, s, l, a);
        }
      }
    } catch (e) {
      // 解析失败时返回 null
      if (kDebugMode) {
        print('Failed to parse color: $colorValue, error: $e');
      }
    }
    
    return null;
  }
  
  /// HSL 转 Color
  static Color _hslToColor(double h, double s, double l, double a) {
    h = h / 360.0;
    
    double r, g, b;
    
    if (s == 0) {
      r = g = b = l; // 灰色
    } else {
      double hue2rgb(double p, double q, double t) {
        if (t < 0) t += 1;
        if (t > 1) t -= 1;
        if (t < 1/6) return p + (q - p) * 6 * t;
        if (t < 1/2) return q;
        if (t < 2/3) return p + (q - p) * (2/3 - t) * 6;
        return p;
      }
      
      double q = l < 0.5 ? l * (1 + s) : l + s - l * s;
      double p = 2 * l - q;
      r = hue2rgb(p, q, h + 1/3);
      g = hue2rgb(p, q, h);
      b = hue2rgb(p, q, h - 1/3);
    }
    
    return Color.fromRGBO(
      (r * 255).round(),
      (g * 255).round(),
      (b * 255).round(),
      a,
    );
  }
  
  /// 解析间距
  static double? _parseSpacing(String value) {
    // 处理任意值 [10px], [1rem], [20] 等
    if (value.startsWith('[') && value.endsWith(']')) {
      String arbitraryValue = value.substring(1, value.length - 1);
      return _parseArbitrarySize(arbitraryValue);
    }
    
    switch (value) {
      case '0': return 0;
      case '1': return 4;
      case '2': return 8;
      case '3': return 12;
      case '4': return 16;
      case '5': return 20;
      case '6': return 24;
      case '8': return 32;
      case '10': return 40;
      case '12': return 48;
      case '16': return 64;
      case '20': return 80;
      case '24': return 96;
      case '32': return 128;
      case 'sm': return 2;
      case 'md': return 6;
      case 'lg': return 8;
      case 'xl': return 12;
      case '2xl': return 16;
      case '3xl': return 24;
      default: return double.tryParse(value);
    }
  }
  
  /// 解析尺寸
  static double? _parseSize(String value) {
    // 处理任意值 [200px], [50%], [100] 等
    if (value.startsWith('[') && value.endsWith(']')) {
      String arbitraryValue = value.substring(1, value.length - 1);
      return _parseArbitrarySize(arbitraryValue);
    }
    
    switch (value) {
      case 'full': return double.infinity;
      case 'screen': return double.infinity;
      case 'auto': return null;
      default: return _parseSpacing(value);
    }
  }
  
  /// 解析任意值尺寸
  static double? _parseArbitrarySize(String value) {
    try {
      // 处理像素值 10px, 20px
      if (value.endsWith('px')) {
        String numStr = value.substring(0, value.length - 2);
        return double.tryParse(numStr);
      }
      
      // 处理 rem 值 1rem, 2rem (1rem = 16px)
      else if (value.endsWith('rem')) {
        String numStr = value.substring(0, value.length - 3);
        double? remValue = double.tryParse(numStr);
        return remValue != null ? remValue * 16 : null;
      }
      
      // 处理 em 值 1em, 2em (1em = 16px)
      else if (value.endsWith('em')) {
        String numStr = value.substring(0, value.length - 2);
        double? emValue = double.tryParse(numStr);
        return emValue != null ? emValue * 16 : null;
      }
      
      // 处理百分比值 50%, 100% (转换为合理的像素值以避免溢出)
      else if (value.endsWith('%')) {
        String numStr = value.substring(0, value.length - 1);
        double? percentValue = double.tryParse(numStr);
        if (percentValue != null) {
          // 将百分比转换为合理的像素值，避免溢出
          // 假设屏幕宽度为400px作为基准
          return (percentValue / 100) * 400;
        }
        return null;
      }
      
      // 处理纯数字 10, 20 (按像素处理)
      else {
        return double.tryParse(value);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to parse arbitrary size: $value, error: $e');
      }
    }
    
    return null;
  }
  
  /// 解析字体大小
  static double? _parseFontSize(String value) {
    switch (value) {
      case 'xs': return 12;
      case 'sm': return 14;
      case 'base': return 16;
      case 'lg': return 18;
      case 'xl': return 20;
      case '2xl': return 24;
      case '3xl': return 30;
      case '4xl': return 36;
      case '5xl': return 48;
      case '6xl': return 60;
      default: return null;
    }
  }
  
  /// 解析字体粗细
  static FontWeight? _parseFontWeight(String value) {
    switch (value) {
      case 'thin': return FontWeight.w100;
      case 'extralight': return FontWeight.w200;
      case 'light': return FontWeight.w300;
      case 'normal': return FontWeight.w400;
      case 'medium': return FontWeight.w500;
      case 'semibold': return FontWeight.w600;
      case 'bold': return FontWeight.w700;
      case 'extrabold': return FontWeight.w800;
      case 'black': return FontWeight.w900;
      default: return null;
    }
  }
  
  /// 解析阴影
  static List<BoxShadow>? _parseShadow(String value) {
    switch (value) {
      case 'shadow':
      case 'shadow-md':
        return [BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        )];
      case 'shadow-sm':
        return [BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 2,
          offset: const Offset(0, 1),
        )];
      case 'shadow-lg':
        return [BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 8,
          offset: const Offset(0, 4),
        )];
      case 'shadow-xl':
        return [BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 12,
          offset: const Offset(0, 6),
        )];
      case 'shadow-2xl':
        return [BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 25,
          offset: const Offset(0, 25),
        )];
      case 'shadow-none':
        return [];
      default: return null;
    }
  }
  
  /// 解析透明度
  static double? _parseOpacity(String value) {
    switch (value) {
      case '0': return 0.0;
      case '5': return 0.05;
      case '10': return 0.1;
      case '20': return 0.2;
      case '25': return 0.25;
      case '30': return 0.3;
      case '40': return 0.4;
      case '50': return 0.5;
      case '60': return 0.6;
      case '70': return 0.7;
      case '75': return 0.75;
      case '80': return 0.8;
      case '90': return 0.9;
      case '95': return 0.95;
      case '100': return 1.0;
      default: 
        // 处理任意值 [0.5], [0.75]
        if (value.startsWith('[') && value.endsWith(']')) {
          String opacityValue = value.substring(1, value.length - 1);
          return double.tryParse(opacityValue);
        }
        return double.tryParse(value);
    }
  }
}
