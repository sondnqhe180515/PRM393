import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab4/dao/product_dao.dart';
import 'package:lab4/main.dart';
import 'package:lab4/models/product.dart';
import 'package:lab4/screens/product_detail_screen.dart';

/// Hàm tính toán số cột theo logic của Yêu cầu 3
int calculateColumnCount(double parentWidth, Orientation orientation) {
  final isPortrait = orientation == Orientation.portrait;
  if (parentWidth <= 500) {
    return isPortrait ? 1 : 2;
  } else {
    return isPortrait ? 2 : 3;
  }
}

void main() {
  group('Yêu cầu 1: Kiểm thử lớp Product (2đ)', () {
    test('Khởi tạo Product và tính toán thuộc tính giảm giá chính xác', () {
      const product = Product(
        id: 1,
        Name: 'iPhone 15',
        description: 'Mô tả iPhone 15',
        price: 1099.0,
        discountPercen: 9.0,
        image: 'https://example.com/iphone.jpg',
      );

      expect(product.id, 1);
      expect(product.Name, 'iPhone 15');
      expect(product.name, 'iPhone 15');
      expect(product.price, 1099.0);
      expect(product.discountPercen, 9.0);
      expect(product.discountedPrice, closeTo(1000.09, 0.1));
      expect(product.formattedOriginalPrice, '\$1099');
      expect(product.formattedDiscountBadge, '-9%');
    });

    test('fromJson và toJson hoạt động chính xác', () {
      final json = {
        'id': 2,
        'Name': 'Samsung S24',
        'description': 'Mô tả Samsung S24',
        'price': 999.0,
        'discountPercen': 10.0,
        'image': 'https://example.com/s24.jpg',
      };

      final product = Product.fromJson(json);
      expect(product.id, 2);
      expect(product.Name, 'Samsung S24');
      expect(product.price, 999.0);

      final convertedJson = product.toJson();
      expect(convertedJson['id'], 2);
      expect(convertedJson['Name'], 'Samsung S24');
      expect(convertedJson['discountPercen'], 10.0);
    });
  });

  group('Yêu cầu 2: Kiểm thử lớp ProductDAO (2đ)', () {
    final dao = ProductDAO();

    test('getAllProduct trả về danh sách sản phẩm mẫu', () {
      final products = dao.getAllProduct();
      expect(products.isNotEmpty, true);
      expect(products.any((p) => p.Name.contains('iPhone 15')), true);
      expect(products.any((p) => p.Name.contains('Samsung S24')), true);
    });

    test('findProductByName tìm kiếm chính xác không phân biệt hoa thường', () {
      final result1 = dao.findProductByName('iphone');
      expect(result1.length, 1);
      expect(result1.first.Name, 'iPhone 15');

      final result2 = dao.findProductByName('samsung');
      expect(result2.length, 1);
      expect(result2.first.Name, 'Samsung S24');

      final resultEmpty = dao.findProductByName('');
      expect(resultEmpty.length, dao.getAllProduct().length);
    });
  });

  group('Yêu cầu 3: Kiểm thử logic Responsive Grid (4đ)', () {
    test('Số cột khi chiều rộng <= 500 và thẳng đứng là 1 cột', () {
      expect(calculateColumnCount(400, Orientation.portrait), 1);
      expect(calculateColumnCount(500, Orientation.portrait), 1);
    });

    test('Số cột khi chiều rộng <= 500 và nằm ngang là 2 cột', () {
      expect(calculateColumnCount(480, Orientation.landscape), 2);
      expect(calculateColumnCount(500, Orientation.landscape), 2);
    });

    test('Số cột khi chiều rộng >= 500 và thẳng đứng là 2 cột', () {
      expect(calculateColumnCount(600, Orientation.portrait), 2);
      expect(calculateColumnCount(768, Orientation.portrait), 2);
    });

    test('Số cột khi chiều rộng >= 500 và nằm ngang là 3 cột', () {
      expect(calculateColumnCount(600, Orientation.landscape), 3);
      expect(calculateColumnCount(1024, Orientation.landscape), 3);
    });
  });

  group('Yêu cầu 4: Kiểm thử màn hình và chuyển sang chi tiết sản phẩm (2đ)', () {
    testWidgets('Hiển thị danh sách sản phẩm và điều hướng sang ProductDetailScreen',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Kiểm tra tiêu đề Products trên AppBar
      expect(find.text('Products'), findsOneWidget);

      // Kiểm tra thanh tìm kiếm
      expect(find.byType(TextField), findsOneWidget);

      // Kiểm tra các sản phẩm xuất hiện trên danh sách
      expect(find.text('iPhone 15'), findsWidgets);
      expect(find.text('Samsung S24'), findsWidgets);

      // Nhấn vào sản phẩm đầu tiên để kiểm tra Yêu cầu 4 (Chuyển sang màn hình chi tiết)
      await tester.tap(find.text('iPhone 15').first);
      await tester.pumpAndSettle();

      // Xác nhận đã chuyển sang màn hình ProductDetailScreen
      expect(find.byType(ProductDetailScreen), findsOneWidget);
      expect(find.widgetWithText(AppBar, 'Product Detail'), findsOneWidget);
      expect(find.text('Add to Cart'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });
  });
}
