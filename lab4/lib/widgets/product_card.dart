// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import '../models/product.dart';

/// Widget hiển thị thẻ sản phẩm (Product Card)
/// Thiết kế chuẩn pixel theo hình ảnh đề bài:
/// - Ảnh sản phẩm bo góc bên trái
/// - Tên sản phẩm, giá gốc gạch ngang và giá sau giảm màu đỏ ở giữa
/// - Badge giảm giá màu đỏ (VD: -9%, -10%) ở bên phải
/// - Tự động thích ứng (responsive) theo chiều rộng của cột
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        // Nếu độ rộng của cột > 280 thì dùng layout hàng ngang (như hình mẫu điện thoại)
        // Nếu độ rộng hẹp hơn (khi chia 2-3 cột trên màn hình nhỏ) thì dùng layout cột dọc tránh tràn viền
        final isHorizontal = cardWidth > 260;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black.withOpacity(0.06), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: isHorizontal
                  ? _buildHorizontalLayout(context)
                  : _buildVerticalLayout(context),
            ),
          ),
        );
      },
    );
  }

  /// Layout dạng ngang theo đúng ảnh mẫu đề bài
  Widget _buildHorizontalLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Ảnh sản phẩm bo góc
        _buildProductImage(width: 72, height: 72),
        const SizedBox(width: 14),

        // Thông tin: Tên sản phẩm, giá gốc & giá giảm
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                product.Name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    product.formattedOriginalPrice,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    product.formattedDiscountedPrice,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE11D48), // Màu đỏ nổi bật
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Badge phần trăm giảm giá màu đỏ bên phải
        _buildDiscountBadge(),
      ],
    );
  }

  /// Layout dạng dọc cho trường hợp chia nhiều cột hẹp
  Widget _buildVerticalLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Center(child: _buildProductImage(width: double.infinity, height: 110)),
            Positioned(
              top: 4,
              right: 4,
              child: _buildDiscountBadge(),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          product.Name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              product.formattedOriginalPrice,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              product.formattedDiscountedPrice,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE11D48),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Badge giảm giá bo góc màu đỏ
  Widget _buildDiscountBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE11D48),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        product.formattedDiscountBadge,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  /// Widget hiển thị ảnh sản phẩm có xử lý loading và error
  Widget _buildProductImage({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        product.image,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(
              Icons.devices_other_rounded,
              color: Colors.blue.shade400,
              size: height > 70 ? 36 : 28,
            ),
          );
        },
      ),
    );
  }
}
