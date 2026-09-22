import 'package:flutter/material.dart';

/// Exercise 5: Common UI Errors & Fixes
/// Minh họa các lỗi giao diện kinh điển trong Flutter và cách khắc phục:
/// 1. RenderFlex Overflow (Lỗi tràn viền vàng đen trong Row/Column)
///    -> Cách sửa: Dùng Expanded / Flexible hoặc SingleChildScrollView
/// 2. Unbounded Height Constraint (Lỗi crash khi đặt ListView trong Column)
///    -> Cách sửa: Bọc trong Expanded hoặc thêm shrinkWrap: true
class CommonFixesDemo extends StatefulWidget {
  const CommonFixesDemo({super.key});

  @override
  State<CommonFixesDemo> createState() => _CommonFixesDemoState();
}

class _CommonFixesDemoState extends State<CommonFixesDemo> {
  bool _isFixed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5 – Common UI Fixes'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Switch chuyển đổi xem trạng thái Fix hay Trạng thái cảnh báo
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _isFixed ? Colors.green.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isFixed ? Colors.green : Colors.red,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isFixed ? 'Đang bật chế độ: ĐÃ FIX LỖI' : 'Đang bật chế độ: CẢNH BÁO LỖI',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _isFixed ? Colors.green.shade800 : Colors.red.shade800,
                    ),
                  ),
                  Switch(
                    value: _isFixed,
                    onChanged: (val) {
                      setState(() {
                        _isFixed = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ----------------------------------------------------
            // LỖI 1: Tràn màn hình ngang trong Row (RenderFlex Overflow)
            // ----------------------------------------------------
            const Text(
              '1. Row Overflow Fix (RenderFlex)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Khi đặt một đoạn văn bản rất dài trong Row cạnh một icon hoặc widget khác, Flutter sẽ bị lỗi tràn màn hình.',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: _isFixed
                  // CÁCH SỬA: Bọc Text bằng widget Expanded
                  ? const Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Đoạn văn bản cực kỳ dài này đã được bọc trong widget Expanded để tự động xuống dòng mượt mà mà không làm vỡ giao diện.',
                          ),
                        ),
                      ],
                    )
                  // MINH HỌA LỖI: Không dùng Expanded
                  : Row(
                      children: [
                        const Icon(Icons.warning, color: Colors.amber),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(6),
                          color: Colors.red.shade100,
                          child: const Text(
                            'Text dài không có Expanded -> Nguy cơ tràn pixel viền sọc vàng đen!',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
            ),
            const Divider(height: 32),

            // ----------------------------------------------------
            // LỖI 2: ListView lồng trong Column (Unbounded Height)
            // ----------------------------------------------------
            const Text(
              '2. ListView inside Column Fix',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'ListView có chiều cao vô hạn theo mặc định. Khi đặt trực tiếp trong Column sẽ gây lỗi Vertical viewport was given unbounded height.',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      'Danh sách được giới hạn bằng shrinkWrap: true',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    // GIẢI PHÁP: Sử dụng shrinkWrap: true & physics: NeverScrollableScrollPhysics
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          leading: const Icon(Icons.task_alt, color: Colors.blue),
                          title: Text('Fix #0${index + 1}: Áp dụng ràng buộc kích thước'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
