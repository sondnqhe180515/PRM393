import 'package:flutter/material.dart';

/// Exercise 3: Layout Composition
/// Minh họa các kỹ thuật bố cục giao diện trong Flutter:
/// - Column: Xếp các widget theo chiều dọc
/// - Row: Xếp các widget theo chiều ngang
/// - Padding: Tạo khoảng đệm khoảng cách giữa các phần tử
/// - ListView: Tạo danh sách cuộn động
class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 – Layout Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------------------------------
            // SECTION 1: Row Composition
            // ----------------------------------------------------
            const Text(
              '1. Row Layout (Horizontal Alignment)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSampleBox('Box 1', Colors.blue),
                  _buildSampleBox('Box 2', Colors.indigo),
                  _buildSampleBox('Box 3', Colors.teal),
                ],
              ),
            ),
            const Divider(height: 32),

            // ----------------------------------------------------
            // SECTION 2: Column & Padding Composition
            // ----------------------------------------------------
            const Text(
              '2. Column & Padding Layout',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.green.shade200,
                    child: const Text('Row item 1 with Padding', textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.green.shade300,
                    child: const Text('Row item 2 with Padding', textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            const Divider(height: 32),

            // ----------------------------------------------------
            // SECTION 3: ListView Component
            // ----------------------------------------------------
            const Text(
              '3. ListView (Scrollable List)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Sử dụng ListView bên trong Column cần kèm shrinkWrap hoặc chiều cao cố định
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple.shade100,
                      child: Text('${index + 1}'),
                    ),
                    title: Text('List Item #${index + 1}'),
                    subtitle: Text('Sample description for layout item #${index + 1}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget phụ trợ hiển thị các khối màu
  Widget _buildSampleBox(String text, Color color) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
