import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twind/flutter_twind.dart';

void main() {
  setUpAll(() {
    WindConfig.initialize();
  });

  group('Integration Tests', () {
    testWidgets('should render complete dashboard layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: WText(
                'Flutter Twind Dashboard',
                className: 'text-white font-bold text-lg',
              ),
              backgroundColor: Colors.blue[600],
            ),
            body: SingleChildScrollView(
              child: WContainer(
                className: 'bg-gray-50 p-4',
                child: WColumn(
                  children: [
                    // Header Section
                    WCard(
                      className: 'w-full p-6 mb-6 bg-gradient-to-r from-blue-500 to-purple-600 rounded-xl shadow-lg',
                      child: WColumn(
                        children: [
                          WText(
                            'Welcome to Flutter Twind',
                            className: 'text-white text-2xl font-bold text-center mb-2',
                          ),
                          WText(
                            'A powerful utility-first CSS framework for Flutter',
                            className: 'text-white/80 text-center',
                          ),
                        ],
                      ),
                    ),
                    
                    // Stats Grid
                    WColumn(
                      className: 'gap-4 mb-6',
                      children: [
                        WRow(
                          className: 'gap-4',
                          children: [
                            Expanded(
                              child: _buildStatCard('Users', '1,234', 'text-blue-600', 'bg-blue-50'),
                            ),
                            Expanded(
                              child: _buildStatCard('Revenue', '\$12,345', 'text-green-600', 'bg-green-50'),
                            ),
                            Expanded(
                              child: _buildStatCard('Orders', '567', 'text-purple-600', 'bg-purple-50'),
                            ),
                            Expanded(
                              child: _buildStatCard('Growth', '+23%', 'text-orange-600', 'bg-orange-50'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    // Content Grid
                    WColumn(
                      className: 'gap-6',
                      children: [
                        // Left Column
                        WContainer(
                          className: 'flex-1',
                          child: WColumn(
                            children: [
                              WCard(
                                className: 'p-6 mb-4 shadow-md rounded-lg',
                                child: WColumn(
                                  children: [
                                    WText(
                                      'Recent Activity',
                                      className: 'text-lg font-semibold mb-4',
                                    ),
                                    ...List.generate(3, (index) => 
                                      WContainer(
                                        className: 'flex items-center p-3 mb-2 bg-gray-50 rounded-lg',
                                        child: WRow(
                                          className: 'items-center gap-3',
                                          children: [
                                            WContainer(
                                              className: 'w-8 h-8 bg-blue-500 rounded-full flex items-center justify-center',
                                              child: WText(
                                                '${index + 1}',
                                                className: 'text-white text-sm font-bold',
                                              ),
                                            ),
                                            WColumn(
                                              children: [
                                                WText(
                                                  'Activity ${index + 1}',
                                                  className: 'font-medium',
                                                ),
                                                WText(
                                                  '2 minutes ago',
                                                  className: 'text-gray-500 text-sm',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Right Column
                        WContainer(
                          className: 'flex-1',
                          child: WCard(
                            className: 'p-6 shadow-md rounded-lg',
                            child: WColumn(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                WText(
                                  'Quick Actions',
                                  className: 'text-lg font-semibold mb-4',
                                ),
                                WColumn(
                                  className: 'gap-3',
                                  children: [
                                    WRow(
                                      className: 'gap-3',
                                      children: [
                                        Expanded(
                                          child: _buildActionButton('Add User', 'bg-blue-500', () {}),
                                        ),
                                        Expanded(
                                          child: _buildActionButton('View Reports', 'bg-green-500', () {}),
                                        ),
                                      ],
                                    ),
                                    WRow(
                                      className: 'gap-3',
                                      children: [
                                        Expanded(
                                          child: _buildActionButton('Settings', 'bg-purple-500', () {}),
                                        ),
                                        Expanded(
                                          child: _buildActionButton('Help', 'bg-orange-500', () {}),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Footer
                    WContainer(
                      className: 'w-full mt-8 p-4 bg-gray-800 rounded-lg',
                      child: WText(
                        '© 2024 Flutter Twind. All rights reserved.',
                        className: 'text-white text-center text-sm',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      
      // Verify all components are rendered
      expect(find.text('Flutter Twind Dashboard'), findsOneWidget);
      expect(find.text('Welcome to Flutter Twind'), findsOneWidget);
      expect(find.text('Users'), findsOneWidget);
      expect(find.text('1,234'), findsOneWidget);
      expect(find.text('Revenue'), findsOneWidget);
      expect(find.text('\$12,345'), findsOneWidget);
      expect(find.text('Recent Activity'), findsOneWidget);
      expect(find.text('Quick Actions'), findsOneWidget);
      expect(find.text('Add User'), findsOneWidget);
      expect(find.text('© 2024 Flutter Twind. All rights reserved.'), findsOneWidget);
    });

    testWidgets('should handle complex form layout', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: WContainer(
                className: 'p-6 bg-gray-50',
                child: WCard(
                  className: 'p-8 shadow-xl rounded-2xl bg-white',
                  child: Form(
                      key: formKey,
                      child: WColumn(
                        mainAxisSize: MainAxisSize.min,
                      children: [
                        WText(
                          'User Registration',
                          className: 'text-3xl font-bold text-center mb-8 text-gray-800',
                        ),
                        
                        // Personal Information Section
                        WContainer(
                          className: 'mb-6',
                          child: WColumn(
                            children: [
                              WText(
                                'Personal Information',
                                className: 'text-lg font-semibold mb-4 text-gray-700',
                              ),
                              WRow(
                                className: 'gap-4 mb-4',
                                children: [
                                  Expanded(
                                    child: WContainer(
                                      className: '',
                                    child: WColumn(
                                      children: [
                                        WText(
                                          'First Name',
                                          className: 'text-sm font-medium text-gray-600 mb-2',
                                        ),
                                        WContainer(
                                          className: 'w-full p-3 border border-gray-300 rounded-lg bg-white',
                                          child: TextFormField(
                                            decoration: const InputDecoration.collapsed(
                                              hintText: 'Enter first name',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ),
                                  ),
                                  Expanded(
                                    child: WContainer(
                                      className: '',
                                    child: WColumn(
                                      children: [
                                        WText(
                                          'Last Name',
                                          className: 'text-sm font-medium text-gray-600 mb-2',
                                        ),
                                        WContainer(
                                          className: 'w-full p-3 border border-gray-300 rounded-lg bg-white',
                                          child: TextFormField(
                                            decoration: const InputDecoration.collapsed(
                                              hintText: 'Enter last name',
                                            ),
                                          ),
                                        ),
                                      ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              WColumn(
                                children: [
                                  WText(
                                    'Email Address',
                                    className: 'text-sm font-medium text-gray-600 mb-2',
                                  ),
                                  WContainer(
                                    className: 'w-full p-3 border border-gray-300 rounded-lg bg-white',
                                    child: TextFormField(
                                      decoration: const InputDecoration.collapsed(
                                        hintText: 'Enter email address',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Preferences Section
                        WContainer(
                          className: 'mb-8',
                          child: WColumn(
                            children: [
                              WText(
                                'Preferences',
                                className: 'text-lg font-semibold mb-4 text-gray-700',
                              ),
                              WColumn(
                                className: 'gap-4',
                                children: [
                                  WRow(
                                    className: 'gap-4',
                                    children: [
                                      Expanded(
                                        child: _buildCheckboxOption('Email Notifications'),
                                      ),
                                      Expanded(
                                        child: _buildCheckboxOption('SMS Notifications'),
                                      ),
                                    ],
                                  ),
                                  WRow(
                                    className: 'gap-4',
                                    children: [
                                      Expanded(
                                        child: _buildCheckboxOption('Newsletter'),
                                      ),
                                      Expanded(
                                        child: _buildCheckboxOption('Marketing Updates'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Action Buttons
                        WRow(
                          className: 'gap-4 justify-center',
                          children: [
                            WButton(
                              text: 'Cancel',
                              onPressed: () {},
                              className: 'px-8 py-3 border border-gray-300 rounded-lg text-gray-700 bg-white hover:bg-gray-50',
                            ),
                            WButton(
                              text: 'Register',
                              onPressed: () {},
                              className: 'px-8 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700',
                            ),
                          ],
                        ),
                        ],
                      ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      
      expect(find.text('User Registration'), findsOneWidget);
      expect(find.text('Personal Information'), findsOneWidget);
      expect(find.text('First Name'), findsOneWidget);
      expect(find.text('Last Name'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Preferences'), findsOneWidget);
      expect(find.text('Email Notifications'), findsOneWidget);
      expect(find.text('Register'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('should handle e-commerce product grid', (WidgetTester tester) async {
      final products = [
        {'name': 'Product 1', 'price': '\$29.99', 'image': 'product1.jpg'},
        {'name': 'Product 2', 'price': '\$39.99', 'image': 'product2.jpg'},
        {'name': 'Product 3', 'price': '\$49.99', 'image': 'product3.jpg'},
        {'name': 'Product 4', 'price': '\$59.99', 'image': 'product4.jpg'},
      ];
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: WText(
                'Product Catalog',
                className: 'text-white font-bold',
              ),
              backgroundColor: Colors.indigo[600],
            ),
            body: WContainer(
              className: 'p-4 bg-gray-100',
              child: WColumn(
                children: [
                    WText(
                      'Featured Products',
                      className: 'text-2xl font-bold text-center mb-6 text-gray-800',
                    ),
                    WColumn(
                      children: [
                        WRow(
                          className: 'gap-4',
                          children: [
                            Expanded(
                              child: WCard(
                                className: 'bg-white rounded-xl shadow-lg p-4',
                                child: WColumn(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    WText(
                                      products[0]['name']!,
                                      className: 'text-lg font-semibold mb-2 text-gray-800',
                                    ),
                                    WText(
                                      products[0]['price']!,
                                      className: 'text-xl font-bold text-green-600 mb-4',
                                    ),
                                    WButton(
                                      text: 'Add to Cart',
                                      onPressed: () {},
                                      className: 'w-full bg-blue-600 text-white py-2 px-4 rounded-lg',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: WCard(
                                className: 'bg-white rounded-xl shadow-lg p-4',
                                child: WColumn(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    WText(
                                      products[1]['name']!,
                                      className: 'text-lg font-semibold mb-2 text-gray-800',
                                    ),
                                    WText(
                                      products[1]['price']!,
                                      className: 'text-xl font-bold text-green-600 mb-4',
                                    ),
                                    WButton(
                                      text: 'Add to Cart',
                                      onPressed: () {},
                                      className: 'w-full bg-blue-600 text-white py-2 px-4 rounded-lg',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        WRow(
                          className: 'gap-4',
                          children: [
                            Expanded(
                              child: WCard(
                                className: 'bg-white rounded-xl shadow-lg p-4',
                                child: WColumn(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    WText(
                                      products[2]['name']!,
                                      className: 'text-lg font-semibold mb-2 text-gray-800',
                                    ),
                                    WText(
                                      products[2]['price']!,
                                      className: 'text-xl font-bold text-green-600 mb-4',
                                    ),
                                    WButton(
                                      text: 'Add to Cart',
                                      onPressed: () {},
                                      className: 'w-full bg-blue-600 text-white py-2 px-4 rounded-lg',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: WCard(
                                className: 'bg-white rounded-xl shadow-lg p-4',
                                child: WColumn(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    WText(
                                      products[3]['name']!,
                                      className: 'text-lg font-semibold mb-2 text-gray-800',
                                    ),
                                    WText(
                                      products[3]['price']!,
                                      className: 'text-xl font-bold text-green-600 mb-4',
                                    ),
                                    WButton(
                                      text: 'Add to Cart',
                                      onPressed: () {},
                                      className: 'w-full bg-blue-600 text-white py-2 px-4 rounded-lg',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      );
      
      expect(find.text('Product Catalog'), findsOneWidget);
      expect(find.text('Featured Products'), findsOneWidget);
      expect(find.text('Product 1'), findsOneWidget);
      expect(find.text('\$29.99'), findsOneWidget);
      expect(find.text('Add to Cart'), findsNWidgets(4));
    });

    testWidgets('should handle navigation and routing simulation', (WidgetTester tester) async {
      int currentIndex = 0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: IndexedStack(
                  index: currentIndex,
                  children: [
                    // Home Page
                    WContainer(
                      className: 'p-6 bg-blue-50',
                      child: WColumn(
                        children: [
                          WText(
                            'Home Page',
                            className: 'text-3xl font-bold text-center mb-4 text-blue-800',
                          ),
                          WText(
                            'Welcome to the home page',
                            className: 'text-center text-gray-600',
                          ),
                        ],
                      ),
                    ),
                    // Profile Page
                    WContainer(
                      className: 'p-6 bg-green-50',
                      child: WColumn(
                        children: [
                          WText(
                            'Profile Page',
                            className: 'text-3xl font-bold text-center mb-4 text-green-800',
                          ),
                          WCard(
                            className: 'p-6 bg-white rounded-xl shadow-md',
                            child: WColumn(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                WContainer(
                                  className: 'w-20 h-20 bg-green-500 rounded-full mx-auto mb-4',
                                  child: WContainer(
                                    className: 'w-full h-full flex items-center justify-center',
                                    child: WText(
                                      'JD',
                                      className: 'text-white font-bold text-xl',
                                    ),
                                  ),
                                ),
                                WText(
                                  'John Doe',
                                  className: 'text-xl font-semibold text-center mb-2',
                                ),
                                WText(
                                  'john.doe@example.com',
                                  className: 'text-gray-600 text-center',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Settings Page
                    WContainer(
                      className: 'p-6 bg-purple-50',
                      child: WColumn(
                        children: [
                          WText(
                            'Settings Page',
                            className: 'text-3xl font-bold text-center mb-4 text-purple-800',
                          ),
                          WCard(
                            className: 'p-6 bg-white rounded-xl shadow-md',
                            child: WColumn(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildSettingItem('Dark Mode', false),
                                _buildSettingItem('Notifications', true),
                                _buildSettingItem('Auto-sync', true),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: currentIndex,
                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
      
      // Test initial home page
      expect(find.text('Home Page'), findsOneWidget);
      expect(find.text('Welcome to the home page'), findsOneWidget);
      
      // Navigate to profile
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Profile Page'), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);
      
      // Navigate to settings
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();
      expect(find.text('Settings Page'), findsOneWidget);
      expect(find.text('Dark Mode'), findsOneWidget);
    });
  });
}

// Helper functions
Widget _buildStatCard(String title, String value, String textColor, String bgColor) {
  return WCard(
    className: 'p-4 $bgColor rounded-lg',
    child: WColumn(
      children: [
        WText(
          value,
          className: '$textColor text-2xl font-bold text-center',
        ),
        WText(
          title,
          className: 'text-gray-600 text-sm text-center mt-1',
        ),
      ],
    ),
  );
}

Widget _buildActionButton(String text, String bgColor, VoidCallback onPressed) {
  return WButton(
    text: text,
    onPressed: onPressed,
    className: '$bgColor text-white p-3 rounded-lg text-center font-medium',
  );
}

Widget _buildCheckboxOption(String label) {
  return WContainer(
    className: 'p-2',
    child: WRow(
      className: 'items-center gap-2',
      children: [
        Checkbox(
          value: false,
          onChanged: (value) {},
        ),
        Expanded(
          child: WText(
            label,
            className: 'text-gray-700',
          ),
        ),
      ],
    ),
  );
}

Widget _buildSettingItem(String title, bool value) {
  return WContainer(
    className: 'flex-row items-center justify-between p-3 border-b border-gray-200',
    child: WRow(
      className: 'items-center justify-between',
      children: [
        WText(
          title,
          className: 'text-gray-800 font-medium',
        ),
        Switch(
          value: value,
          onChanged: (newValue) {},
        ),
      ],
    ),
  );
}