class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String category;
  final String manufacturer;
  final int stockQuantity;
  final String productCode;
  final bool isFavorite;
  final String imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.manufacturer,
    required this.stockQuantity,
    required this.productCode,
    required this.isFavorite,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      manufacturer: json['manufacturer'],
      stockQuantity: json['stockquantity'] as int,
      productCode: json['productcode'],
      isFavorite: json['isfavorite'] as bool,
      imagePath: json['imagepath'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
} 