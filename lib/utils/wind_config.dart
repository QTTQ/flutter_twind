import 'package:flutter/material.dart';

/// Wind UI library configuration class.
///
/// This class provides centralized configuration for the Wind UI library,
/// including colors, spacing, border radius, and shadows.
class Wind {
  static Map<String, Color> _colors = {};
  static Map<String, double> _spacing = {};
  static Map<String, double> _borderRadius = {};
  static Map<String, List<BoxShadow>> _shadows = {};

  /// Initialize Wind configuration with custom settings.
  ///
  /// [breakpoints] - Screen size breakpoints for responsive design
  /// [colors] - Color palette for the theme
  /// [spacing] - Spacing scale for margins and padding
  /// [borderRadius] - Border radius scale for rounded corners
  /// [shadows] - Box shadow definitions
  static void initialize({
    required Map<String, int> breakpoints,
    required Map<String, Color> colors,
    required Map<String, double> spacing,
    required Map<String, double> borderRadius,
    required Map<String, List<BoxShadow>> shadows,
  }) {
    _colors = colors;
    _spacing = spacing;
    _borderRadius = borderRadius;
    _shadows = shadows;
  }

  /// Get a color by name from the configured color palette.
  ///
  /// Returns the color if found, otherwise returns null.
  static Color? getColor(String name) => _colors[name];
  static double? getSpacing(String name) => _spacing[name];
  static double? getBorderRadius(String name) => _borderRadius[name];
  static List<BoxShadow>? getShadow(String name) => _shadows[name];
}

/// Wind UI configuration helper class.
///
/// Provides a convenient way to initialize Wind UI with default settings.
/// This class sets up the complete design system including colors, spacing,
/// border radius, and shadows that can be used throughout your application.
///
/// ## Usage
///
/// Call [initialize] once in your app's main function before runApp():
///
/// ```dart
/// void main() {
///   WindConfig.initialize();
///   runApp(MyApp());
/// }
/// ```
///
/// ## Default Configuration
///
/// The default configuration includes:
/// - **Colors**: Primary, secondary, gray scale, and semantic colors
/// - **Spacing**: Scale from 0 to 64 (0, 1, 2, 4, 6, 8, 10, 12, 16, 20, 24, 32, 40, 48, 56, 64)
/// - **Border Radius**: sm, md, lg, xl, 2xl, 3xl, full
/// - **Shadows**: sm, md, lg, xl, 2xl
/// - **Breakpoints**: sm (640px), md (768px), lg (1024px), xl (1280px), 2xl (1536px)
///
/// ## Color Palette
///
/// ### Primary Colors
/// - `primary-50` to `primary-900`: Blue color scale
/// - `secondary-50` to `secondary-900`: Coral red color scale
/// - `gray-50` to `gray-900`: Neutral gray scale
///
/// ### Semantic Colors
/// - `success`: Green for success states
/// - `warning`: Orange for warning states
/// - `error`: Red for error states
/// - `info`: Blue for informational states
///
/// ### Basic Colors
/// - `white`, `black`: Pure white and black
/// - `transparent`: Fully transparent
class WindConfig {
  /// Initialize Wind UI with default configuration.
  ///
  /// This method sets up the default theme including:
  /// - Color palette with primary, secondary, and utility colors
  /// - Spacing scale from 0 to 64
  /// - Border radius options (sm, md, lg, xl, 2xl, 3xl, full)
  /// - Box shadow definitions (sm, md, lg, xl, 2xl)
  /// - Responsive breakpoints (sm, md, lg, xl, 2xl)
  ///
  /// **Important**: Call this method once in your app's main function before runApp().
  ///
  /// ```dart
  /// void main() {
  ///   WindConfig.initialize();
  ///   runApp(MyApp());
  /// }
  /// ```
  ///
  /// After initialization, you can use utility classes in your components:
  ///
  /// ```dart
  /// WContainer(
  ///   className: 'p-4 bg-primary-500 rounded-lg shadow-md',
  ///   child: WText(
  ///     'Styled with WindConfig',
  ///     className: 'text-white font-semibold',
  ///   ),
  /// )
  /// ```
  static void initialize() {
    // 初始化Wind配置
    Wind.initialize(
      breakpoints: {'sm': 640, 'md': 768, 'lg': 1024, 'xl': 1280, '2xl': 1536},
      colors: {
        // 主色调
        'primary': const Color(0xFF007AFF),
        'primary-50': const Color(0xFFE6F3FF),
        'primary-100': const Color(0xFFCCE7FF),
        'primary-200': const Color(0xFF99CFFF),
        'primary-300': const Color(0xFF66B7FF),
        'primary-400': const Color(0xFF339FFF),
        'primary-500': const Color(0xFF007AFF),
        'primary-600': const Color(0xFF0062CC),
        'primary-700': const Color(0xFF004999),
        'primary-800': const Color(0xFF003166),
        'primary-900': const Color(0xFF001833),

        // 次要色调 - 珊瑚红
        'secondary': const Color(0xFFFF6B6B),
        'secondary-50': const Color(0xFFFFEBEB),
        'secondary-100': const Color(0xFFFFD6D6),
        'secondary-200': const Color(0xFFFFADAD),
        'secondary-300': const Color(0xFFFF8585),
        'secondary-400': const Color(0xFFFF6B6B),
        'secondary-500': const Color(0xFFFF5252),
        'secondary-600': const Color(0xFFE53E3E),
        'secondary-700': const Color(0xFFCC2B2B),
        'secondary-800': const Color(0xFFB21919),
        'secondary-900': const Color(0xFF990606),

        // 灰色系
        'gray-50': const Color(0xFFF9FAFB),
        'gray-100': const Color(0xFFF3F4F6).withValues(alpha: 0.8),
        'gray-200': const Color(0xFFE5E7EB).withValues(alpha: 0.9),
        'gray-300': const Color(0xFFD1D5DB).withValues(alpha: 0.95),
        'gray-400': const Color(0xFF9CA3AF).withValues(alpha: 1.0),
        'gray-500': const Color(0xFF6B7280),
        'gray-600': const Color(0xFF4B5563),
        'gray-700': const Color(0xFF374151),
        'gray-800': const Color(0xFF1F2937),
        'gray-900': const Color(0xFF111827),

        // 功能色
        'success': const Color(0xFF10B981),
        'warning': const Color(0xFFF59E0B),
        'error': const Color(0xFFEF4444),
        'info': const Color(0xFF3B82F6),

        // 添加完整的蓝色系
        'blue': const Color(0xFF3B82F6),
        'blue-50': const Color(0xFFEFF6FF),
        'blue-100': const Color(0xFFDBEAFE),
        'blue-200': const Color(0xFFBFDBFE),
        'blue-300': const Color(0xFF93C5FD),
        'blue-400': const Color(0xFF60A5FA),
        'blue-500': const Color(0xFF3B82F6),
        'blue-600': const Color(0xFF2563EB),
        'blue-700': const Color(0xFF1D4ED8),
        'blue-800': const Color(0xFF1E40AF),
        'blue-900': const Color(0xFF1E3A8A),

        // 添加完整的红色系
        'red': const Color(0xFFEF4444),
        'red-50': const Color(0xFFFEF2F2),
        'red-100': const Color(0xFFFEE2E2),
        'red-200': const Color(0xFFFECACA),
        'red-300': const Color(0xFFFCA5A5),
        'red-400': const Color(0xFFF87171),
        'red-500': const Color(0xFFEF4444),
        'red-600': const Color(0xFFDC2626),
        'red-700': const Color(0xFFB91C1C),
        'red-800': const Color(0xFF991B1B),
        'red-900': const Color(0xFF7F1D1D),

        // 添加完整的绿色系
        'green': const Color(0xFF10B981),
        'green-50': const Color(0xFFECFDF5),
        'green-100': const Color(0xFFD1FAE5),
        'green-200': const Color(0xFFA7F3D0),
        'green-300': const Color(0xFF6EE7B7),
        'green-400': const Color(0xFF34D399),
        'green-500': const Color(0xFF10B981),
        'green-600': const Color(0xFF059669),
        'green-700': const Color(0xFF047857),
        'green-800': const Color(0xFF065F46),
        'green-900': const Color(0xFF064E3B),

        // 背景色
        'white': const Color(0xFFFFFFFF),
        'black': const Color(0xFF000000),
        'transparent': Colors.transparent,
      },
      spacing: {
        '0': 0.0,
        '1': 4.0,
        '2': 8.0,
        '3': 12.0,
        '4': 16.0,
        '5': 20.0,
        '6': 24.0,
        '8': 32.0,
        '10': 40.0,
        '12': 48.0,
        '16': 64.0,
        '20': 80.0,
        '24': 96.0,
        '32': 128.0,
        '40': 160.0,
        '48': 192.0,
        '56': 224.0,
        '64': 256.0,
      },
      borderRadius: {
        'none': 0.0,
        'sm': 2.0,
        'md': 6.0,
        'lg': 8.0,
        'xl': 12.0,
        '2xl': 16.0,
        '3xl': 24.0,
        'full': 9999.0,
      },
      shadows: {
        'sm': [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
        'md': [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
        'lg': [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
        'xl': [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 25,
            offset: const Offset(0, 20),
          ),
        ],
      },
    );
  }
}

/// Wind颜色工具函数
Color wColor(String colorName) {
  return Wind.getColor(colorName) ?? Colors.transparent;
}

/// Wind间距工具函数
double wSpacing(String spacingName) {
  return Wind.getSpacing(spacingName) ?? 0.0;
}

/// Wind圆角工具函数
double wBorderRadius(String radiusName) {
  return Wind.getBorderRadius(radiusName) ?? 0.0;
}

/// Wind阴影工具函数
List<BoxShadow> wShadow(String shadowName) {
  return Wind.getShadow(shadowName) ?? [];
}
