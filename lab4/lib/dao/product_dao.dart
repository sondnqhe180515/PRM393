import '../models/product.dart';

/// Lớp DAO (Data Access Object) quản lý dữ liệu sản phẩm
/// Yêu cầu 2 (2đ): Xây dựng lớp ProductDAO gồm các phương thức:
/// - getAllProduct()
/// - findProductByName(String name)
class ProductDAO {
  /// Danh sách sản phẩm mẫu theo đúng thiết kế và hình ảnh trong đề bài Lab 4
  static final List<Product> _products = [
    const Product(
      id: 1,
      Name: 'iPhone 15',
      description:
          'Experience the latest technology with the new iPhone 15. Stunning design, powerful performance with A16 Bionic chip, and 48MP Main camera with 2x Telephoto.',
      price: 1099.0,
      discountPercen: 9.0,
      image:
          'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=600&auto=format&fit=crop&q=80',
    ),
    const Product(
      id: 2,
      Name: 'Samsung S24',
      description:
          'Galaxy AI is here. Experience epic artificial intelligence features, brilliant Dynamic AMOLED 2X 120Hz display, and all-day intelligent battery life.',
      price: 999.0,
      discountPercen: 10.0,
      image:
          'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=600&auto=format&fit=crop&q=80',
    ),
    const Product(
      id: 3,
      Name: 'MacBook Air',
      description:
          'Supercharged by M3 chip, MacBook Air is strikingly thin and brings up to 18 hours of battery life with a gorgeous Liquid Retina display and 1080p FaceTime HD camera.',
      price: 1299.0,
      discountPercen: 7.0,
      image:
          'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600&auto=format&fit=crop&q=80',
    ),
    const Product(
      id: 4,
      Name: 'iPad Pro 11"',
      description:
          'Astonishing performance and breakthrough Ultra Retina XDR display powered by the revolutionary M4 chip with pro cameras and LiDAR scanner.',
      price: 999.0,
      discountPercen: 5.0,
      image:
          'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=600&auto=format&fit=crop&q=80',
    ),
    const Product(
      id: 5,
      Name: 'Apple Watch Series 9',
      description:
          'Smarter, brighter, mightier. Introducing double tap gesture, an even brighter display, advanced health sensors, and precision finding for iPhone.',
      price: 429.0,
      discountPercen: 12.0,
      image:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600&auto=format&fit=crop&q=80',
    ),
    const Product(
      id: 6,
      Name: 'AirPods Pro 2',
      description:
          'Up to 2x more Active Noise Cancellation, Adaptive Audio, Personalized Spatial Audio, and Transparency mode for the ultimate personal sound experience.',
      price: 249.0,
      discountPercen: 15.0,
      image:
          'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=600&auto=format&fit=crop&q=80',
    ),
  ];

  /// Phương thức lấy toàn bộ danh sách sản phẩm
  List<Product> getAllProduct() {
    return List.unmodifiable(_products);
  }

  /// Phương thức tìm kiếm sản phẩm theo tên (không phân biệt chữ hoa/thường)
  List<Product> findProductByName(String name) {
    if (name.trim().isEmpty) {
      return getAllProduct();
    }
    final query = name.trim().toLowerCase();
    return _products
        .where((product) => product.Name.toLowerCase().contains(query))
        .toList();
  }

  /// Cung cấp thêm static methods để thuận tiện gọi trực tiếp khi cần
  static List<Product> getAllProducts() {
    return List.unmodifiable(_products);
  }

  static List<Product> searchByName(String name) {
    if (name.trim().isEmpty) {
      return getAllProducts();
    }
    final query = name.trim().toLowerCase();
    return _products
        .where((product) => product.Name.toLowerCase().contains(query))
        .toList();
  }
}
