import 'package:flutter/material.dart';

/// Exercise 4: Building Screen Structure using Scaffold & ThemeData
/// Minh họa:
/// - Cấu trúc hoàn chỉnh của một màn hình Scaffold (AppBar, Drawer, BottomNavigationBar, FloatingActionButton)
/// - Cách ứng dụng đọc và áp dụng các thông số từ ThemeData (Theme.of(context))
class AppThemeDemo extends StatefulWidget {
  const AppThemeDemo({super.key});

  @override
  State<AppThemeDemo> createState() => _AppThemeDemoState();
}

class _AppThemeDemoState extends State<AppThemeDemo> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // 1. Scaffold AppBar
      appBar: AppBar(
        title: const Text('Exercise 4 – Scaffold & Theme'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Scaffold Action Button Pressed')),
              );
            },
          ),
        ],
      ),

      // 2. Scaffold Drawer (Menu thanh trượt bên hông)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('PRM393 Student'),
              accountEmail: const Text('student@fpt.edu.vn'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.blue),
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      // 3. Scaffold Body (Nội dung hiển thị các token của ThemeData)
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Theme ColorScheme Demo',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: [
                          Chip(
                            label: const Text('Primary Color'),
                            backgroundColor: theme.colorScheme.primaryContainer,
                          ),
                          Chip(
                            label: const Text('Secondary Color'),
                            backgroundColor: theme.colorScheme.secondaryContainer,
                          ),
                          Chip(
                            label: const Text('Surface Color'),
                            backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Currently on Tab: ${_currentTabIndex + 1}',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // 4. Scaffold FloatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Floating Action Button clicked!'),
              backgroundColor: theme.colorScheme.primary,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      // 5. Scaffold BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.palette),
            label: 'Theme',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
