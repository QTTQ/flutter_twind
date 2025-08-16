/// Flutter TailwindCSS-like Components Library
///
/// A Flutter package that provides TailwindCSS-like utility components for rapid UI development.
/// 
/// This library includes:
/// - Layout components (WContainer, WFlex, WRow, WColumn, WStack, WPositioned)
/// - Visual components (WCard, WText, WIcon, WImage, WAvatar, WDivider)
/// - Interactive components (WButton, WInput)
/// - List components (WList, WListTile)
/// - Utility components (WAppBar, WBadge, WDialog)
/// - Configuration utilities (WindConfig, UniversalStyleParser)
///
/// ## Quick Start
///
/// ```dart
/// import 'package:flutter_twind/flutter_twind.dart';
///
/// void main() {
///   // Initialize WindConfig before runApp
///   WindConfig.initialize();
///   runApp(MyApp());
/// }
/// ```
///
/// ## Basic Usage
///
/// ```dart
/// WContainer(
///   className: 'p-4 bg-white rounded-lg shadow-md',
///   child: WText(
///     'Hello World',
///     className: 'text-lg font-bold text-gray-900',
///   ),
/// )
/// ```
library flutter_twind;

export 'wind_components.dart';
export 'utils/wind_config.dart';
export 'utils/universal_style_parser.dart';
