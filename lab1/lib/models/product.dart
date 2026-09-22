class Product {
  int id;
  String name;
  int quantity;
  double price;
  String? image;
  String? description;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.image,
    this.description,
  });

  // Getter
  int get getId => id;
  String get getName => name;
  int get getQuantity => quantity;
  double get getPrice => price;
  String? get getImage => image;
  String? get getDescription => description;

  // Setter
  set setId(int id) => this.id = id;
  set setName(String name) => this.name = name;
  set setQuantity(int quantity) => this.quantity = quantity;
  set setPrice(double price) => this.price = price;
  set setImage(String? image) => this.image = image;
  set setDescription(String? description) => this.description = description;

  // Factory fromJson
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      description: json['description'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'image': image,
      'description': description,
    };
  }

  // copyTo
  Product copyTo({
    int? id,
    String? name,
    int? quantity,
    double? price,
    String? image,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }
}