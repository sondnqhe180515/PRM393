/// Model đại diện cho một sản phẩm trong ứng dụng
/// Yêu cầu 1 (2đ): Xây dựng lớp Product gồm các thuộc tính:
/// (id, Name, description, price, discountPercen, image)
class Product {
  final int id;
  // ignore: non_constant_identifier_names
  final String Name;
  final String description;
  final double price;
  final double discountPercen;
  final String image;

  const Product({
    required this.id,
    required this.Name,
    required this.description,
    required this.price,
    required this.discountPercen,
    required this.image,
  });

  /// Getter phụ trợ theo chuẩn Dart (cho phép truy cập cả product.name lẫn product.Name)
  String get name => Name;

  /// Tính giá bán sau khi áp dụng phần trăm giảm giá (discountPercen)
  double get discountedPrice {
    final discountAmount = price * (discountPercen / 100);
    return price - discountAmount;
  }

  /// Định dạng chuỗi hiển thị giá gốc (VD: $1099 hoặc $999)
  String get formattedOriginalPrice {
    return price % 1 == 0
        ? '\$${price.toInt()}'
        : '\$${price.toStringAsFixed(2)}';
  }

  /// Định dạng chuỗi hiển thị giá sau giảm (VD: $999 hoặc $899)
  String get formattedDiscountedPrice {
    final dPrice = discountedPrice;
    return dPrice % 1 == 0
        ? '\$${dPrice.toInt()}'
        : '\$${dPrice.toStringAsFixed(2)}';
  }

  /// Định dạng phần trăm giảm giá (VD: -9%, -10%)
  String get formattedDiscountBadge {
    final rounded = discountPercen % 1 == 0
        ? discountPercen.toInt()
        : discountPercen.toStringAsFixed(1);
    return '-$rounded%';
  }

  /// Khởi tạo đối tượng Product từ Map/JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      Name: (json['Name'] ?? json['name']) as String,
      description: (json['description'] ?? '') as String,
      price: (json['price'] as num).toDouble(),
      discountPercen: (json['discountPercen'] ?? json['discountPercent'] as num).toDouble(),
      image: (json['image'] ?? '') as String,
    );
  }

  /// Chuyển đối tượng Product sang Map/JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': Name,
      'description': description,
      'price': price,
      'discountPercen': discountPercen,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, Name: $Name, price: $price, discountPercen: $discountPercen, image: $image)';
  }
}
