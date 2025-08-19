import 'package:flutter/material.dart';
import 'utils/wind_config.dart';
import 'utils/universal_style_parser.dart';

// ==================== 布局组件 ====================

/// A container widget with TailwindCSS-like styling support.
///
/// [WContainer] is a versatile layout component that wraps Flutter's [Container]
/// with utility-first styling capabilities. It supports className-based styling
/// similar to TailwindCSS, making it easy to apply consistent design patterns.
///
/// ## Supported Style Classes
///
/// ### Spacing
/// - `p-{size}`: padding (p-1, p-2, p-4, p-6, p-8)
/// - `m-{size}`: margin (m-1, m-2, m-4, m-6, m-8)
/// - `px-{size}`, `py-{size}`: horizontal/vertical padding
/// - `mx-{size}`, `my-{size}`: horizontal/vertical margin
///
/// ### Colors
/// - `bg-{color}`: background color (bg-white, bg-blue-500, bg-gray-100)
///
/// ### Border Radius
/// - `rounded`: small border radius
/// - `rounded-lg`: large border radius
/// - `rounded-full`: fully rounded
///
/// ### Shadows
/// - `shadow-sm`: small shadow
/// - `shadow-md`: medium shadow
/// - `shadow-lg`: large shadow
///
/// ## Example
///
/// ```dart
/// WContainer(
///   className: 'p-6 m-4 bg-white rounded-lg shadow-md',
///   child: Text('Card content'),
/// )
/// ```
///
/// This creates a container with:
/// - 24px padding on all sides
/// - 16px margin on all sides
/// - White background
/// - Large border radius
/// - Medium shadow
class WContainer extends StatelessWidget {
  /// The widget to display inside the container.
  final Widget? child;
  
  /// TailwindCSS-like class names for styling.
  /// 
  /// Supports spacing, colors, border radius, and shadow utilities.
  /// Multiple classes can be separated by spaces.
  /// 
  /// Example: 'p-4 bg-white rounded-lg shadow-md'
  final String? className;
  
  /// The width of the container.
  /// 
  /// If null, the width will be determined by the className or default behavior.
  final double? width;
  
  /// The height of the container.
  /// 
  /// If null, the height will be determined by the className or default behavior.
  final double? height;
  
  /// The padding inside the container.
  /// 
  /// If provided, this will override any padding specified in [className].
  final EdgeInsetsGeometry? padding;
  
  /// The margin outside the container.
  /// 
  /// If provided, this will override any margin specified in [className].
  final EdgeInsetsGeometry? margin;
  
  /// The background color of the container.
  /// 
  /// If provided, this will override any background color specified in [className].
  final Color? backgroundColor;
  
  /// The border radius of the container.
  /// 
  /// If provided, this will override any border radius specified in [className].
  final BorderRadius? borderRadius;
  
  /// The box shadows of the container.
  /// 
  /// If provided, this will override any shadows specified in [className].
  final List<BoxShadow>? boxShadow;
  
  /// The border of the container.
  /// 
  /// If provided, this will override any border specified in [className].
  final Border? border;
  
  /// How to align the child within the container.
  final AlignmentGeometry? alignment;
  
  /// The clip behavior for the container.
  final Clip clipBehavior;
  
  /// Additional constraints to apply to the child.
  final BoxConstraints? constraints;
  
  /// The transformation matrix to apply to the container.
  final Matrix4? transform;
  
  /// The alignment of the origin for the transformation.
  final AlignmentGeometry? transformAlignment;
  
  /// A decoration to paint in front of the child.
  final Decoration? foregroundDecoration;
  
  /// A decoration to paint behind the child.
  /// 
  /// If provided, this will override the decoration created from [className],
  /// [backgroundColor], [borderRadius], [boxShadow], and [border].
  final Decoration? decoration;

  /// Creates a Wind-styled container.
  /// 
  /// The [className] parameter allows you to specify TailwindCSS-like utility
  /// classes for styling. Other parameters can be used to override specific
  /// styling properties.
  const WContainer({
    super.key,
    this.child,
    this.className,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.border,
    this.alignment,
    this.clipBehavior = Clip.none,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.foregroundDecoration,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '',
      'Container',
      context,
    );

    Widget? containerChild = child;

    // 如果设置了 flex 相关样式，需要用 Flex 包裹子组件
    if (parsedStyles.containsKey('display') && parsedStyles['display'] == 'flex') {
      containerChild = Flex(
        direction: parsedStyles['direction'] ?? Axis.horizontal,
        mainAxisAlignment: parsedStyles['mainAxisAlignment'] ?? MainAxisAlignment.start,
        crossAxisAlignment: parsedStyles['crossAxisAlignment'] ?? CrossAxisAlignment.center,
        children: child != null ? [child!] : [],
      );
    }

    return Container(
      width: width ?? parsedStyles['width'],
      height: height ?? parsedStyles['height'],
      padding: padding ?? parsedStyles['padding'],
      margin: margin ?? parsedStyles['margin'],
      alignment: alignment ?? parsedStyles['alignment'],
      clipBehavior: clipBehavior,
      constraints: constraints,
      transform: transform,
      transformAlignment: transformAlignment,
      foregroundDecoration: foregroundDecoration,
      decoration: decoration ??
          BoxDecoration(
            color: backgroundColor ?? parsedStyles['backgroundColor'],
            borderRadius: borderRadius ?? parsedStyles['borderRadius'],
            boxShadow: boxShadow ?? parsedStyles['boxShadow'],
            border: border ?? parsedStyles['border'],
          ),
      child: containerChild,
    );
  }
}

/// Wind样式的Flex容器组件
class WFlex extends StatelessWidget {
  final List<Widget> children;
  final String? className;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Axis direction;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final MainAxisSize mainAxisSize;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;

  const WFlex({
    super.key,
    required this.children,
    this.className,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.direction = Axis.horizontal,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'Flex',
      context,
    );

    Widget flexWidget = Flex(
      direction: direction,
      mainAxisAlignment: parsedStyles['mainAxisAlignment'] ?? mainAxisAlignment,
      crossAxisAlignment: parsedStyles['crossAxisAlignment'] ?? crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children,
    );

    if (padding != null ||
        margin != null ||
        backgroundColor != null ||
        parsedStyles.isNotEmpty) {
      flexWidget = Container(
        padding: padding ?? parsedStyles['padding'],
        margin: margin ?? parsedStyles['margin'],
        color: backgroundColor ?? parsedStyles['backgroundColor'],
        child: flexWidget,
      );
    }

    return flexWidget;
  }
}

/// Wind样式的Row组件
class WRow extends StatelessWidget {
  final List<Widget> children;
  final String? className;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final MainAxisSize mainAxisSize;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;

  const WRow({
    super.key,
    required this.children,
    this.className,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'Row',
      context,
    );

    Widget rowWidget = Row(
      mainAxisAlignment: parsedStyles['mainAxisAlignment'] ?? mainAxisAlignment,
      crossAxisAlignment: parsedStyles['crossAxisAlignment'] ?? crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children,
    );

    if (padding != null ||
        margin != null ||
        backgroundColor != null ||
        parsedStyles.isNotEmpty) {
      rowWidget = Container(
        padding: padding ?? parsedStyles['padding'],
        margin: margin ?? parsedStyles['margin'],
        color: backgroundColor ?? parsedStyles['backgroundColor'],
        child: rowWidget,
      );
    }

    return rowWidget;
  }
}

/// Wind样式的Column组件
class WColumn extends StatelessWidget {
  final List<Widget> children;
  final String? className;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final MainAxisSize mainAxisSize;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;

  const WColumn({
    super.key,
    required this.children,
    this.className,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'Column',
      context,
    );

    Widget columnWidget = Column(
      mainAxisAlignment: parsedStyles['mainAxisAlignment'] ?? mainAxisAlignment,
      crossAxisAlignment: parsedStyles['crossAxisAlignment'] ?? crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children,
    );

    if (padding != null ||
        margin != null ||
        backgroundColor != null ||
        parsedStyles.isNotEmpty) {
      columnWidget = Container(
        padding: padding ?? parsedStyles['padding'],
        margin: margin ?? parsedStyles['margin'],
        color: backgroundColor ?? parsedStyles['backgroundColor'],
        child: columnWidget,
      );
    }

    return columnWidget;
  }
}

/// Wind样式的Stack组件
class WStack extends StatelessWidget {
  final List<Widget> children;
  final String? className;
  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final StackFit fit;
  final Clip clipBehavior;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;

  const WStack({
    super.key,
    required this.children,
    this.className,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.fit = StackFit.loose,
    this.clipBehavior = Clip.hardEdge,
    this.padding,
    this.margin,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'Stack',
      context,
    );

    Widget stackWidget = Stack(
      alignment: parsedStyles['alignment'] ?? alignment,
      textDirection: textDirection,
      fit: fit,
      clipBehavior: clipBehavior,
      children: children,
    );

    if (padding != null ||
        margin != null ||
        backgroundColor != null ||
        parsedStyles.isNotEmpty) {
      stackWidget = Container(
        padding: padding ?? parsedStyles['padding'],
        margin: margin ?? parsedStyles['margin'],
        color: backgroundColor ?? parsedStyles['backgroundColor'],
        child: stackWidget,
      );
    }

    return stackWidget;
  }
}

/// Wind样式的Positioned组件
class WPositioned extends StatelessWidget {
  final Widget child;
  final String? className;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;

  const WPositioned({
    super.key,
    required this.child,
    this.className,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'Positioned',
      context,
    );

    return Positioned(
      left: left ?? parsedStyles['left'],
      top: top ?? parsedStyles['top'],
      right: right ?? parsedStyles['right'],
      bottom: bottom ?? parsedStyles['bottom'],
      width: width ?? parsedStyles['width'],
      height: height ?? parsedStyles['height'],
      child: child,
    );
  }
}

// ==================== 视觉组件 ====================

/// Wind样式的卡片组件
class WCard extends StatelessWidget {
  final Widget child;
  final String? className;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final Border? border;
  final Clip clipBehavior;

  const WCard({
    super.key,
    required this.child,
    this.className,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.boxShadow,
    this.borderRadius,
    this.onTap,
    this.border,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'Card',
      context,
    );

    return Container(
      padding: padding ?? parsedStyles['padding'] ?? EdgeInsets.all(wSpacing('4')),
      margin: margin ?? parsedStyles['margin'] ?? EdgeInsets.all(wSpacing('2')),
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: backgroundColor ?? parsedStyles['backgroundColor'] ?? wColor('white'),
        boxShadow: boxShadow ?? parsedStyles['boxShadow'] ?? wShadow('md'),
        borderRadius: borderRadius ?? parsedStyles['borderRadius'] ?? BorderRadius.circular(wBorderRadius('lg')),
        border: border ?? parsedStyles['border'],
      ),
      child: onTap != null
          ? InkWell(
              onTap: onTap,
              borderRadius: borderRadius ?? parsedStyles['borderRadius'] ?? BorderRadius.circular(wBorderRadius('lg')),
              child: child,
            )
          : child,
    );
  }
}

/// A text widget with TailwindCSS-like styling support.
///
/// [WText] extends Flutter's [Text] widget with utility-first styling
/// capabilities. It supports className-based styling for typography,
/// colors, and text alignment.
///
/// ## Supported Style Classes
///
/// ### Font Sizes
/// - `text-xs`: 12px
/// - `text-sm`: 14px
/// - `text-base`: 16px (default)
/// - `text-lg`: 18px
/// - `text-xl`: 20px
/// - `text-2xl`: 24px
///
/// ### Font Weights
/// - `font-thin`: FontWeight.w100
/// - `font-light`: FontWeight.w300
/// - `font-normal`: FontWeight.w400
/// - `font-medium`: FontWeight.w500
/// - `font-semibold`: FontWeight.w600
/// - `font-bold`: FontWeight.w700
/// - `font-extrabold`: FontWeight.w800
/// - `font-black`: FontWeight.w900
///
/// ### Text Colors
/// - `text-{color}`: text color (text-gray-900, text-blue-500, text-red-500)
///
/// ### Text Alignment
/// - `text-left`: left alignment
/// - `text-center`: center alignment
/// - `text-right`: right alignment
/// - `text-justify`: justify alignment
///
/// ## Example
///
/// ```dart
/// WText(
///   'Hello World',
///   className: 'text-xl font-bold text-blue-600 text-center',
/// )
/// ```
///
/// This creates text with:
/// - 20px font size
/// - Bold font weight
/// - Blue color
/// - Center alignment
class WText extends StatelessWidget {
  /// The text to display.
  final String text;
  
  /// TailwindCSS-like class names for styling.
  /// 
  /// Supports typography, colors, and alignment utilities.
  /// Multiple classes can be separated by spaces.
  /// 
  /// Example: 'text-lg font-bold text-gray-900 text-center'
  final String? className;
  
  /// The text style to apply.
  /// 
  /// If provided, this will be merged with styles from [className].
  final TextStyle? style;
  
  /// The color of the text.
  /// 
  /// If provided, this will override any color specified in [className].
  final Color? color;
  
  /// The font size of the text.
  /// 
  /// If provided, this will override any font size specified in [className].
  final double? fontSize;
  
  /// The font weight of the text.
  /// 
  /// If provided, this will override any font weight specified in [className].
  final FontWeight? fontWeight;
  
  /// How the text should be aligned horizontally.
  /// 
  /// If provided, this will override any alignment specified in [className].
  final TextAlign? textAlign;
  
  /// The maximum number of lines for the text to span.
  final int? maxLines;
  
  /// How visual overflow should be handled.
  final TextOverflow? overflow;
  
  /// The amount of space between each letter.
  final double? letterSpacing;
  
  /// The amount of space between each word.
  final double? wordSpacing;
  
  /// The height of this text span, as a multiple of the font size.
  final double? height;
  
  /// The decoration to paint near the text.
  final TextDecoration? decoration;
  
  /// The color in which to paint the text decoration.
  final Color? decorationColor;
  
  /// The style in which to paint the text decoration.
  final TextDecorationStyle? decorationStyle;

  /// Creates a Wind-styled text widget.
  /// 
  /// The [text] parameter is required and specifies the text to display.
  /// The [className] parameter allows you to specify TailwindCSS-like utility
  /// classes for styling.
  const WText(
    this.text, {
    super.key,
    this.className,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'Text',
      context,
    );

    Widget textWidget = Text(
      text,
      style: (style ?? const TextStyle()).copyWith(
        color: color ?? parsedStyles['color'] ?? wColor('gray-900'),
        fontSize: fontSize ?? parsedStyles['fontSize'],
        fontWeight: fontWeight ?? parsedStyles['fontWeight'],
        letterSpacing: letterSpacing ?? parsedStyles['letterSpacing'],
        wordSpacing: wordSpacing ?? parsedStyles['wordSpacing'],
        height: height ?? parsedStyles['height'],
        decoration: decoration ?? parsedStyles['decoration'],
        decorationColor: decorationColor ?? parsedStyles['decorationColor'],
        decorationStyle: decorationStyle ?? parsedStyles['decorationStyle'],
      ),
      textAlign: textAlign ?? parsedStyles['textAlign'],
      maxLines: maxLines,
      overflow: overflow,
    );

    // 如果设置了 text-center、text-left、text-right 等对齐样式，
    // 需要让文本占据整个可用宽度才能看到对齐效果
    final hasTextAlign = parsedStyles['textAlign'] != null || textAlign != null;
    if (hasTextAlign) {
      return SizedBox(
        width: double.infinity,
        child: textWidget,
      );
    }

    return textWidget;
  }
}

/// Wind样式的图标组件
class WIcon extends StatelessWidget {
  final IconData icon;
  final String? className;
  final double? size;
  final Color? color;
  final String? semanticLabel;
  final TextDirection? textDirection;

  const WIcon(
    this.icon, {
    super.key,
    this.className,
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'Icon',
      context,
    );

    return Icon(
      icon,
      size: size ?? parsedStyles['size'] ?? 24.0,
      color: color ?? parsedStyles['color'] ?? wColor('gray-700'),
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}

/// Wind样式的图片组件
class WImage extends StatelessWidget {
  final ImageProvider image;
  final String? className;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final Color? color;
  final BlendMode? colorBlendMode;
  final FilterQuality filterQuality;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;

  const WImage({
    super.key,
    required this.image,
    this.className,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.low,
    this.borderRadius,
    this.boxShadow,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'Image',
      context,
    );

    Widget imageWidget = Image(
      image: image,
      width: width ?? parsedStyles['width'],
      height: height ?? parsedStyles['height'],
      fit: fit ?? parsedStyles['fit'],
      alignment: alignment,
      repeat: repeat,
      color: color ?? parsedStyles['color'],
      colorBlendMode: colorBlendMode,
      filterQuality: filterQuality,
    );

    if (borderRadius != null || boxShadow != null || border != null || parsedStyles.containsKey('borderRadius') || parsedStyles.containsKey('boxShadow') || parsedStyles.containsKey('border')) {
      imageWidget = Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? parsedStyles['borderRadius'],
          boxShadow: boxShadow ?? parsedStyles['boxShadow'],
          border: border ?? parsedStyles['border'],
        ),
        clipBehavior: Clip.hardEdge,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}

/// Wind样式的头像组件
class WAvatar extends StatelessWidget {
  final String? className;
  final double? radius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final ImageProvider? backgroundImage;
  final Widget? child;
  final double? minRadius;
  final double? maxRadius;

  const WAvatar({
    super.key,
    this.className,
    this.radius,
    this.backgroundColor,
    this.foregroundColor,
    this.backgroundImage,
    this.child,
    this.minRadius,
    this.maxRadius,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'Avatar',
      context,
    );

    return CircleAvatar(
      radius: radius ?? parsedStyles['radius'] ?? 20.0,
      backgroundColor: backgroundColor ?? parsedStyles['backgroundColor'] ?? wColor('gray-300'),
      foregroundColor: foregroundColor ?? parsedStyles['foregroundColor'] ?? wColor('white'),
      backgroundImage: backgroundImage,
      minRadius: minRadius,
      maxRadius: maxRadius,
      child: child,
    );
  }
}

/// Wind样式的分割线组件
class WDivider extends StatelessWidget {
  final String? className;
  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  const WDivider({
    super.key,
    this.className,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'Divider',
      context,
    );

    return Divider(
      height: height ?? parsedStyles['height'],
      thickness: thickness ?? parsedStyles['thickness'] ?? 1.0,
      indent: indent ?? parsedStyles['indent'],
      endIndent: endIndent ?? parsedStyles['endIndent'],
      color: color ?? parsedStyles['color'] ?? wColor('gray-200'),
    );
  }
}

// ==================== 交互组件 ====================

/// Wind样式的按钮组件
class WButton extends StatelessWidget {
  final String text;
  final String? className;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final bool isLoading;
  final bool isDisabled;
  final Widget? icon;
  final ButtonSize size;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  const WButton({
    super.key,
    required this.text,
    this.className,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.borderRadius,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.size = ButtonSize.medium,
    this.border,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = !isDisabled && !isLoading && onPressed != null;
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'Button',
      context,
    );

    EdgeInsetsGeometry buttonPadding;
    double fontSize;

    switch (size) {
      case ButtonSize.small:
        buttonPadding = EdgeInsets.symmetric(
          horizontal: wSpacing('3'),
          vertical: wSpacing('2'),
        );
        fontSize = 14;
        break;
      case ButtonSize.large:
        buttonPadding = EdgeInsets.symmetric(
          horizontal: wSpacing('6'),
          vertical: wSpacing('4'),
        );
        fontSize = 18;
        break;
      case ButtonSize.medium:
        buttonPadding = EdgeInsets.symmetric(
          horizontal: wSpacing('4'),
          vertical: wSpacing('3'),
        );
        fontSize = 16;
        break;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: borderRadius ?? parsedStyles['borderRadius'] ?? BorderRadius.circular(wBorderRadius('lg')),
        child: Container(
          padding: padding ?? parsedStyles['padding'] ?? buttonPadding,
          decoration: BoxDecoration(
            color: isEnabled
                ? (backgroundColor ?? parsedStyles['backgroundColor'] ?? wColor('primary'))
                : wColor('gray-300'),
            borderRadius: borderRadius ?? parsedStyles['borderRadius'] ?? BorderRadius.circular(wBorderRadius('lg')),
            border: border ?? parsedStyles['border'],
            boxShadow: boxShadow ?? parsedStyles['boxShadow'],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  width: fontSize,
                  height: fontSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      textColor ?? parsedStyles['textColor'] ?? wColor('white'),
                    ),
                  ),
                ),
              if (icon != null) ...[icon!, SizedBox(width: wSpacing('2'))],
              Text(
                text,
                style: TextStyle(
                  color: isEnabled
                      ? (textColor ?? parsedStyles['textColor'] ?? wColor('white'))
                      : wColor('gray-500'),
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ButtonSize { small, medium, large }

/// Wind样式的输入框组件
class WInput extends StatelessWidget {
  final String? placeholder;
  final String? className;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final BorderRadius? borderRadius;
  final double? borderWidth;

  const WInput({
    super.key,
    this.placeholder,
    this.className,
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.maxLines = 1,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'Input',
      context,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: padding ?? parsedStyles['padding'] ?? EdgeInsets.symmetric(
            horizontal: wSpacing('3'),
            vertical: wSpacing('2'),
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? parsedStyles['backgroundColor'] ?? wColor('white'),
            borderRadius: borderRadius ?? parsedStyles['borderRadius'] ?? BorderRadius.circular(wBorderRadius('md')),
            border: Border.all(
              color: borderColor ?? parsedStyles['borderColor'] ?? wColor('gray-300'),
              width: borderWidth ?? parsedStyles['borderWidth'] ?? 1.0,
            ),
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            onTap: onTap,
            readOnly: readOnly,
            obscureText: obscureText,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: placeholder,
              border: InputBorder.none,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(top: wSpacing('1')),
            child: Text(
              errorText!,
              style: TextStyle(
                color: wColor('red-500'),
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}

/// Wind样式的列表组件
class WList extends StatelessWidget {
  final List<Widget> children;
  final String? className;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final bool primary;
  final double? itemExtent;
  final Widget? separator;

  const WList({
    super.key,
    required this.children,
    this.className,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
    this.controller,
    this.primary=false,
    this.itemExtent,
    this.separator,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'List',
      context,
    );

    Widget listWidget;

    if (separator != null) {
      final separatedChildren = <Widget>[];
      for (int i = 0; i < children.length; i++) {
        separatedChildren.add(children[i]);
        if (i < children.length - 1) {
          separatedChildren.add(separator!);
        }
      }
      listWidget = ListView(
        scrollDirection: scrollDirection,
        shrinkWrap: shrinkWrap,
        physics: physics,
        controller: controller,
        primary: primary,
        children: separatedChildren,
      );
    } else {
      listWidget = ListView(
        scrollDirection: scrollDirection,
        shrinkWrap: shrinkWrap,
        physics: physics,
        controller: controller,
        primary: primary,
        itemExtent: itemExtent,
        children: children,
      );
    }

    if (padding != null ||
        backgroundColor != null ||
        borderRadius != null ||
        parsedStyles.isNotEmpty) {
      listWidget = Container(
        padding: padding ?? parsedStyles['padding'],
        decoration: BoxDecoration(
          color: backgroundColor ?? parsedStyles['backgroundColor'],
          borderRadius: borderRadius ?? parsedStyles['borderRadius'],
        ),
        child: listWidget,
      );
    }

    return listWidget;
  }
}

/// Wind样式的列表项组件
class WListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final String? className;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? hoverColor;
  final Color? splashColor;
  final BorderRadius? borderRadius;
  final bool enabled;
  final bool selected;
  final Color? selectedColor;

  const WListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.className,
    this.onTap,
    this.padding,
    this.backgroundColor,
    this.hoverColor,
    this.splashColor,
    this.borderRadius,
    this.enabled = true,
    this.selected = false,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'ListTile',
      context,
    );

    return Container(
      decoration: BoxDecoration(
        color: selected
            ? (selectedColor ?? parsedStyles['selectedColor'] ?? wColor('primary-50'))
            : (backgroundColor ?? parsedStyles['backgroundColor']),
        borderRadius: borderRadius ?? parsedStyles['borderRadius'],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onTap : null,
          hoverColor: hoverColor ?? parsedStyles['hoverColor'],
          splashColor: splashColor ?? parsedStyles['splashColor'],
          borderRadius: borderRadius ?? parsedStyles['borderRadius'],
          child: Padding(
            padding: padding ?? parsedStyles['padding'] ?? EdgeInsets.symmetric(
              horizontal: wSpacing('4'),
              vertical: wSpacing('3'),
            ),
            child: Row(
              children: [
                if (leading != null) ...[leading!, SizedBox(width: wSpacing('3'))],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null) title!,
                      if (subtitle != null) ...[SizedBox(height: wSpacing('1')), subtitle!],
                    ],
                  ),
                ),
                if (trailing != null) ...[SizedBox(width: wSpacing('3')), trailing!],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== 功能组件 ====================

/// Wind样式的应用栏组件
class WAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final String? className;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final List<BoxShadow>? boxShadow;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool centerTitle;
  final double? titleSpacing;
  final double? toolbarOpacity;
  final double? bottomOpacity;

  const WAppBar({
    super.key,
    this.title,
    this.className,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.boxShadow,
    this.height,
    this.padding,
    this.centerTitle = true,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'AppBar',
      context,
    );

    return Container(
      height: preferredSize.height,
      padding: padding ?? parsedStyles['padding'],
      decoration: BoxDecoration(
        color: backgroundColor ?? parsedStyles['backgroundColor'] ?? wColor('primary'),
        boxShadow: boxShadow ?? parsedStyles['boxShadow'] ?? [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (leading != null)
              leading!
            else if (automaticallyImplyLeading && Navigator.canPop(context))
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: foregroundColor ?? parsedStyles['foregroundColor'] ?? wColor('white'),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            if (title != null) ...[
              if (centerTitle == true) const Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  color: foregroundColor ?? parsedStyles['foregroundColor'] ?? wColor('white'),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                child: title!,
              ),
              if (centerTitle == true) const Spacer(),
            ],
            if (centerTitle != true) const Spacer(),
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}

/// Wind样式的徽章组件
class WBadge extends StatelessWidget {
  final Widget child;
  final String? text;
  final int? count;
  final String? className;
  final Color? backgroundColor;
  final Color? textColor;
  final double? size;
  final bool showZero;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final AlignmentGeometry alignment;
  final Offset? offset;

  const WBadge({
    super.key,
    required this.child,
    this.text,
    this.count,
    this.className,
    this.backgroundColor,
    this.textColor,
    this.size,
    this.showZero = false,
    this.padding,
    this.borderRadius,
    this.alignment = Alignment.topRight,
    this.offset,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'Badge',
      context,
    );

    final shouldShow = (count != null && (count! > 0 || showZero)) || text != null;
    final displayText = text ?? (count != null ? count.toString() : '');

    if (!shouldShow) {
      return child;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: offset?.dy ?? -8,
          right: offset?.dx ?? -8,
          child: Container(
            padding: padding ?? parsedStyles['padding'] ?? EdgeInsets.symmetric(
              horizontal: wSpacing('2'),
              vertical: wSpacing('1'),
            ),
            decoration: BoxDecoration(
              color: backgroundColor ?? parsedStyles['backgroundColor'] ?? wColor('red-500'),
              borderRadius: borderRadius ?? parsedStyles['borderRadius'] ?? BorderRadius.circular(wBorderRadius('full')),
            ),
            constraints: BoxConstraints(
              minWidth: size ?? parsedStyles['size'] ?? 20,
              minHeight: size ?? parsedStyles['size'] ?? 20,
            ),
            child: Center(
              child: Text(
                displayText,
                style: TextStyle(
                  color: textColor ?? parsedStyles['textColor'] ?? wColor('white'),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Wind样式的对话框组件
class WDialog extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? className;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final bool barrierDismissible;
  final Color? barrierColor;
  final List<Widget>? actions;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;

  const WDialog({
    super.key,
    required this.child,
    this.title,
    this.className,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.barrierDismissible = true,
    this.barrierColor,
    this.actions,
    this.width,
    this.height,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final parsedStyles = UniversalStyleParser.parseClassName(
      className ?? '', 'Dialog',
      context,
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: width ?? parsedStyles['width'],
        height: height ?? parsedStyles['height'],
        padding: padding ?? parsedStyles['padding'] ?? EdgeInsets.all(wSpacing('6')),
        decoration: BoxDecoration(
          color: backgroundColor ?? parsedStyles['backgroundColor'] ?? wColor('white'),
          borderRadius: borderRadius ?? parsedStyles['borderRadius'] ?? BorderRadius.circular(wBorderRadius('lg')),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: wColor('gray-900'),
                ),
              ),
              SizedBox(height: wSpacing('4')),
            ],
            Flexible(child: child),
            if (actions != null) ...[
              SizedBox(height: wSpacing('4')),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!,
              ),
            ],
          ],
        ),
      ),
    );
  }


  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    String? className,
    bool barrierDismissible = true,
    List<Widget>? actions,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => WDialog(
        title: title,
        className: className,
        barrierDismissible: barrierDismissible,
        actions: actions,
        child: child,
      ),
    );
  }
}
