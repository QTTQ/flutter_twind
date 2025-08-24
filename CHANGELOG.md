# Changelog

## [0.4.0] - 2025-08-24

### Fixed
- **Critical Layout Constraint Issues**: Fixed `BoxConstraints forces an infinite height` error
  - Fixed `WStack` component layout problems with infinite height constraints
  - Fixed `WContainer` component constraint handling using LayoutBuilder
  - Fixed `WImage` component sizing issues in Stack layouts
  - Fixed `semantics.parentDataDirty` assertion failures
- **Enhanced Constraint Safety**: All layout components now use LayoutBuilder for safe constraint handling
- **Improved Stack Layouts**: WStack now properly handles nested containers and images
- **Better Error Prevention**: Added comprehensive constraint validation to prevent layout crashes

### Added
- **Constraint Fix Guide**: Complete documentation for layout constraint best practices
- **Safety Examples**: Added `constraint_fix_example.dart` with safe usage patterns
- **Layout Debugging**: Enhanced constraint debugging capabilities

### Enhanced
- **Component Stability**: All W components now handle edge cases more gracefully
- **Performance**: Optimized constraint calculations for better rendering performance
- **Developer Experience**: Better error messages and debugging information

## [0.3.6] - 2024-12-22

### Added
- **Custom Color Schemes**: Added support for custom brand and accent color schemes
  - Brand colors: `brand-50` to `brand-900` - Custom brand color palette
  - Accent colors: `accent-50` to `accent-900` - Custom accent color palette
  - Full transparency modifier support: `bg-brand-500/20`, `border-accent-400/50`
- **Enhanced Documentation**: Added custom color scheme examples and screenshots
- **Demo Application**: Updated demo to showcase custom color schemes with transparency

### Enhanced
- **WindConfig**: Extended color configuration to include custom color definitions
- **Color Parser**: Improved support for custom color scheme parsing
- **Demo Coverage**: Complete test coverage for all custom color variations

### Fixed
- Custom color schemes not displaying in demo application
- Missing color definitions in WindConfig for brand and accent colors

## [0.3.5] - 2024-12-22

### Added
- **Arbitrary Value Support**: Full support for Tailwind CSS arbitrary values
  - Colors: `bg-[#ff0000]`, `text-[rgb(255,0,0)]`, `border-[hsl(0,100%,50%)]`
  - Sizes: `w-[200px]`, `h-[50px]`, `p-[1rem]`, `m-[2em]`
  - Opacity: `opacity-[0.6]`
- **Extended Color Palette**: Added missing color series
  - Purple: `purple-50` to `purple-900`
  - Yellow: `yellow-50` to `yellow-900`
  - Orange: `orange-50` to `orange-900`
  - Pink: `pink-50` to `pink-900`
  - Indigo: `indigo-50` to `indigo-900`
  - Teal: `teal-50` to `teal-900`
  - Cyan: `cyan-50` to `cyan-900`
  - Lime: `lime-50` to `lime-900`
  - Rose: `rose-50` to `rose-900`
  - Emerald: `emerald-50` to `emerald-900`
- **Gap Support**: Implemented gap spacing for WColumn and WRow components
  - Predefined gaps: `gap-1`, `gap-2`, `gap-4`, `gap-6`, `gap-8`
  - Arbitrary gaps: `gap-[30px]`, `gap-[2rem]`
- **Enhanced Border Support**: 
  - Border widths: `border`, `border-2`, `border-4`, `border-8`
  - Arbitrary border colors: `border-[#ff0000]`
- **Text Decoration Support**:
  - Decorations: `underline`, `line-through`, `no-underline`
  - Text transform: `uppercase`, `lowercase`, `capitalize`
  - Text overflow: `overflow-ellipsis`, `line-clamp-2`
- **Opacity Support**: 
  - Predefined: `opacity-0`, `opacity-25`, `opacity-50`, `opacity-75`, `opacity-100`
  - Arbitrary: `opacity-[0.6]`
- **Comprehensive Test Suite**: Complete demo app with all features tested

### Enhanced
- **Color Parser**: Improved arbitrary value parsing for all color formats
- **Size Parser**: Enhanced support for px, rem, em units in arbitrary values
- **Hot Reload**: Better hot reload support for all new features
- **Component System**: WColumn and WRow now properly handle gap spacing

### Fixed
- Color parsing issues with extended color palette
- Gap spacing not working in layout components
- Arbitrary value parsing edge cases
- Hot reload consistency across all features

### Changed
- Optimized style parsing performance for arbitrary values
- Better error handling for invalid arbitrary values
- Improved component rendering with gap support

## [0.3.3] - 2025-08-20

### Added
- Support for TailwindCSS-style border radius values: `sm`, `md`, `lg`, `xl`, `2xl`, `3xl`

### Fixed
- Fixed issue where named border radius styles like `rounded-2xl` were not working
- Improved border radius parsing logic to ensure all TailwindCSS-style border radius values work properly


## [0.3.0] - 2025-08-20

### Added
- HSL color support
- HSL color parser
- HSL color formatter

### Fixed
- Fixed HSL color parser not working with alpha values
- Fixed HSL color formatter not working with alpha values

## [0.2.8] - 2025-08-20

### Added
- Complete TailwindCSS-like style parser
- Flexbox layout support (`flex`, `justify-center`, `items-center`)
- Text alignment support (`text-center`, `text-left`, `text-right`)
- Comprehensive color system
- Border, border-radius, and shadow styles
- Responsive design support

### Fixed
- Fixed `text-center` style not working in certain containers
- Fixed `WContainer` component Flexbox layout support
- Fixed `WText` component text alignment issues
- Removed unused `_isColor` method
- Updated deprecated `withOpacity` to `withValues` for better precision

### Improved
- Optimized style parsing performance
- Enhanced type safety for components
- Improved documentation and examples

## [0.1.0] - 2025-08-19

### Added
- Basic Wind UI component library
- TailwindCSS-style styling system
- Core layout and visual components
