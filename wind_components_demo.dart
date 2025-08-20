import 'package:flutter/material.dart';
import 'lib/wind_components.dart';
import 'lib/utils/wind_config.dart';

void main() {
  // 初始化 WindConfig
  WindConfig.initialize();
  runApp(const WindComponentsDemo());
}

class WindComponentsDemo extends StatelessWidget {
  const WindComponentsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wind Components Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  int _selectedIndex = 0;
  bool _switchValue = false;
  double _sliderValue = 50.0;
  String _radioValue = 'option1';
  bool _checkboxValue = false;
  final TextEditingController _textController = TextEditingController();

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _buildLayoutComponents(),
      _buildVisualComponents(),
      _buildInteractiveComponents(),
      _buildFunctionalComponents(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wind Components Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_module),
            label: '布局组件',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.palette),
            label: '视觉组件',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: '交互组件',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets),
            label: '功能组件',
          ),
        ],
      ),
    );
  }

  Widget _buildLayoutComponents() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('布局组件演示'),
          const SizedBox(height: 16),

          // WContainer 演示
          _buildComponentDemo(
            'WContainer',
            'TailwindCSS 风格的容器组件',
            Column(
              children: [
                WContainer(
                  className: 'bg-blue-500 p-4 rounded-lg shadow-md',
                  child: const WText(
                    '蓝色容器',
                    className: 'text-white font-bold text-center',
                  ),
                ),
                const SizedBox(height: 8),
                WContainer(
                  className: 'bg-green-500 p-6 rounded-full w-200 h-200 flex justify-center items-center',
                  child: const WText(
                    '圆形容器',
                    className: 'text-black text-center',
                  ),
                ),
                const SizedBox(height: 8),
                WContainer(
                  className: 'bg-red-500 p-2 m-4',
                  width: 200,
                  height: 100,
                  child: const WText(
                    '固定尺寸容器',
                    className: 'text-white text-center',
                  ),
                ),
              ],
            ),
          ),

          // WRow 演示
          _buildComponentDemo(
            'WRow',
            '水平布局组件',
            WRow(
              className: 'bg-gray-100 p-4 rounded-lg',
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WContainer(
                  className: 'bg-purple-500 p-3 rounded',
                  child: const WText('Item 1', className: 'text-white'),
                ),
                WContainer(
                  className: 'bg-orange-500 p-3 rounded',
                  child: const WText('Item 2', className: 'text-white'),
                ),
                WContainer(
                  className: 'bg-teal-500 p-3 rounded',
                  child: const WText('Item 3', className: 'text-white'),
                ),
              ],
            ),
          ),

          // WColumn 演示
          _buildComponentDemo(
            'WColumn',
            '垂直布局组件',
            WColumn(
              className: 'bg-gray-100 p-4 rounded-lg',
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WContainer(
                  className: 'bg-indigo-500 p-3 rounded mb-2',
                  child: const WText('顶部', className: 'text-blue text-center'),
                ),
                WContainer(
                  className: 'bg-pink-500 p-3 rounded mb-2',
                  child: const WText('中间', className: 'text-[#5e7d20] text-center'),
                ),
                WContainer(
                  className: 'bg-cyan-500 p-3 rounded',
                  child: const WText('底部', className: 'text-yellow text-center'),
                ),
              ],
            ),
          ),

          // WStack 演示
          _buildComponentDemo(
            'WStack',
            '层叠布局组件',
            SizedBox(
              height: 200,
              child: WStack(
                className: 'bg-gray-200 rounded-lg',
                children: [
                  WContainer(
                    className: 'bg-yellow-500 rounded-lg',
                    width: 150,
                    height: 150,
                    child: const WText(
                      '背景层',
                      className: 'text-black text-center',
                    ),
                  ),
                  WPositioned(
                    className: 'top-4 right-4',
                    child: WContainer(
                      className: 'bg-red-500 p-2 rounded-full',
                      child: const WText(
                        '浮层',
                        className: 'text-white text-xs',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisualComponents() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('视觉组件演示'),
          const SizedBox(height: 16),

          // WText 演示
          _buildComponentDemo(
            'WText',
            '文本组件',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                WText(
                  '超大标题',
                  className: 'text-2xl font-bold text-gray-900',
                ),
                SizedBox(height: 8),
                WText(
                  '大标题',
                  className: 'text-xl font-semibold text-blue-600',
                ),
                SizedBox(height: 8),
                WText(
                  '普通文本',
                  className: 'text-base text-gray-700',
                ),
                SizedBox(height: 8),
                WText(
                  '小文本',
                  className: 'text-sm text-gray-500',
                ),
                SizedBox(height: 8),
                WText(
                  '居中文本',
                  className: 'text-lg font-medium text-purple-600 text-center',
                ),
              ],
            ),
          ),

          // WCard 演示
          _buildComponentDemo(
            'WCard',
            '卡片组件',
            Column(
              children: [
                WCard(
                  className: 'bg-white shadow-lg',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      WText(
                        '卡片标题',
                        className: 'text-lg font-bold text-gray-900',
                      ),
                      SizedBox(height: 8),
                      WText(
                        '这是一个卡片组件的示例，展示了如何使用 WCard 来创建美观的卡片布局。',
                        className: 'text-gray-600',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                WCard(
                  className: 'bg-gradient-to-r from-blue-500 to-purple-600',
                  child: const WText(
                    '渐变背景卡片',
                    className: 'text-white font-semibold text-center',
                  ),
                ),
              ],
            ),
          ),

          // WIcon 演示
          _buildComponentDemo(
            'WIcon',
            '图标组件',
            WRow(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                WIcon(
                  Icons.home,
                  className: 'text-blue-500',
                  size: 32,
                ),
                WIcon(
                  Icons.favorite,
                  className: 'text-red-500',
                  size: 32,
                ),
                WIcon(
                  Icons.star,
                  className: 'text-yellow-500',
                  size: 32,
                ),
                WIcon(
                  Icons.settings,
                  className: 'text-gray-600',
                  size: 32,
                ),
              ],
            ),
          ),

          // WAvatar 演示
          _buildComponentDemo(
            'WAvatar',
            '头像组件',
            WRow(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                WAvatar(
                  className: 'bg-blue-500',
                  radius: 25,
                  child: WText('A', className: 'text-white font-bold'),
                ),
                WAvatar(
                  className: 'bg-green-500',
                  radius: 30,
                  child: WIcon(Icons.person, color: Colors.white),
                ),
                WAvatar(
                  className: 'bg-purple-500',
                  radius: 35,
                  child: WText('用', className: 'text-white font-bold'),
                ),
              ],
            ),
          ),

          // WDivider 演示
          _buildComponentDemo(
            'WDivider',
            '分割线组件',
            Column(
              children: const [
                WText('上方内容', className: 'text-gray-700'),
                WDivider(className: 'my-4'),
                WText('下方内容', className: 'text-gray-700'),
                WDivider(
                  className: 'my-4',
                  thickness: 2,
                  color: Colors.blue,
                ),
                WText('粗蓝色分割线', className: 'text-gray-700'),
              ],
            ),
          ),

          // 边框组件演示
          _buildComponentDemo(
            '边框组件',
            '各种边框样式演示',
            Column(
              children: [
                WRow(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WContainer(
                      className: 'p-4 border border-gray-300 rounded',
                      child: const WText('普通边框', className: 'text-center'),
                    ),
                    WContainer(
                      className: 'p-4 border-2 border-blue-500 rounded',
                      child: const WText('蓝色粗边框', className: 'text-center'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                WRow(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WContainer(
                      className: 'p-4 border border-red-500 rounded-lg',
                      child: const WText('红色圆角边框', className: 'text-center'),
                    ),
                    WContainer(
                      className: 'p-4 border-4 border-green-500 rounded-full',
                      child: const WText('绿色圆形边框', className: 'text-center'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                WRow(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WContainer(
                      className: 'p-4 border border-dashed border-purple-500',
                      child: const WText('虚线边框', className: 'text-center'),
                    ),
                    WContainer(
                      className: 'p-4 border-t-4 border-orange-500',
                      child: const WText('顶部边框', className: 'text-center'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                WContainer(
                  className: 'p-4 border-4 border-gradient-to-r from-pink-500 to-violet-500 rounded-xl',
                  child: const WText(
                    '渐变色边框效果',
                    className: 'text-center font-bold',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveComponents() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('交互组件演示'),
          const SizedBox(height: 16),

          // WButton 演示
          _buildComponentDemo(
            'WButton',
            '按钮组件',
            Column(
              children: [
                WRow(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WButton(
                      text: '小按钮',
                      size: ButtonSize.small,
                      onPressed: () => _showSnackBar('小按钮被点击'),
                    ),
                    WButton(
                      text: '中按钮',
                      size: ButtonSize.medium,
                      onPressed: () => _showSnackBar('中按钮被点击'),
                    ),
                    WButton(
                      text: '大按钮',
                      size: ButtonSize.large,
                      onPressed: () => _showSnackBar('大按钮被点击'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                WRow(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WButton(
                      text: '主要按钮',
                      className: 'bg-blue-500',
                      onPressed: () => _showSnackBar('主要按钮被点击'),
                    ),
                    WButton(
                      text: '成功按钮',
                      className: 'bg-green-500',
                      onPressed: () => _showSnackBar('成功按钮被点击'),
                    ),
                    WButton(
                      text: '危险按钮',
                      className: 'bg-red-500',
                      onPressed: () => _showSnackBar('危险按钮被点击'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                WRow(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WButton(
                      text: '带图标',
                      icon: const Icon(Icons.star, size: 16),
                      onPressed: () => _showSnackBar('带图标按钮被点击'),
                    ),
                    WButton(
                      text: '加载中',
                      isLoading: true,
                      onPressed: () {},
                    ),
                    WButton(
                      text: '禁用',
                      isDisabled: true,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),

          // WInput 演示
          _buildComponentDemo(
            'WInput',
            '输入框组件',
            Column(
              children: [
                WInput(
                  placeholder: '请输入用户名',
                  className: 'mb-4',
                  controller: _textController,
                  prefixIcon: const Icon(Icons.person),
                ),
                WInput(
                  placeholder: '请输入密码',
                  className: 'mb-4',
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.visibility),
                ),
                WInput(
                  placeholder: '多行文本输入',
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                ),
              ],
            ),
          ),

          // 开关和滑块演示
          _buildComponentDemo(
            '开关和滑块',
            '交互控件演示',
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const WText('开关控件:', className: 'font-medium'),
                    Switch(
                      value: _switchValue,
                      onChanged: (value) => setState(() => _switchValue = value),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WText('滑块控件: ${_sliderValue.round()}', className: 'font-medium'),
                    Slider(
                      value: _sliderValue,
                      min: 0,
                      max: 100,
                      divisions: 10,
                      onChanged: (value) => setState(() => _sliderValue = value),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WText('单选按钮:', className: 'font-medium'),
                    RadioListTile<String>(
                      title: const Text('选项 1'),
                      value: 'option1',
                      groupValue: _radioValue,
                      onChanged: (value) => setState(() => _radioValue = value!),
                    ),
                    RadioListTile<String>(
                      title: const Text('选项 2'),
                      value: 'option2',
                      groupValue: _radioValue,
                      onChanged: (value) => setState(() => _radioValue = value!),
                    ),
                  ],
                ),
                CheckboxListTile(
                  title: const Text('复选框'),
                  value: _checkboxValue,
                  onChanged: (value) => setState(() => _checkboxValue = value!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionalComponents() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('功能组件演示'),
          const SizedBox(height: 16),

          // WBadge 演示
          _buildComponentDemo(
            'WBadge',
            '徽章组件',
            WRow(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WBadge(
                  count: 5,
                  child: const WIcon(Icons.notifications, size: 32),
                ),
                WBadge(
                  text: 'New',
                  backgroundColor: Colors.green,
                  child: const WIcon(Icons.message, size: 32),
                ),
                WBadge(
                  count: 99,
                  child: const WIcon(Icons.shopping_cart, size: 32),
                ),
              ],
            ),
          ),

          // WList 演示
          _buildComponentDemo(
            'WList',
            '列表组件',
            SizedBox(
              height: 300,
              child: WList(
                className: 'bg-gray-50 rounded-lg',
                children: [
                  WListTile(
                    leading: const WIcon(Icons.person),
                    title: const WText('用户管理', className: 'font-medium'),
                    subtitle: const WText('管理系统用户', className: 'text-gray-600'),
                    trailing: const WIcon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _showSnackBar('用户管理被点击'),
                  ),
                  WListTile(
                    leading: const WIcon(Icons.settings),
                    title: const WText('系统设置', className: 'font-medium'),
                    subtitle: const WText('配置系统参数', className: 'text-gray-600'),
                    trailing: const WIcon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _showSnackBar('系统设置被点击'),
                  ),
                  WListTile(
                    leading: const WIcon(Icons.help),
                    title: const WText('帮助中心', className: 'font-medium'),
                    subtitle: const WText('获取帮助信息', className: 'text-gray-600'),
                    trailing: const WIcon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _showSnackBar('帮助中心被点击'),
                  ),
                  WListTile(
                    leading: const WIcon(Icons.info),
                    title: const WText('关于我们', className: 'font-medium'),
                    subtitle: const WText('了解更多信息', className: 'text-gray-600'),
                    trailing: const WIcon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _showSnackBar('关于我们被点击'),
                  ),
                ],
              ),
            ),
          ),

          // 对话框演示
          _buildComponentDemo(
            'WDialog',
            '对话框组件',
            Column(
              children: [
                WButton(
                  text: '显示简单对话框',
                  onPressed: () => _showSimpleDialog(),
                ),
                const SizedBox(height: 8),
                WButton(
                  text: '显示确认对话框',
                  className: 'bg-orange-500',
                  onPressed: () => _showConfirmDialog(),
                ),
                const SizedBox(height: 8),
                WButton(
                  text: '显示自定义对话框',
                  className: 'bg-purple-500',
                  onPressed: () => _showCustomDialog(),
                ),
              ],
            ),
          ),

          // 综合演示
          _buildComponentDemo(
            '综合演示',
            '多组件组合使用',
            WCard(
              className: 'bg-white shadow-lg',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WRow(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const WText(
                        '用户信息',
                        className: 'text-lg font-bold text-gray-900',
                      ),
                      WBadge(
                        text: 'VIP',
                        backgroundColor: Colors.amber,
                        child: const WAvatar(
                          radius: 20,
                          child: WIcon(Icons.person, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const WDivider(className: 'my-3'),
                  const WText(
                    '这是一个综合演示，展示了多个 Wind 组件的组合使用效果。',
                    className: 'text-gray-600 mb-4',
                  ),
                  WRow(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      WButton(
                        text: '取消',
                        className: 'bg-gray-500 mr-2',
                        size: ButtonSize.small,
                        onPressed: () => _showSnackBar('取消操作'),
                      ),
                      WButton(
                        text: '确认',
                        size: ButtonSize.small,
                        onPressed: () => _showSnackBar('确认操作'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return WText(
      title,
      className: 'text-2xl font-bold text-gray-900 mb-4',
    );
  }

  Widget _buildComponentDemo(String title, String description, Widget demo) {
    return WCard(
      className: 'bg-white shadow-md mb-6',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WText(
            title,
            className: 'text-lg font-semibold text-gray-900',
          ),
          const SizedBox(height: 4),
          WText(
            description,
            className: 'text-sm text-gray-600 mb-4',
          ),
          demo,
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showSimpleDialog() {
    WDialog.show(
      context: context,
      title: '简单对话框',
      child: const WText(
        '这是一个简单的对话框示例。',
        className: 'text-gray-700',
      ),
      actions: [
        WButton(
          text: '确定',
          size: ButtonSize.small,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  void _showConfirmDialog() {
    WDialog.show(
      context: context,
      title: '确认操作',
      child: const WText(
        '您确定要执行此操作吗？此操作不可撤销。',
        className: 'text-gray-700',
      ),
      actions: [
        WButton(
          text: '取消',
          className: 'bg-gray-500 mr-2',
          size: ButtonSize.small,
          onPressed: () => Navigator.of(context).pop(),
        ),
        WButton(
          text: '确认',
          className: 'bg-red-500',
          size: ButtonSize.small,
          onPressed: () {
            Navigator.of(context).pop();
            _showSnackBar('操作已确认');
          },
        ),
      ],
    );
  }

  void _showCustomDialog() {
    WDialog.show(
      context: context,
      title: '自定义对话框',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const WText(
            '这是一个自定义对话框，包含多种组件：',
            className: 'text-gray-700 mb-4',
          ),
          WInput(
            placeholder: '请输入内容',
            className: 'mb-4',
          ),
          WRow(
            children: [
              Checkbox(
                value: true,
                onChanged: (value) {},
              ),
              const WText('我同意相关条款', className: 'text-gray-700'),
            ],
          ),
        ],
      ),
      actions: [
        WButton(
          text: '取消',
          className: 'bg-gray-500 mr-2',
          size: ButtonSize.small,
          onPressed: () => Navigator.of(context).pop(),
        ),
        WButton(
          text: '提交',
          className: 'bg-green-500',
          size: ButtonSize.small,
          onPressed: () {
            Navigator.of(context).pop();
            _showSnackBar('内容已提交');
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}