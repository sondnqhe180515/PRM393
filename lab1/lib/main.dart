import 'models/product.dart';

void main() {
  // 1. Test Constructor
  Product product = Product(
    id: 1,
    name: 'iPhone 16 Pro Max',
    quantity: 10,
    price: 29990000,
    image: 'iphone.jpg',
    description: 'Điện thoại Apple',
  );

  print('=== CONSTRUCTOR ===');
  print('ID: ${product.id}');
  print('Name: ${product.name}');
  print('Quantity: ${product.quantity}');
  print('Price: ${product.price}');
  print('Image: ${product.image}');
  print('Description: ${product.description}');

  // 2. Test Getter
  print('\n=== GETTER ===');
  print('Name: ${product.getName}');
  print('Price: ${product.getPrice}');

  // 3. Test Setter
  product.setQuantity = 20;
  product.setPrice = 28990000;

  print('\n=== SETTER ===');
  print('Quantity after setter: ${product.getQuantity}');
  print('Price after setter: ${product.getPrice}');

  // 4. Test fromJson
  Map<String, dynamic> json = {
    'id': 2,
    'name': 'Samsung Galaxy S25',
    'quantity': 5,
    'price': 24990000,
    'image': 's25.jpg',
    'description': 'Điện thoại Samsung',
  };

  Product productFromJson = Product.fromJson(json);

  print('\n=== FROM JSON ===');
  print('Name: ${productFromJson.name}');
  print('Price: ${productFromJson.price}');

  // 5. Test toJson
  Map<String, dynamic> productJson = product.toJson();

  print('\n=== TO JSON ===');
  print(productJson);

  // 6. Test copyTo
  Product copiedProduct = product.copyTo(
    name: 'iPhone 16 Pro Max - New',
    price: 27990000,
  );

  print('\n=== COPY TO ===');
  print('Original name: ${product.name}');
  print('Copied name: ${copiedProduct.name}');
  print('Original price: ${product.price}');
  print('Copied price: ${copiedProduct.price}');
}