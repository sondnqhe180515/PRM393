import 'package:flutter/material.dart';

/// Exercise 5: Debug & Fix Common UI Errors
/// Mục tiêu: Hiểu rõ các lỗi bố cục và cập nhật giao diện thường gặp trong Flutter và cách khắc phục:
/// 1. Fix ListView inside Column using Expanded.
/// 2. Fix overflow in small screens using SingleChildScrollView.
/// 3. Fix state update issue by adding setState().
/// 4. Fix DatePicker build context errors by calling from valid widget tree.
class CommonFixesDemo extends StatefulWidget {
  const CommonFixesDemo({super.key});

  @override
  State<CommonFixesDemo> createState() => _CommonFixesDemoState();
}

class _CommonFixesDemoState extends State<CommonFixesDemo> {
  // Tab hiện tại (0: Task 1, 1: Task 2, 2: Task 3, 3: Task 4)
  int _currentTaskIndex = 0;

  // State cho Task 3: setState demo
  int _likeCount = 0;
  String _stateStatusMessage = 'Chưa có thao tác nào.';

  // State cho Task 4: DatePicker demo
  DateTime? _selectedDate;

  // State cho Task 2: toggle xem có bật SingleChildScrollView hay không
  bool _useScrollView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5 – Common UI Errors'),
      ),
      body: _buildCurrentTask(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTaskIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF3F51B5),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentTaskIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Task 1: Expanded',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_vertical_circle_outlined),
            label: 'Task 2: Scroll',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: 'Task 3: setState',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Task 4: DatePicker',
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentTask() {
    switch (_currentTaskIndex) {
      case 0:
        return _buildTask1Expanded();
      case 1:
        return _buildTask2ScrollView();
      case 2:
        return _buildTask3SetState();
      case 3:
        return _buildTask4DatePicker();
      default:
        return _buildTask1Expanded();
    }
  }

  // ===========================================================================
  // TASK 1: Fix ListView inside Column using Expanded (Khớp 100% hình ảnh đề bài)
  // ===========================================================================
  Widget _buildTask1Expanded() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final movies = ['Movie A', 'Movie B', 'Movie C', 'Movie D'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tiêu đề Task 1 chính xác theo ảnh đề bài
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Text(
            'Correct ListView inside Column using Expanded',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),

        // Khắc phục: Bọc ListView.builder bằng Expanded để giới hạn chiều cao
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.movie,
                      size: 20,
                      color: isDark ? Colors.white70 : const Color(0xFF5A6065),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      movies[index],
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // Ghi chú giải thích phương pháp sửa lỗi
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E2838) : const Color(0xFFE8F4FD),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue.shade300),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.blue),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Lỗi thường gặp: Đặt ListView trực tiếp trong Column gây lỗi "Vertical viewport was given unbounded height".\n'
                  'Khắc phục: Bọc ListView bằng widget Expanded.',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // TASK 2: Fix overflow in small screens using SingleChildScrollView
  // ===========================================================================
  Widget _buildTask2ScrollView() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task 2: Fix Overflow with SingleChildScrollView',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Khi nội dung màn hình vượt quá chiều cao cho phép (nhất là trên thiết bị màn hình nhỏ hoặc khi bật bàn phím), Flutter sẽ báo lỗi "RenderFlex overflowed by ... pixels".\n'
                'Khắc phục bằng cách bọc Column trong SingleChildScrollView.',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
              const SizedBox(height: 12),
              // Nút bật/tắt để thử nghiệm
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _useScrollView ? 'Bọc trong ScrollView: BẬT' : 'Bọc trong ScrollView: TẮT',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: _useScrollView,
                    onChanged: (val) {
                      setState(() {
                        _useScrollView = val;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        // Danh sách các form field / box mô phỏng nội dung dài
        ...List.generate(6, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E24) : const Color(0xFFF4F5F9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? Colors.white10 : Colors.black12,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.movie_creation_outlined, color: Colors.blue),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Movie Form Field #${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Content scrollable without overflow warning',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 20),
      ],
    );

    return _useScrollView
        ? SingleChildScrollView(child: content)
        : content;
  }

  // ===========================================================================
  // TASK 3: Fix state update issue by adding setState()
  // ===========================================================================
  Widget _buildTask3SetState() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Task 3: Fix State Update by adding setState()',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Lỗi thường gặp: Thay đổi giá trị biến trạng thái nhưng không gọi setState(). Khi đó Flutter không nhận được thông báo để gọi lại phương thức build(), dẫn đến UI bị đóng băng không đổi.',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          const SizedBox(height: 20),

          // Khung hiển thị bộ đếm Like
          Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E24) : const Color(0xFFF4F5F9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  const Icon(Icons.thumb_up_alt_rounded, size: 48, color: Colors.blue),
                  const SizedBox(height: 8),
                  Text(
                    '$_likeCount',
                    style: const TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const Text(
                    'Movie Likes Counter',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Trạng thái thao tác
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? Colors.black26 : Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.shade300),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.amber),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _stateStatusMessage,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.amber.shade200 : Colors.amber.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Nút 1: KHÔNG DÙNG setState (Minh họa lỗi)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                // LỖI: Tăng biến trực tiếp mà không bọc trong setState()
                _likeCount++;
                // Lưu ý: Không dùng setState nên UI vẫn hiển thị số cũ
                _stateStatusMessage =
                    'Đã tăng biến _likeCount lên $_likeCount trong bộ nhớ, nhưng UI KHÔNG đổi vì chưa gọi setState()!';
              },
              icon: const Icon(Icons.cancel_outlined, color: Colors.red),
              label: const Text(
                '1. Tăng like KHÔNG CÓ setState() (Lỗi)',
                style: TextStyle(color: Colors.red),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Nút 2: CÓ DÙNG setState (Khắc phục chuẩn)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // CHUẨN: Bọc logic cập nhật trạng thái trong setState()
                setState(() {
                  _likeCount++;
                  _stateStatusMessage =
                      'Đã cập nhật UI thành công lên $_likeCount nhờ gọi setState()!';
                });
              },
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('2. Tăng like CÓ setState() (Đã fix)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TASK 4: Fix DatePicker build context errors by calling from valid widget tree
  // ===========================================================================
  Widget _buildTask4DatePicker() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Task 4: Fix DatePicker BuildContext Errors',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Lỗi thường gặp:\n'
            '1. Gọi showDatePicker() trực tiếp bên trong hàm build() làm crash ứng dụng với lỗi "setState() or markNeedsBuild() called during build".\n'
            '2. Sử dụng BuildContext chưa gắn vào cây widget Navigator.\n'
            '3. Không kiểm tra "if (!mounted) return;" sau thao tác async await.\n\n'
            'Khắc phục:\n'
            '- Chỉ gọi showDatePicker() bên trong sự kiện tương tác của người dùng (onPressed).\n'
            '- Truyền context hợp lệ và dùng if (picked != null && mounted) setState(...).',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white70 : Colors.black54,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),

          // Thẻ hiển thị ngày đã chọn
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E24) : const Color(0xFFF4F5F9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? Colors.white10 : Colors.black12,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.event, color: Colors.blue, size: 32),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Movie Release Date:',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _selectedDate == null
                          ? 'Chưa chọn ngày'
                          : '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Nút kích hoạt DatePicker theo cách chuẩn
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _pickReleaseDate(context),
              icon: const Icon(Icons.calendar_today),
              label: const Text('Open Date Picker (Valid Context)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3F51B5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Hàm mở DatePicker đúng chuẩn:
  /// - Được gọi từ onPressed callback, không bao giờ gọi trong build()
  /// - Sử dụng BuildContext hợp lệ
  /// - Kiểm tra mounted sau khi await trước khi gọi setState
  Future<void> _pickReleaseDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF3F51B5),
              brightness: Theme.of(context).brightness,
            ),
          ),
          child: child!,
        );
      },
    );

    // Kiểm tra tính hợp lệ và widget còn mounted trước khi gọi setState
    if (picked != null && mounted) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
