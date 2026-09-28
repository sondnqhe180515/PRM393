// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import '../dao/product_dao.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

/// Màn hình Danh sách sản phẩm (Products Screen)
/// Đáp ứng các yêu cầu:
/// - Yêu cầu 2: Sử dụng ProductDAO (getAllProduct, findProductByName)
/// - Yêu cầu 3 (4đ): Giao diện hiển thị danh sách sản phẩm theo đúng quy tắc responsive:
///   + Chiều rộng <= 500:
///       * Thẳng đứng (portrait): 1 cột
///       * Nằm ngang (landscape): 2 cột
///   + Chiều rộng >= 500:
///       * Thẳng đứng (portrait): 2 cột
///       * Nằm ngang (landscape): 3 cột
///   + Kích thước chiều rộng mỗi cột tùy biến theo widget cha chứa sản phẩm (LayoutBuilder)
/// - Yêu cầu 4 (2đ): Nhấn vào sản phẩm chuyển sang màn hình ProductDetailScreen
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductDAO _productDAO = ProductDAO();
  final TextEditingController _searchController = TextEditingController();

  List<Product> _displayedProducts = [];
  int _currentBottomNavIndex = 0; // Tab Home đang được chọn

  @override
  void initState() {
    super.initState();
    // Tải danh sách ban đầu thông qua getAllProduct() của ProductDAO
    _displayedProducts = _productDAO.getAllProduct();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Hàm tìm kiếm sản phẩm theo tên sử dụng phương thức findProductByName() của ProductDAO
  void _onSearchChanged(String query) {
    setState(() {
      _displayedProducts = _productDAO.findProductByName(query);
    });
  }

  /// Tính toán số cột (crossAxisCount) theo đúng công thức của đề bài:
  /// - width <= 500:
  ///     thẳng đứng -> 1 cột
  ///     nằm ngang  -> 2 cột
  /// - width >= 500:
  ///     thẳng đứng -> 2 cột
  ///     nằm ngang  -> 3 cột
  int _calculateColumnCount(double parentWidth, Orientation orientation) {
    final isPortrait = orientation == Orientation.portrait;

    if (parentWidth <= 500) {
      return isPortrait ? 1 : 2;
    } else {
      return isPortrait ? 2 : 3;
    }
  }

  /// Mở màn hình chi tiết sản phẩm
  void _openProductDetail(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2), // Màu xanh dương chuẩn theo ảnh
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ----------------------------------------------------
            // 1. THANH TÌM KIẾM (Search Bar) giống ảnh mẫu
            // ----------------------------------------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.08),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF64748B),
                      size: 22,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              _onSearchChanged('');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),

            // ----------------------------------------------------
            // 2. DANH SÁCH SẢN PHẨM RESPONSIVE (Yêu cầu 3)
            // ----------------------------------------------------
            Expanded(
              child: _displayedProducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No products found matching "${_searchController.text}"',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        // Lấy kích thước widget cha chứa sản phẩm
                        final parentWidth = constraints.maxWidth;
                        final orientation = MediaQuery.of(context).orientation;

                        // Tính số cột theo đúng yêu cầu đề bài
                        final columnCount = _calculateColumnCount(
                          parentWidth,
                          orientation,
                        );

                        // Tính tỷ lệ khung hình (childAspectRatio) để card hiển thị đẹp mắt, không tràn viền
                        final double horizontalPadding = 16.0;
                        final double spacing = 12.0;
                        final double availableWidth = parentWidth -
                            (horizontalPadding * 2) -
                            (spacing * (columnCount - 1));
                        final double itemWidth = availableWidth / columnCount;

                        // Nếu item đủ rộng (>260px) thì dùng card ngang (cao ~96px)
                        // Nếu item hẹp hơn (khi chia 2-3 cột trên màn nhỏ) thì dùng card dọc (cao ~180px)
                        final double itemHeight = itemWidth > 260 ? 96.0 : 180.0;
                        final double childAspectRatio = itemWidth / itemHeight;

                        return GridView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: columnCount,
                            crossAxisSpacing: spacing,
                            mainAxisSpacing: spacing,
                            childAspectRatio: childAspectRatio,
                          ),
                          itemCount: _displayedProducts.length,
                          itemBuilder: (context, index) {
                            final product = _displayedProducts[index];
                            return ProductCard(
                              product: product,
                              onTap: () => _openProductDetail(product),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // ----------------------------------------------------
      // 3. BOTTOM NAVIGATION BAR (Home, Product Detail, Cart)
      // ----------------------------------------------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        selectedItemColor: const Color(0xFF1976D2),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentBottomNavIndex = index;
          });
          if (index == 1 && _displayedProducts.isNotEmpty) {
            _openProductDetail(_displayedProducts.first);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list_outlined),
            label: 'Product Detail',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
