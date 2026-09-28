import 'package:flutter/material.dart';

/// Model đại diện cho một bộ phim trong danh sách
class MovieItem {
  final String title;
  final String description;

  const MovieItem({
    required this.title,
    required this.description,
  });
}

/// Exercise 3: Layout Basics – Column, Row, Padding, ListView
/// Mục tiêu: Xây dựng bố cục giao diện dạng phân đoạn giống màn hình Home của ứng dụng thực tế.
/// Các bước thực hiện:
/// 1. Sử dụng Column để tạo các section theo chiều dọc (Tiêu đề "Now Playing" & Danh sách phim)
/// 2. Thêm khoảng cách hợp lý bằng Padding và SizedBox (8, 12, 16 px)
/// 3. Sử dụng ListView.builder hiển thị danh sách các tựa phim
/// 4. Áp dụng chuẩn khoảng cách đồng nhất (spacing 8, 12, 16 px)
class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  // Danh sách các bộ phim mẫu theo đúng hình minh họa đề bài
  final List<MovieItem> movies = const [
    MovieItem(title: 'Avatar', description: 'Sample description'),
    MovieItem(title: 'Inception', description: 'Sample description'),
    MovieItem(title: 'Interstellar', description: 'Sample description'),
    MovieItem(title: 'Joker', description: 'Sample description'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 – Layout Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Khoảng cách trên cùng
            const SizedBox(height: 16),

            // Section 1: Tiêu đề "Now Playing" căn giữa
            Center(
              child: Text(
                'Now Playing',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),

            // Khoảng cách 16px giữa Section Tiêu đề và Danh sách
            const SizedBox(height: 16),

            // Section 2: ListView.builder hiển thị danh sách các bộ phim
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  final initialLetter = movie.title.isNotEmpty ? movie.title[0] : '';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1E1E24)
                          : const Color(0xFFF4F5F9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        // CircleAvatar chứa chữ cái đầu của tên phim
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: isDark
                              ? const Color(0xFF283593)
                              : const Color(0xFFDCE2FF),
                          child: Text(
                            initialLetter,
                            style: TextStyle(
                              color: isDark
                                  ? const Color(0xFF9FA8DA)
                                  : const Color(0xFF4C5BB8),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        // Khoảng cách ngang 14px
                        const SizedBox(width: 14),

                        // Column chứa Tên phim và Mô tả
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                movie.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark
                                      ? Colors.white60
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
