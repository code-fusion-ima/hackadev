class Product {
  final String name;
  final String description;
  final String category;
  final String manufacturer;
  final double price;
  final int stockQuantity;
  final String imagePath;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Product({
    required this.name,
    required this.description,
    required this.category,
    required this.manufacturer,
    required this.price,
    required this.stockQuantity,
    required this.imagePath,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      description: json['description'],
      category: json['category'],
      manufacturer: json['manufacturer'],
      price: json['price'].toDouble(),
      stockQuantity: json['stockQuantity'],
      imagePath: json['imagePath'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
    );
  }
}
