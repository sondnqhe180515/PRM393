// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

/// Exercise 2: Input Widgets
/// Minh họa các widget nhận tương tác và điều khiển giá trị người dùng:
/// - Slider (Thanh trượt chọn mức rating)
/// - Switch (Công tắc bật / tắt trạng thái)
/// - RadioListTile (Nhóm radio button chọn thể loại phim)
/// - showDatePicker (Hộp thoại chọn ngày)
class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  // 1. Biến lưu giá trị Rating của Slider (mặc định là 50)
  double _rating = 50.0;

  // 2. Biến lưu trạng thái bật/tắt của Switch
  bool _isActive = false;

  // 3. Biến lưu thể loại được chọn từ RadioListTile (Action, Comedy, hoặc null)
  String? _selectedGenre;

  // 4. Biến lưu ngày được chọn từ DatePicker
  DateTime? _selectedDate;

  /// Hàm mở hộp thoại chọn ngày (DatePicker)
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2 – Input Controls Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------------------------------
            // SECTION 1: Rating (Slider)
            // ----------------------------------------------------
            const Text(
              'Rating (Slider)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _rating,
              min: 0,
              max: 100,
              divisions: 100,
              label: _rating.round().toString(),
              onChanged: (double newValue) {
                setState(() {
                  _rating = newValue;
                });
              },
            ),
            Text(
              'Current value: ${_rating.round()}',
              style: const TextStyle(color: Colors.black87),
            ),
            const Divider(height: 32),

            // ----------------------------------------------------
            // SECTION 2: Active (Switch)
            // ----------------------------------------------------
            const Text(
              'Active (Switch)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Is movie active?',
                  style: TextStyle(fontSize: 14),
                ),
                Switch(
                  value: _isActive,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isActive = newValue;
                    });
                  },
                ),
              ],
            ),
            const Divider(height: 32),

            // ----------------------------------------------------
            // SECTION 3: Genre (RadioListTile)
            // ----------------------------------------------------
            const Text(
              'Genre (RadioListTile)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: const Text('Action'),
              value: 'Action',
              groupValue: _selectedGenre,
              contentPadding: EdgeInsets.zero,
              onChanged: (String? value) {
                setState(() {
                  _selectedGenre = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Comedy'),
              value: 'Comedy',
              groupValue: _selectedGenre,
              contentPadding: EdgeInsets.zero,
              onChanged: (String? value) {
                setState(() {
                  _selectedGenre = value;
                });
              },
            ),
            Text(
              'Selected genre: ${_selectedGenre ?? "None"}',
              style: const TextStyle(color: Colors.black87),
            ),
            const Divider(height: 32),

            // ----------------------------------------------------
            // SECTION 4: Date Picker
            // ----------------------------------------------------
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  _selectedDate == null
                      ? 'Open Date Picker'
                      : 'Selected Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
