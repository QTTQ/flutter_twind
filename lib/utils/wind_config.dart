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
        'gray': const Color(0xFF6B7280),
        'gray-50': const Color(0xFFF9FAFB),
        'gray-100': const Color(0xFFF3F4F6),
        'gray-200': const Color(0xFFE5E7EB),
        'gray-300': const Color(0xFFD1D5DB),
        'gray-400': const Color(0xFF9CA3AF),
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

        // 添加完整的紫色系
        'purple': const Color(0xFF8B5CF6),
        'purple-50': const Color(0xFFFAF5FF),
        'purple-100': const Color(0xFFF3E8FF),
        'purple-200': const Color(0xFFE9D5FF),
        'purple-300': const Color(0xFFD8B4FE),
        'purple-400': const Color(0xFFC084FC),
        'purple-500': const Color(0xFFA855F7),
        'purple-600': const Color(0xFF9333EA),
        'purple-700': const Color(0xFF7C3AED),
        'purple-800': const Color(0xFF6B21A8),
        'purple-900': const Color(0xFF581C87),

        // 添加完整的黄色系
        'yellow': const Color(0xFFF59E0B),
        'yellow-50': const Color(0xFFFFFBEB),
        'yellow-100': const Color(0xFFFEF3C7),
        'yellow-200': const Color(0xFFFDE68A),
        'yellow-300': const Color(0xFFFCD34D),
        'yellow-400': const Color(0xFFFBBF24),
        'yellow-500': const Color(0xFFF59E0B),
        'yellow-600': const Color(0xFFD97706),
        'yellow-700': const Color(0xFFB45309),
        'yellow-800': const Color(0xFF92400E),
        'yellow-900': const Color(0xFF78350F),

        // 添加完整的橙色系
        'orange': const Color(0xFFF97316),
        'orange-50': const Color(0xFFFFF7ED),
        'orange-100': const Color(0xFFFFEDD5),
        'orange-200': const Color(0xFFFED7AA),
        'orange-300': const Color(0xFFFDBA74),
        'orange-400': const Color(0xFFFB923C),
        'orange-500': const Color(0xFFF97316),
        'orange-600': const Color(0xFFEA580C),
        'orange-700': const Color(0xFFC2410C),
        'orange-800': const Color(0xFF9A3412),
        'orange-900': const Color(0xFF7C2D12),

        // 添加完整的粉色系
        'pink': const Color(0xFFEC4899),
        'pink-50': const Color(0xFFFDF2F8),
        'pink-100': const Color(0xFFFCE7F3),
        'pink-200': const Color(0xFFFBCFE8),
        'pink-300': const Color(0xFFF9A8D4),
        'pink-400': const Color(0xFFF472B6),
        'pink-500': const Color(0xFFEC4899),
        'pink-600': const Color(0xFFDB2777),
        'pink-700': const Color(0xFFBE185D),
        'pink-800': const Color(0xFF9D174D),
        'pink-900': const Color(0xFF831843),

        // 添加完整的靛蓝色系
        'indigo': const Color(0xFF6366F1),
        'indigo-50': const Color(0xFFEEF2FF),
        'indigo-100': const Color(0xFFE0E7FF),
        'indigo-200': const Color(0xFFC7D2FE),
        'indigo-300': const Color(0xFFA5B4FC),
        'indigo-400': const Color(0xFF818CF8),
        'indigo-500': const Color(0xFF6366F1),
        'indigo-600': const Color(0xFF4F46E5),
        'indigo-700': const Color(0xFF4338CA),
        'indigo-800': const Color(0xFF3730A3),
        'indigo-900': const Color(0xFF312E81),

        // 添加完整的青色系
        'teal': const Color(0xFF14B8A6),
        'teal-50': const Color(0xFFF0FDFA),
        'teal-100': const Color(0xFFCCFBF1),
        'teal-200': const Color(0xFF99F6E4),
        'teal-300': const Color(0xFF5EEAD4),
        'teal-400': const Color(0xFF2DD4BF),
        'teal-500': const Color(0xFF14B8A6),
        'teal-600': const Color(0xFF0D9488),
        'teal-700': const Color(0xFF0F766E),
        'teal-800': const Color(0xFF115E59),
        'teal-900': const Color(0xFF134E4A),

        // 添加完整的青蓝色系
        'cyan': const Color(0xFF06B6D4),
        'cyan-50': const Color(0xFFECFEFF),
        'cyan-100': const Color(0xFFCFFAFE),
        'cyan-200': const Color(0xFFA5F3FC),
        'cyan-300': const Color(0xFF67E8F9),
        'cyan-400': const Color(0xFF22D3EE),
        'cyan-500': const Color(0xFF06B6D4),
        'cyan-600': const Color(0xFF0891B2),
        'cyan-700': const Color(0xFF0E7490),
        'cyan-800': const Color(0xFF155E75),
        'cyan-900': const Color(0xFF164E63),

        // 添加完整的酸橙色系
        'lime': const Color(0xFF84CC16),
        'lime-50': const Color(0xFFF7FEE7),
        'lime-100': const Color(0xFFECFCCB),
        'lime-200': const Color(0xFFD9F99D),
        'lime-300': const Color(0xFFBEF264),
        'lime-400': const Color(0xFFA3E635),
        'lime-500': const Color(0xFF84CC16),
        'lime-600': const Color(0xFF65A30D),
        'lime-700': const Color(0xFF4D7C0F),
        'lime-800': const Color(0xFF365314),
        'lime-900': const Color(0xFF1A2E05),

        // 添加完整的玫瑰色系
        'rose': const Color(0xFFF43F5E),
        'rose-50': const Color(0xFFFFF1F2),
        'rose-100': const Color(0xFFFFE4E6),
        'rose-200': const Color(0xFFFECDD3),
        'rose-300': const Color(0xFFFDA4AF),
        'rose-400': const Color(0xFFFB7185),
        'rose-500': const Color(0xFFF43F5E),
        'rose-600': const Color(0xFFE11D48),
        'rose-700': const Color(0xFFBE123C),
        'rose-800': const Color(0xFF9F1239),
        'rose-900': const Color(0xFF881337),

        // 添加完整的翡翠色系
        'emerald': const Color(0xFF10B981),
        'emerald-50': const Color(0xFFECFDF5),
        'emerald-100': const Color(0xFFD1FAE5),
        'emerald-200': const Color(0xFFA7F3D0),
        'emerald-300': const Color(0xFF6EE7B7),
        'emerald-400': const Color(0xFF34D399),
        'emerald-500': const Color(0xFF10B981),
        'emerald-600': const Color(0xFF059669),
        'emerald-700': const Color(0xFF047857),
        'emerald-800': const Color(0xFF065F46),
        'emerald-900': const Color(0xFF064E3B),

        // 自定义品牌色系
        'brand': const Color(0xFF6366F1),
        'brand-50': const Color(0xFFEEF2FF),
        'brand-100': const Color(0xFFE0E7FF),
        'brand-200': const Color(0xFFC7D2FE),
        'brand-300': const Color(0xFFA5B4FC),
        'brand-400': const Color(0xFF818CF8),
        'brand-500': const Color(0xFF6366F1),
        'brand-600': const Color(0xFF4F46E5),
        'brand-700': const Color(0xFF4338CA),
        'brand-800': const Color(0xFF3730A3),
        'brand-900': const Color(0xFF312E81),

        // 自定义强调色系
        'accent': const Color(0xFFEC4899),
        'accent-50': const Color(0xFFFDF2F8),
        'accent-100': const Color(0xFFFCE7F3),
        'accent-200': const Color(0xFFFBCFE8),
        'accent-300': const Color(0xFFF9A8D4),
        'accent-400': const Color(0xFFF472B6),
        'accent-500': const Color(0xFFEC4899),
        'accent-600': const Color(0xFFDB2777),
        'accent-700': const Color(0xFFBE185D),
        'accent-800': const Color(0xFF9D174D),
        'accent-900': const Color(0xFF831843),

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
