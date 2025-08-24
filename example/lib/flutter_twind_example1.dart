import 'package:flutter/material.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  // 初始化WindConfig
  WindConfig.initialize();

  // 初始化SmartStyleParser，添加自定义色系
  // SmartStyleParser.initialize(customColors: {
  //   'brand': {
  //     '50': const Color(0xFFF0F9FF),
  //     '100': const Color(0xFFE0F2FE),
  //     '200': const Color(0xFFBAE6FD),
  //     '300': const Color(0xFF7DD3FC),
  //     '400': const Color(0xFF38BDF8),
  //     '500': const Color(0xFF0EA5E9),
  //     '600': const Color(0xFF0284C7),
  //     '700': const Color(0xFF0369A1),
  //     '800': const Color(0xFF075985),
  //     '900': const Color(0xFF0C4A6E),
  //   },
  //   'accent': {
  //     '50': const Color(0xFFFDF2F8),
  //     '100': const Color(0xFFFCE7F3),
  //     '200': const Color(0xFFFBCFE8),
  //     '300': const Color(0xFFF9A8D4),
  //     '400': const Color(0xFFF472B6),
  //     '500': const Color(0xFFEC4899),
  //     '600': const Color(0xFFDB2777),
  //     '700': const Color(0xFFBE185D),
  //     '800': const Color(0xFF9D174D),
  //     '900': const Color(0xFF831843),
  //   },
  // });

  SmartStyleParser.initialize();

  runApp(const FlutterTwindCompleteTestApp());
}

class FlutterTwindCompleteTestApp extends StatelessWidget {
  const FlutterTwindCompleteTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Twind 完整测试',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CompleteTestPage(),
    );
  }
}

class CompleteTestPage extends StatefulWidget {
  const CompleteTestPage({super.key});

  @override
  State<CompleteTestPage> createState() => _CompleteTestPageState();
}

class _CompleteTestPageState extends State<CompleteTestPage> {
  int _counter = 0;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WAppBar(
        title: WText(
          'Flutter Twind 完整测试',
          className: 'text-white font-bold text-lg',
        ),
        className: 'bg-blue-600',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: WColumn(
          className: 'gap-6',
          children: [
            // 热重载说明
            _buildSection(
              '🔥 热重载测试说明',
              [
                const WText(
                  '修改任何组件的 className 属性，然后按 "r" 键测试热重载',
                  className: 'text-gray-600 text-center',
                ),
              ],
            ),

            // 颜色测试 - 所有颜色系统
            _buildSection(
              '🎨 颜色系统测试',
              [
                const WText('🆕 透明度修饰符测试 (NEW!)',
                    className: 'font-bold mb-4 text-purple-600'),
                const WText('基础颜色 + 透明度', className: 'font-semibold mb-2'),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-yellow/10 border', 'yellow/10'),
                    _colorBox('bg-yellow/30 border', 'yellow/30'),
                    _colorBox('bg-yellow/50 border', 'yellow/50'),
                    _colorBox('bg-yellow/70 border', 'yellow/70'),
                    _colorBox('bg-yellow/90 border', 'yellow/90'),
                  ],
                ),
                const SizedBox(height: 8),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-black/10', 'black/10'),
                    _colorBox('bg-black/30', 'black/30'),
                    _colorBox('bg-black/50', 'black/50'),
                    _colorBox('bg-black/70', 'black/70'),
                    _colorBox('bg-black/90', 'black/90'),
                  ],
                ),
                const SizedBox(height: 8),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-red-500/20', 'red-500/20'),
                    _colorBox('bg-blue-500/40', 'blue-500/40'),
                    _colorBox('bg-green-500/60', 'green-500/60'),
                    _colorBox('bg-purple-500/80', 'purple-500/80'),
                  ],
                ),
                const SizedBox(height: 16),
                const WText('🆕 自定义色系测试 (NEW!)',
                    className: 'font-bold mb-4 text-purple-600'),
                const WText('Brand 色系', className: 'font-semibold mb-2'),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-brand-100', 'brand-100'),
                    _colorBox('bg-brand-300', 'brand-300'),
                    _colorBox('bg-brand-500', 'brand-500'),
                    _colorBox('bg-brand-700', 'brand-700'),
                    _colorBox('bg-brand-900', 'brand-900'),
                  ],
                ),
                const SizedBox(height: 8),
                const WText('Accent 色系', className: 'font-semibold mb-2'),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-accent-100', 'accent-100'),
                    _colorBox('bg-accent-300', 'accent-300'),
                    _colorBox('bg-accent-500', 'accent-500'),
                    _colorBox('bg-accent-700', 'accent-700'),
                    _colorBox('bg-accent-900', 'accent-900'),
                  ],
                ),
                const SizedBox(height: 8),
                const WText('自定义色系 + 透明度', className: 'font-semibold mb-2'),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-brand-500/20', 'brand-500/20'),
                    _colorBox('bg-brand-500/50', 'brand-500/50'),
                    _colorBox('bg-accent-500/30', 'accent-500/30'),
                    _colorBox('bg-accent-500/70', 'accent-500/70'),
                  ],
                ),
                const SizedBox(height: 16),
                const WText('主色系 (Primary)', className: 'font-semibold mb-2'),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-primary-100', 'primary-100'),
                    _colorBox('bg-primary-300', 'primary-300'),
                    _colorBox('bg-primary-500', 'primary-500'),
                    _colorBox('bg-primary-700', 'primary-700'),
                    _colorBox('bg-primary-900', 'primary-900'),
                  ],
                ),
                const SizedBox(height: 12),
                const WText('蓝色系 (Blue)', className: 'font-semibold mb-2'),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-blue-100', 'blue-100'),
                    _colorBox('bg-blue-300', 'blue-300'),
                    _colorBox('bg-blue-500', 'blue-500'),
                    _colorBox('bg-blue-700', 'blue-700'),
                    _colorBox('bg-blue-900', 'blue-900'),
                  ],
                ),
                const SizedBox(height: 12),
                const WText('红色系 (Red)', className: 'font-semibold mb-2'),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-red-100', 'red-100'),
                    _colorBox('bg-red-300', 'red-300'),
                    _colorBox('bg-red-500', 'red-500'),
                    _colorBox('bg-red-700', 'red-700'),
                    _colorBox('bg-red-900', 'red-900'),
                  ],
                ),
                const SizedBox(height: 12),
                const WText('绿色系 (Green)', className: 'font-semibold mb-2'),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-green-100', 'green-100'),
                    _colorBox('bg-green-300', 'green-300'),
                    _colorBox('bg-green-500', 'green-500'),
                    _colorBox('bg-green-700', 'green-700'),
                    _colorBox('bg-green-900', 'green-900'),
                  ],
                ),
                const SizedBox(height: 12),
                const WText('灰色系 (Gray)', className: 'font-semibold mb-2'),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-gray-100', 'gray-100'),
                    _colorBox('bg-gray-300', 'gray-300'),
                    _colorBox('bg-gray-500', 'gray-500'),
                    _colorBox('bg-gray-700', 'gray-700'),
                    _colorBox('bg-gray-900', 'gray-900'),
                  ],
                ),
                const SizedBox(height: 12),
                const WText('基础颜色', className: 'font-semibold mb-2'),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-white border', 'white'),
                    _colorBox('bg-black', 'black'),
                    _colorBox('bg-transparent border', 'transparent'),
                  ],
                ),
                const SizedBox(height: 16),
                const WText('任意值颜色 (Arbitrary Values)',
                    className: 'font-semibold mb-2 text-purple-600'),
                const WText('十六进制颜色',
                    className: 'text-sm font-medium mb-2 text-gray-600'),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-[#00ff00]', '#00ff00'),
                    _colorBox('bg-[#4ecdc4]', '#4ecdc4'),
                    _colorBox('bg-[#45b7d1]', '#45b7d1'),
                    _colorBox('bg-[#f9ca24]', '#f9ca24'),
                    _colorBox('bg-[#6c5ce7]', '#6c5ce7'),
                  ],
                ),
                const SizedBox(height: 8),
                const WText('RGB 颜色',
                    className: 'text-sm font-medium mb-2 text-gray-600'),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-[rgb(255,107,107)]', 'rgb(255,107,107)'),
                    _colorBox('bg-[rgb(78,205,196)]', 'rgb(78,205,196)'),
                    _colorBox('bg-[rgb(69,183,209)]', 'rgb(69,183,209)'),
                  ],
                ),
                const SizedBox(height: 8),
                const WText('RGBA 半透明颜色',
                    className: 'text-sm font-medium mb-2 text-gray-600'),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-[rgba(255,107,107,0.5)] border',
                        'rgba(255,107,107,0.5)'),
                    _colorBox('bg-[rgba(78,205,196,0.7)] border',
                        'rgba(78,205,196,0.7)'),
                    _colorBox('bg-[rgba(108,92,231,0.3)] border',
                        'rgba(108,92,231,0.3)'),
                  ],
                ),
                const SizedBox(height: 8),
                const WText('HSL 颜色',
                    className: 'text-sm font-medium mb-2 text-gray-600'),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-[hsl(348,100%,61%)]', 'hsl(348,100%,61%)'),
                    _colorBox('bg-[hsl(174,64%,55%)]', 'hsl(174,64%,55%)'),
                    _colorBox('bg-[hsl(258,89%,66%)]', 'hsl(258,89%,66%)'),
                  ],
                ),
                const SizedBox(height: 8),
                const WText('HSLA 半透明颜色',
                    className: 'text-sm font-medium mb-2 text-gray-600'),
                WRow(
                  className: 'gap-2',
                  children: [
                    _colorBox('bg-[hsla(348,100%,61%,0.6)] border',
                        'hsla(348,100%,61%,0.6)'),
                    _colorBox('bg-[hsla(174,64%,55%,0.8)] border',
                        'hsla(174,64%,55%,0.8)'),
                    _colorBox('bg-[hsla(258,89%,66%,0.4)] border',
                        'hsla(258,89%,66%,0.4)'),
                  ],
                ),
              ],
            ),

            // 文字颜色测试
            _buildSection(
              '📝 文字颜色测试',
              [
                const WText('🆕 文字透明度测试 (NEW!)',
                    className: 'font-bold mb-4 text-purple-600'),
                const WText('黑色文字透明度变化', className: 'font-semibold mb-2'),
                const WText('黑色文字 100%',
                    className: 'text-black font-bold text-lg mb-1'),
                const WText('黑色文字 70%',
                    className: 'text-black/70 font-bold text-lg mb-1'),
                const WText('黑色文字 50%',
                    className: 'text-black/50 font-bold text-lg mb-1'),
                const WText('黑色文字 30%',
                    className: 'text-black/30 font-bold text-lg mb-1'),
                const WText('黑色文字 10%',
                    className: 'text-black/10 font-bold text-lg mb-4'),
                const WText('彩色文字透明度', className: 'font-semibold mb-2'),
                const WText('红色文字 red-500/80',
                    className: 'text-red-500/80 font-bold text-lg mb-1'),
                const WText('蓝色文字 blue-600/60',
                    className: 'text-blue-600/60 font-bold text-lg mb-1'),
                const WText('绿色文字 green-500/70',
                    className: 'text-green-500/70 font-bold text-lg mb-1'),
                const WText('紫色文字 purple-600/50',
                    className: 'text-purple-600/50 font-bold text-lg mb-4'),
                const WText('自定义色系文字', className: 'font-semibold mb-2'),
                const WText('Brand 色系文字',
                    className: 'text-brand-500 font-bold text-lg mb-1'),
                const WText('Brand 色系文字 50%',
                    className: 'text-brand-500/50 font-bold text-lg mb-1'),
                const WText('Accent 色系文字',
                    className: 'text-accent-500 font-bold text-lg mb-1'),
                const WText('Accent 色系文字 70%',
                    className: 'text-accent-500/70 font-bold text-lg mb-4'),
                const WText('传统文字颜色', className: 'font-semibold mb-2'),
                const WText('红色文字', className: 'text-red-500 font-bold'),
                const WText('蓝色文字', className: 'text-blue-600 font-semibold'),
                const WText('绿色文字', className: 'text-green-500 font-medium'),
                const WText('灰色文字', className: 'text-gray-700'),
                const WText('主色文字', className: 'text-primary font-bold'),
                const SizedBox(height: 12),
                const WText('任意值文字颜色',
                    className: 'font-semibold mb-2 text-purple-600'),
                const WText('十六进制文字颜色 #ff0000',
                    className: 'text-[#ff0000] font-bold'),
                const WText('RGB文字颜色 rgb(52,152,219)',
                    className: 'text-[rgb(52,152,219)] font-bold'),
                const WText('HSL文字颜色 hsl(142,71%,45%)',
                    className: 'text-[hsl(142,71%,45%)] font-bold'),
                const WText('RGBA半透明文字 rgba(155,89,182,0.8)',
                    className: 'text-[rgba(155,89,182,0.8)] font-bold text-lg'),
                const WText('深灰色文字 #333333',
                    className: 'text-[#333333] font-medium'),
              ],
            ),

            // 边框颜色任意值测试
            _buildSection(
              '🔲 边框颜色任意值测试',
              [
                const WText('任意值边框颜色',
                    className: 'font-semibold mb-4 text-purple-600'),
                WContainer(
                  className: 'p-4 border-2 border-[#00ff00] rounded-lg mb-3',
                  child: const WText('十六进制边框 #00ff00',
                      className: 'text-center font-medium'),
                ),
                WContainer(
                  className:
                      'p-4 border-2 border-[rgb(52,152,219)] rounded-lg mb-3',
                  child: const WText('RGB边框 rgb(52,152,219)',
                      className: 'text-center font-medium'),
                ),
                WContainer(
                  className:
                      'p-4 border-2 border-[hsl(142,71%,45%)] rounded-lg mb-3',
                  child: const WText('HSL边框 hsl(142,71%,45%)',
                      className: 'text-center font-medium'),
                ),
                WContainer(
                  className:
                      'p-4 border-2 border-[rgba(155,89,182,0.6)] rounded-lg mb-3',
                  child: const WText('RGBA半透明边框 rgba(155,89,182,0.6)',
                      className: 'text-center font-medium'),
                ),
                WContainer(
                  className: 'p-4 border-4 border-[#f39c12] rounded-xl',
                  child: const WText('粗边框 #f39c12',
                      className: 'text-center font-bold'),
                ),
              ],
            ),

            // 布局组件测试
            _buildSection(
              '📐 布局组件测试',
              [
                const WText('WContainer 容器', className: 'font-semibold mb-2'),
                WContainer(
                  className: 'p-4 bg-blue-100 rounded-lg border',
                  child: const WText(
                    '这是一个 WContainer 容器 - 尝试修改 bg-blue-100',
                    className: 'text-blue-700 text-center',
                  ),
                ),
                const SizedBox(height: 12),
                const WText('WRow 行布局', className: 'font-semibold mb-2'),
                WRow(
                  className: 'gap-4',
                  children: [
                    Expanded(
                      child: WContainer(
                        className: 'p-3 bg-red-100 rounded',
                        child: const WText('Item 1',
                            className: 'text-red-700 text-center'),
                      ),
                    ),
                    Expanded(
                      child: WContainer(
                        className: 'p-3 bg-green-100 rounded',
                        child: const WText('Item 2',
                            className: 'text-green-700 text-center'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const WText('WColumn 列布局', className: 'font-semibold mb-2'),
                WColumn(
                  children: [
                    WContainer(
                      className: 'p-2 bg-yellow-100 rounded mb-2',
                      child: const WText('Column Item 1',
                          className: 'text-yellow-700'),
                    ),
                    WContainer(
                      className: 'p-2 bg-purple-100 rounded',
                      child: const WText('Column Item 2',
                          className: 'text-purple-700'),
                    ),
                  ],
                ),
              ],
            ),

            // 文字组件测试
            _buildSection(
              '🔤 文字组件测试',
              [
                const WText('超小字体', className: 'text-xs text-gray-600'),
                const WText('小字体', className: 'text-sm text-gray-700'),
                const WText('基础字体', className: 'text-base text-gray-800'),
                const WText('大字体', className: 'text-lg text-gray-900'),
                const WText('超大字体', className: 'text-xl font-medium'),
                const WText('2倍大字体', className: 'text-2xl font-semibold'),
                const WText('3倍大字体', className: 'text-3xl font-bold'),
                const SizedBox(height: 8),
                const WText('左对齐文字', className: 'text-left text-blue-600'),
                const WText('居中对齐文字', className: 'text-center text-green-600'),
                const WText('右对齐文字', className: 'text-right text-red-600'),
              ],
            ),

            // 字体粗细测试
            _buildSection(
              '💪 字体粗细测试',
              [
                const WText('超细字体', className: 'font-thin text-lg'),
                const WText('细字体', className: 'font-light text-lg'),
                const WText('正常字体', className: 'font-normal text-lg'),
                const WText('中等字体', className: 'font-medium text-lg'),
                const WText('半粗字体', className: 'font-semibold text-lg'),
                const WText('粗字体', className: 'font-bold text-lg'),
                const WText('超粗字体', className: 'font-extrabold text-lg'),
                const WText('最粗字体', className: 'font-black text-lg'),
              ],
            ),

            // 间距测试
            _buildSection(
              '📏 间距测试',
              [
                const WText('预定义内边距测试', className: 'font-semibold mb-2'),
                WContainer(
                  className: 'p-1 bg-red-100 mb-2',
                  child: const WText('p-1 内边距', className: 'text-red-700'),
                ),
                WContainer(
                  className: 'p-2 bg-blue-100 mb-2',
                  child: const WText('p-2 内边距', className: 'text-blue-700'),
                ),
                WContainer(
                  className: 'p-4 bg-green-100 mb-2',
                  child: const WText('p-4 内边距', className: 'text-green-700'),
                ),
                WContainer(
                  className: 'p-6 bg-purple-100 mb-2',
                  child: const WText('p-6 内边距', className: 'text-purple-700'),
                ),
                WContainer(
                  className: 'p-8 bg-yellow-100 mb-4',
                  child: const WText('p-8 内边距', className: 'text-yellow-700'),
                ),
                const WText('任意值间距测试',
                    className: 'font-semibold mb-2 text-purple-600'),
                WContainer(
                  className: 'p-[10px] bg-orange-100 mb-2',
                  child: const WText('p-[10px] 任意值内边距',
                      className: 'text-orange-700'),
                ),
                WContainer(
                  className: 'p-[1.5rem] bg-pink-100 mb-2',
                  child: const WText('p-[1.5rem] rem单位内边距',
                      className: 'text-pink-700'),
                ),
                WContainer(
                  className: 'p-[2em] bg-indigo-100 mb-2',
                  child: const WText('p-[2em] em单位内边距',
                      className: 'text-indigo-700'),
                ),
                WContainer(
                  className: 'mb-[20px] p-4 bg-teal-100',
                  child: const WText('mb-[20px] 任意值外边距',
                      className: 'text-teal-700'),
                ),
              ],
            ),

            // 任意值尺寸测试
            _buildSection(
              '📐 任意值尺寸测试',
              [
                const WText('任意值宽度和高度',
                    className: 'font-semibold mb-4 text-purple-600'),
                WContainer(
                  className:
                      'w-[200px] h-[50px] bg-blue-200 rounded-lg mb-3 flex justify-center items-center',
                  child: const WText('w-[200px] h-[50px]',
                      className: 'text-blue-800 font-medium'),
                ),
                WContainer(
                  className:
                      'w-[150px] h-[80px] bg-green-200 rounded-lg mb-3 flex justify-center items-center',
                  child: const WText('w-[150px] h-[80px]',
                      className: 'text-green-800 font-medium'),
                ),
                WContainer(
                  className:
                      'w-[10rem] h-[3rem] bg-red-200 rounded-lg mb-3 flex justify-center items-center',
                  child: const WText('w-[10rem] h-[3rem]',
                      className: 'text-red-800 font-medium'),
                ),
                WContainer(
                  className:
                      'w-[8em] h-[4em] bg-purple-200 rounded-lg flex justify-center items-center',
                  child: const WText('w-[8em] h-[4em]',
                      className: 'text-purple-800 font-medium'),
                ),
              ],
            ),

            // Gap 间距测试
            _buildSection(
              '🔄 Gap 间距测试',
              [
                const WText('预定义 Gap 间距',
                    className: 'font-semibold mb-4 text-purple-600'),
                const WText('gap-2 (8px)', className: 'font-medium mb-2'),
                WRow(
                  className: 'gap-2',
                  children: [
                    WContainer(
                      className: 'p-3 bg-blue-200 rounded',
                      child: const WText('Item 1', className: 'text-blue-800'),
                    ),
                    WContainer(
                      className: 'p-3 bg-green-200 rounded',
                      child: const WText('Item 2', className: 'text-green-800'),
                    ),
                    WContainer(
                      className: 'p-3 bg-red-200 rounded',
                      child: const WText('Item 3', className: 'text-red-800'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const WText('gap-4 (16px)', className: 'font-medium mb-2'),
                WRow(
                  className: 'gap-4',
                  children: [
                    WContainer(
                      className: 'p-3 bg-purple-200 rounded',
                      child:
                          const WText('Item A', className: 'text-purple-800'),
                    ),
                    WContainer(
                      className: 'p-3 bg-yellow-200 rounded',
                      child:
                          const WText('Item B', className: 'text-yellow-800'),
                    ),
                    WContainer(
                      className: 'p-3 bg-pink-200 rounded',
                      child: const WText('Item C', className: 'text-pink-800'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const WText('gap-6 (24px) - 列布局',
                    className: 'font-medium mb-2'),
                WColumn(
                  className: 'gap-6',
                  children: [
                    WContainer(
                      className: 'p-4 bg-indigo-200 rounded-lg',
                      child: const WText('Column Item 1',
                          className: 'text-indigo-800 text-center'),
                    ),
                    WContainer(
                      className: 'p-4 bg-teal-200 rounded-lg',
                      child: const WText('Column Item 2',
                          className: 'text-teal-800 text-center'),
                    ),
                    WContainer(
                      className: 'p-4 bg-orange-200 rounded-lg',
                      child: const WText('Column Item 3',
                          className: 'text-orange-800 text-center'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const WText('任意值 Gap 间距',
                    className: 'font-semibold mb-4 text-purple-600'),
                const WText('gap-[30px] - 任意值间距',
                    className: 'font-medium mb-2'),
                WRow(
                  className: 'gap-[30px]',
                  children: [
                    WContainer(
                      className: 'p-3 bg-cyan-200 rounded',
                      child:
                          const WText('30px Gap', className: 'text-cyan-800'),
                    ),
                    WContainer(
                      className: 'p-3 bg-lime-200 rounded',
                      child:
                          const WText('30px Gap', className: 'text-lime-800'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const WText('gap-[2rem] - rem单位间距',
                    className: 'font-medium mb-2'),
                WRow(
                  className: 'gap-[2rem]',
                  children: [
                    WContainer(
                      className: 'p-3 bg-rose-200 rounded',
                      child:
                          const WText('2rem Gap', className: 'text-rose-800'),
                    ),
                    WContainer(
                      className: 'p-3 bg-emerald-200 rounded',
                      child: const WText('2rem Gap',
                          className: 'text-emerald-800'),
                    ),
                  ],
                ),
              ],
            ),

            // 圆角测试
            _buildSection(
              '🔘 圆角测试',
              [
                WRow(
                  className: 'gap-4',
                  children: [
                    Expanded(
                      child: WContainer(
                        className: 'p-3 bg-blue-200 rounded-sm',
                        child: const WText('rounded-sm',
                            className: 'text-blue-800 text-center text-sm'),
                      ),
                    ),
                    Expanded(
                      child: WContainer(
                        className: 'p-3 bg-green-200 rounded-md',
                        child: const WText('rounded-md',
                            className: 'text-green-800 text-center text-sm'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                WRow(
                  className: 'gap-4',
                  children: [
                    Expanded(
                      child: WContainer(
                        className: 'p-3 bg-red-200 rounded-lg',
                        child: const WText('rounded-lg',
                            className: 'text-red-800 text-center text-sm'),
                      ),
                    ),
                    Expanded(
                      child: WContainer(
                        className: 'p-3 bg-purple-200 rounded-xl',
                        child: const WText('rounded-xl',
                            className: 'text-purple-800 text-center text-sm'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                WContainer(
                  className: 'p-3 bg-yellow-200 rounded-full',
                  child: const WText('rounded-full',
                      className: 'text-yellow-800 text-center'),
                ),
              ],
            ),

            // 阴影测试
            _buildSection(
              '🌫️ 阴影测试',
              [
                WRow(
                  className: 'gap-4',
                  children: [
                    Expanded(
                      child: WContainer(
                        className: 'p-4 bg-white shadow-sm rounded-lg',
                        child: const WText('shadow-sm',
                            className: 'text-gray-700 text-center'),
                      ),
                    ),
                    Expanded(
                      child: WContainer(
                        className: 'p-4 bg-white shadow-md rounded-lg',
                        child: const WText('shadow-md',
                            className: 'text-gray-700 text-center'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                WRow(
                  className: 'gap-4',
                  children: [
                    Expanded(
                      child: WContainer(
                        className: 'p-4 bg-white shadow-lg rounded-lg',
                        child: const WText('shadow-lg',
                            className: 'text-gray-700 text-center'),
                      ),
                    ),
                    Expanded(
                      child: WContainer(
                        className: 'p-4 bg-white shadow-xl rounded-lg',
                        child: const WText('shadow-xl',
                            className: 'text-gray-700 text-center'),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // 图标测试
            _buildSection(
              '🎯 图标测试',
              [
                WRow(
                  className: 'gap-4',
                  children: [
                    const WIcon(Icons.home, className: 'text-blue-500'),
                    const WIcon(Icons.star, className: 'text-yellow-500'),
                    const WIcon(Icons.favorite, className: 'text-red-500'),
                    const WIcon(Icons.settings, className: 'text-gray-500'),
                    const WIcon(Icons.person, className: 'text-green-500'),
                  ],
                ),
                const SizedBox(height: 8),
                WRow(
                  className: 'gap-4',
                  children: [
                    const WIcon(Icons.home, className: 'text-lg text-blue-600'),
                    const WIcon(Icons.star,
                        className: 'text-xl text-yellow-600'),
                    const WIcon(Icons.favorite,
                        className: 'text-2xl text-red-600'),
                  ],
                ),
              ],
            ),

            // 头像测试
            _buildSection(
              '👤 头像测试',
              [
                WRow(
                  className: 'gap-4',
                  children: [
                    const WAvatar(
                      className: 'bg-blue-500',
                      child: WText('A', className: 'text-white font-bold'),
                    ),
                    const WAvatar(
                      className: 'bg-green-500',
                      child: WIcon(Icons.person, className: 'text-white'),
                    ),
                    const WAvatar(
                      className: 'bg-red-500',
                      child: WText('B', className: 'text-white font-bold'),
                    ),
                    const WAvatar(
                      className: 'bg-purple-500',
                      child: WIcon(Icons.star, className: 'text-white'),
                    ),
                  ],
                ),
              ],
            ),

            // 按钮测试
            _buildSection(
              '🔘 按钮测试',
              [
                WRow(
                  className: 'gap-4',
                  children: [
                    WButton(
                      text: '主要按钮',
                      className: 'bg-blue-600 text-white px-4 py-2 rounded-lg',
                      onPressed: () {
                        setState(() {
                          _counter++;
                        });
                      },
                    ),
                    WButton(
                      text: '次要按钮',
                      className:
                          'bg-gray-200 text-gray-700 px-4 py-2 rounded-lg',
                      onPressed: () {
                        setState(() {
                          _counter--;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                WRow(
                  className: 'gap-4',
                  children: [
                    WButton(
                      text: '成功按钮',
                      className: 'bg-green-600 text-white px-4 py-2 rounded-lg',
                      onPressed: () {},
                    ),
                    WButton(
                      text: '危险按钮',
                      className: 'bg-red-600 text-white px-4 py-2 rounded-lg',
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                WContainer(
                  className: 'p-3 bg-gray-100 rounded-lg',
                  child: WText(
                    '计数器: $_counter',
                    className: 'text-center text-lg font-semibold',
                  ),
                ),
              ],
            ),

            // 输入框测试
            _buildSection(
              '📝 输入框测试',
              [
                WInput(
                  controller: _textController,
                  placeholder: '请输入文字...',
                  className: 'border-gray-300 rounded-lg p-3',
                ),
                const SizedBox(height: 8),
                WButton(
                  text: '清空输入',
                  className: 'bg-red-500 text-white px-4 py-2 rounded-lg',
                  onPressed: () {
                    _textController.clear();
                  },
                ),
              ],
            ),

            // 徽章测试
            _buildSection(
              '🏷️ 徽章测试',
              [
                WRow(
                  className: 'gap-6',
                  children: [
                    WBadge(
                      count: _counter,
                      className: 'bg-red-500',
                      child: const WIcon(Icons.notifications,
                          className: 'text-gray-600'),
                    ),
                    WBadge(
                      count: 5,
                      className: 'bg-blue-500',
                      child: const WIcon(Icons.message,
                          className: 'text-gray-600'),
                    ),
                    WBadge(
                      text: 'NEW',
                      className: 'bg-green-500',
                      child:
                          const WIcon(Icons.star, className: 'text-gray-600'),
                    ),
                  ],
                ),
              ],
            ),

            // 卡片测试
            _buildSection(
              '🃏 卡片测试',
              [
                WCard(
                  className: 'p-4 bg-white rounded-lg shadow-md',
                  child: WColumn(
                    children: [
                      const WText(
                        '卡片标题',
                        className: 'text-lg font-bold text-gray-900 mb-2',
                      ),
                      const WText(
                        '这是卡片内容，展示了 WCard 组件的使用效果。',
                        className: 'text-gray-600',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                WCard(
                  className:
                      'p-4 bg-gradient-to-r from-blue-500 to-purple-600 rounded-xl shadow-lg',
                  child: const WColumn(
                    children: [
                      WText(
                        '渐变卡片',
                        className:
                            'text-white text-xl font-bold text-center mb-2',
                      ),
                      WText(
                        '支持渐变背景的卡片样式',
                        className: 'text-white text-center opacity-90',
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // 列表测试
            _buildSection(
              '📋 列表测试',
              [
                WList(
                  shrinkWrap: true,
                  className: 'bg-white rounded-lg shadow-sm',
                  children: [
                    WListTile(
                      leading:
                          const WIcon(Icons.home, className: 'text-blue-500'),
                      title: const WText('首页', className: 'font-medium'),
                      subtitle: const WText('返回首页', className: 'text-gray-500'),
                      trailing: const WIcon(Icons.arrow_forward_ios,
                          className: 'text-gray-400'),
                      onTap: () {},
                    ),
                    const WDivider(),
                    WListTile(
                      leading: const WIcon(Icons.settings,
                          className: 'text-gray-500'),
                      title: const WText('设置', className: 'font-medium'),
                      subtitle: const WText('应用设置', className: 'text-gray-500'),
                      trailing: const WIcon(Icons.arrow_forward_ios,
                          className: 'text-gray-400'),
                      onTap: () {},
                    ),
                    const WDivider(),
                    WListTile(
                      leading:
                          const WIcon(Icons.info, className: 'text-green-500'),
                      title: const WText('关于', className: 'font-medium'),
                      subtitle: const WText('应用信息', className: 'text-gray-500'),
                      trailing: const WIcon(Icons.arrow_forward_ios,
                          className: 'text-gray-400'),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),

            // 响应式测试
            _buildSection(
              '📱 响应式测试',
              [
                const WText(
                  '调整浏览器窗口大小测试响应式效果',
                  className: 'text-gray-600 text-center mb-4',
                ),
                WContainer(
                  className:
                      'p-4 bg-blue-100 sm:bg-green-100 md:bg-yellow-100 lg:bg-red-100 xl:bg-purple-100 rounded-lg',
                  child: const WText(
                    '响应式容器：小屏蓝色，sm绿色，md黄色，lg红色，xl紫色',
                    className: 'text-center font-medium',
                  ),
                ),
                const SizedBox(height: 8),
                const WText(
                  '响应式文字',
                  className:
                      'text-sm sm:text-base md:text-lg lg:text-xl xl:text-2xl text-center font-bold',
                ),
              ],
            ),

            // 边框测试
            _buildSection(
              '🔲 边框测试',
              [
                const WText('基础边框',
                    className: 'font-semibold mb-4 text-purple-600'),
                WContainer(
                  className: 'p-4 border rounded-lg mb-3',
                  child: const WText('border - 默认边框', className: 'text-center'),
                ),
                WContainer(
                  className: 'p-4 border-2 border-blue-500 rounded-lg mb-3',
                  child: const WText('border-2 border-blue-500',
                      className: 'text-center text-blue-700'),
                ),
                WContainer(
                  className: 'p-4 border-4 border-red-500 rounded-lg mb-3',
                  child: const WText('border-4 border-red-500',
                      className: 'text-center text-red-700'),
                ),
                WContainer(
                  className: 'p-4 border border-[#ff6b6b] rounded-lg',
                  child: const WText('border-[#ff6b6b] 任意值边框',
                      className: 'text-center'),
                ),
              ],
            ),

            // 透明度测试
            _buildSection(
              '👻 透明度测试',
              [
                const WText('透明度变化',
                    className: 'font-semibold mb-4 text-purple-600'),
                WRow(
                  className: 'gap-2',
                  children: [
                    WContainer(
                      className: 'p-3 bg-blue-500 opacity-100 rounded',
                      child: const WText('100%',
                          className: 'text-white text-center'),
                    ),
                    WContainer(
                      className: 'p-3 bg-blue-500 opacity-75 rounded',
                      child: const WText('75%',
                          className: 'text-white text-center'),
                    ),
                    WContainer(
                      className: 'p-3 bg-blue-500 opacity-50 rounded',
                      child: const WText('50%',
                          className: 'text-white text-center'),
                    ),
                    WContainer(
                      className: 'p-3 bg-blue-500 opacity-25 rounded',
                      child: const WText('25%',
                          className: 'text-white text-center'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                WContainer(
                  className: 'p-4 bg-red-500 opacity-[0.6] rounded-lg',
                  child: const WText('opacity-[0.6] 任意值透明度',
                      className: 'text-white text-center'),
                ),
              ],
            ),

            // 文本装饰测试
            _buildSection(
              '✏️ 文本装饰测试',
              [
                const WText('文本装饰效果',
                    className: 'font-semibold mb-4 text-purple-600'),
                const WText('普通文本', className: 'mb-2'),
                const WText('下划线文本', className: 'underline mb-2'),
                const WText('删除线文本', className: 'line-through mb-2'),
                const WText('无装饰文本', className: 'no-underline mb-4'),
                const WText('文本变换',
                    className: 'font-semibold mb-2 text-purple-600'),
                const WText('uppercase text', className: 'uppercase mb-2'),
                const WText('LOWERCASE TEXT', className: 'lowercase mb-2'),
                const WText('capitalize text', className: 'capitalize mb-4'),
                const WText('文本溢出处理',
                    className: 'font-semibold mb-2 text-purple-600'),
                WContainer(
                  className: 'w-[200px] p-2 border rounded',
                  child: const WText(
                    '这是一段很长的文本，用来测试溢出处理效果',
                    className: 'overflow-ellipsis',
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 8),
                WContainer(
                  className: 'w-[200px] p-2 border rounded',
                  child: const WText(
                    '这是一段很长的文本，用来测试行数限制效果。这段文本会被限制在两行内显示。',
                    className: 'line-clamp-2',
                  ),
                ),
              ],
            ),

            // 热重载提示
            _buildSection(
              '🔥 热重载测试说明',
              [
                WContainer(
                  className:
                      'p-4 bg-yellow-50 border border-yellow-200 rounded-lg',
                  child: const WColumn(
                    children: [
                      WText(
                        '💡 热重载测试方法',
                        className: 'font-bold text-yellow-800 mb-2',
                      ),
                      WText(
                        '1. 修改任意组件的 className 属性',
                        className: 'text-yellow-700 mb-1',
                      ),
                      WText(
                        '2. 按 "r" 键进行热重载',
                        className: 'text-yellow-700 mb-1',
                      ),
                      WText(
                        '3. 观察样式是否立即更新',
                        className: 'text-yellow-700 mb-1',
                      ),
                      WText(
                        '4. 如果需要按 "R" 键才能更新，说明热重载未生效',
                        className: 'text-yellow-700 mb-4',
                      ),
                      WText(
                        '🎯 支持的功能',
                        className: 'font-bold text-yellow-800 mb-2',
                      ),
                      WText(
                        '• 任意值颜色: bg-[#ff0000], text-[rgb(255,0,0)], border-[hsl(0,100%,50%)]',
                        className: 'text-yellow-700 mb-1 text-sm',
                      ),
                      WText(
                        '• 任意值尺寸: w-[200px], h-[50px], p-[1rem], m-[2em]',
                        className: 'text-yellow-700 mb-1 text-sm',
                      ),
                      WText(
                        '• Gap间距: gap-[30px], gap-[2rem]',
                        className: 'text-yellow-700 mb-1 text-sm',
                      ),
                      WText(
                        '• 透明度: opacity-[0.5], opacity-75',
                        className: 'text-yellow-700 mb-1 text-sm',
                      ),
                      WText(
                        '• 边框: border-2, border-[#ff0000]',
                        className: 'text-yellow-700 mb-1 text-sm',
                      ),
                      WText(
                        '• 文本装饰: underline, line-through, uppercase',
                        className: 'text-yellow-700 text-sm',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return WCard(
      className: 'bg-white p-6 rounded-lg shadow-sm border border-gray-200',
      child: WColumn(
        children: [
          WText(
            title,
            className: 'text-lg font-semibold text-gray-900 mb-4',
          ),
          ...children.map((child) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: child,
              )),
        ],
      ),
    );
  }

  Widget _colorBox(String className, String label) {
    return Expanded(
      child: WContainer(
        className: '$className h-12 rounded flex justify-center items-center',
        child: WText(
          label,
          className:
              'text-xs font-medium ${className.contains('white') || className.contains('100') ? 'text-gray-700' : 'text-white'}',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
