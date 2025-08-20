import 'package:flutter/material.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  runApp(const FlutterTwindExampleApp());
}

/// Example app demonstrating Flutter Twind components
class FlutterTwindExampleApp extends StatelessWidget {
  const FlutterTwindExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Twind Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

/// Home page showcasing various Flutter Twind components
class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  int _counter = 0;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WAppBar(
        title: const WText(
          'Flutter Twind Example',
          className: 'text-white font-bold text-lg',
        ),
        className: 'bg-blue-600',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: WColumn(
          className: 'gap-6',
          children: [
            // Header Section
            WCard(
              className: 'p-6 bg-gradient-to-r from-blue-500 to-purple-600 rounded-xl shadow-lg',
              child: WColumn(
                children: [
                  const WText(
                    'Welcome to Flutter Twind',
                    className: 'text-white text-2xl font-bold text-center mb-2',
                  ),
                  const WText(
                    'TailwindCSS-like styling for Flutter widgets',
                    className: 'text-white text-center opacity-90',
                  ),
                ],
              ),
            ),

            // Layout Components Section
            _buildSection(
              'Layout Components',
              [
                WContainer(
                  className: 'w-full h-20 bg-gray-100 border-2 border-dashed border-gray-300 rounded-lg flex justify-center items-center',
                  child: const WText(
                    'Centered Container',
                    className: 'text-gray-600 font-medium',
                  ),
                ),
                WRow(
                  className: 'gap-4',
                  children: [
                    Expanded(
                      child: WContainer(
                        className: 'h-16 bg-red-100 rounded-lg flex justify-center items-center',
                        child: const WText('Row Item 1', className: 'text-red-600'),
                      ),
                    ),
                    Expanded(
                      child: WContainer(
                        className: 'h-16 bg-green-100 rounded-lg flex justify-center items-center',
                        child: const WText('Row Item 2', className: 'text-green-600'),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Text Components Section
            _buildSection(
              'Text Components',
              [
                const WText(
                  'Large Bold Text',
                  className: 'text-2xl font-bold text-gray-900',
                ),
                const WText(
                  'Medium text with color',
                  className: 'text-lg text-blue-600 font-medium',
                ),
                const WText(
                  'Small centered text',
                  className: 'text-sm text-gray-500 text-center',
                ),
              ],
            ),

            // Button Components Section
            _buildSection(
              'Interactive Components',
              [
                WRow(
                  className: 'gap-4',
                  children: [
                    WButton(
                      text: 'Primary Button',
                      className: 'bg-blue-600 text-white px-6 py-3 rounded-lg',
                      onPressed: () {
                        setState(() {
                          _counter++;
                        });
                      },
                    ),
                    WButton(
                      text: 'Secondary',
                      className: 'bg-gray-200 text-gray-700 px-6 py-3 rounded-lg',
                      onPressed: () {
                        setState(() {
                          _counter--;
                        });
                      },
                    ),
                  ],
                ),
                WContainer(
                  className: 'p-4 bg-gray-50 rounded-lg',
                  child: WText(
                    'Counter: $_counter',
                    className: 'text-center text-lg font-semibold',
                  ),
                ),
              ],
            ),

            // Input Components Section
            _buildSection(
              'Form Components',
              [
                WInput(
                  controller: _textController,
                  placeholder: 'Enter some text...',
                  className: 'border-gray-300 rounded-lg p-3',
                ),
                WButton(
                  text: 'Clear Input',
                  className: 'bg-red-500 text-white px-4 py-2 rounded-lg',
                  onPressed: () {
                    _textController.clear();
                  },
                ),
              ],
            ),

            // Badge and Avatar Section
            _buildSection(
              'Visual Components',
              [
                WRow(
                  className: 'gap-4 items-center',
                  children: [
                    WBadge(
                      count: _counter,
                      className: 'bg-red-500',
                      child: const WAvatar(
                        className: 'bg-blue-500',
                        child: WIcon(Icons.person, className: 'text-white'),
                      ),
                    ),
                    const WAvatar(
                      className: 'bg-green-500',
                      child: WText('A', className: 'text-white font-bold'),
                    ),
                    const WAvatar(
                      className: 'bg-purple-500',
                      child: WIcon(Icons.star, className: 'text-white'),
                    ),
                  ],
                ),
              ],
            ),

            // List Components Section
            _buildSection(
              'List Components',
              [
                WList(
                  shrinkWrap: true,
                  className: 'bg-white rounded-lg shadow-sm',
                  children: [
                    WListTile(
                      leading: const WIcon(Icons.home, className: 'text-blue-500'),
                      title: const WText('Home', className: 'font-medium'),
                      subtitle: const WText('Go to home page', className: 'text-gray-500'),
                      trailing: const WIcon(Icons.arrow_forward_ios, className: 'text-gray-400'),
                      onTap: () {},
                    ),
                    const WDivider(),
                    WListTile(
                      leading: const WIcon(Icons.settings, className: 'text-gray-500'),
                      title: const WText('Settings', className: 'font-medium'),
                      subtitle: const WText('App preferences', className: 'text-gray-500'),
                      trailing: const WIcon(Icons.arrow_forward_ios, className: 'text-gray-400'),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: WBadge(
        count: _counter,
        child: FloatingActionButton(
          onPressed: () {
            WDialog.show(
              context: context,
              title: 'Flutter Twind Dialog',
              child: const WText(
                'This is a dialog created with Flutter Twind components!',
                className: 'text-gray-700',
              ),
              actions: [
                WButton(
                  text: 'Close',
                  className: 'bg-blue-600 text-white px-4 py-2 rounded-lg',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return WCard(
      className: 'p-4 bg-white rounded-lg shadow-sm border border-gray-200',
      child: WColumn(
        children: [
          WText(
            title,
            className: 'text-lg font-semibold text-gray-900 mb-4',
          ),
          ...children.map((child) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: child,
          )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}