import 'package:flutter/material.dart';
import '../main.dart';

/// Exercise 4: App Structure with Scaffold, AppBar, FAB & Theme
/// Mục tiêu: Luyện tập xây dựng cấu trúc hoàn chỉnh của một màn hình Flutter.
/// Các bước thực hiện:
/// 1. Tạo màn hình mới sử dụng Scaffold.
/// 2. Bổ sung các thành phần:
///    - AppBar: Có tiêu đề và công tắc chuyển đổi Dark Mode
///    - Body: Chứa nội dung hiển thị ở vị trí trung tâm
///    - FloatingActionButton: Nút hành động nổi ở góc dưới
///    - Theme customization: Tùy biến màu sắc và giao diện qua ThemeData
/// 3. Triển khai chuyển đổi "Dark Mode" thông qua themeMode của MaterialApp
class AppThemeDemo extends StatefulWidget {
  const AppThemeDemo({super.key});

  @override
  State<AppThemeDemo> createState() => _AppThemeDemoState();
}

class _AppThemeDemoState extends State<AppThemeDemo> {
  @override
  Widget build(BuildContext context) {
    // Kiểm tra xem hiện tại themeMode đang là dark hay light
    final isDark = themeModeNotifier.value == ThemeMode.dark;
    final theme = Theme.of(context);

    return Scaffold(
      // 1. AppBar với tiêu đề và Switch chuyển Dark Mode
      appBar: AppBar(
        title: const Text('Exercise 4 – App Structure & Theme'),
        actions: [
          Row(
            children: [
              Text(
                'Dark',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(width: 4),
              Switch(
                value: isDark,
                onChanged: (bool value) {
                  setState(() {
                    themeModeNotifier.value =
                        value ? ThemeMode.dark : ThemeMode.light;
                  });
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),

      // 2. Body hiển thị đúng thông điệp theo thiết kế mẫu
      body: Center(
        child: Text(
          'This is a simple screen with theme toggle.',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ),

      // 3. FloatingActionButton theo yêu cầu
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Current Theme: ${isDark ? "Dark Mode" : "Light Mode"}',
              ),
              duration: const Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
