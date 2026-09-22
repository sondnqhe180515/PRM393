import 'package:flutter/material.dart';
import 'core_widgets_demo.dart';
import 'input_controls_demo.dart';
import 'layout_demo.dart';
import 'app_theme_demo.dart';
import 'common_fixes_demo.dart';

/// Màn hình Menu chính liệt kê 5 bài tập của Lab 4 – Flutter UI Fundamentals
/// Giống như giao diện thiết kế mẫu trong tài liệu môn học.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Danh sách 5 bài tập kèm widget đích
    final exercises = [
      {
        'title': 'Exercise 1 – Core Widgets Demo',
        'screen': const CoreWidgetsDemo(),
      },
      {
        'title': 'Exercise 2 – Input Controls Demo',
        'screen': const InputControlsDemo(),
      },
      {
        'title': 'Exercise 3 – Layout Demo',
        'screen': const LayoutDemo(),
      },
      {
        'title': 'Exercise 4 – App Structure & Theme',
        'screen': const AppThemeDemo(),
      },
      {
        'title': 'Exercise 5 – Common UI Fixes',
        'screen': const CommonFixesDemo(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab 4 – Flutter UI Fundamentals',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        itemCount: exercises.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = exercises[index];
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => item['screen'] as Widget,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item['title'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.black45,
                    size: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
