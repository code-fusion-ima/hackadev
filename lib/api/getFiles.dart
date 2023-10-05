import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductAPI {
  final int id;
  final String name;
  final double price;
  final String imagePath;
  final bool isFavorite;
  final String description;
  final String category;
  final bool isAddedToCart;
  final String manufacturer;
  final int stockQuantity;

  ProductAPI({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.isFavorite,
    required this.description,
    required this.category,
    required this.isAddedToCart,
    required this.manufacturer,
    required this.stockQuantity,
  });

  // Construtor de fábrica para criar um objeto ProductAPI a partir de um mapa (JSON).
  factory ProductAPI.fromJson(Map<String, dynamic> json) {
    return ProductAPI(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imagePath: json['imagePath'],
      isFavorite: json['isFavorite'],
      description: json['description'],
      category: json['category'],
      isAddedToCart: json['isAddedToCart'],
      manufacturer: json['manufacturer'],
      stockQuantity: json['stockQuantity'],
    );
  }
}

Future<ProductAPI?> fetchProduct(int? id) async {
  final url = Uri.parse('http://localhost:3000/products/$id');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // A resposta da API foi bem-sucedida
    final productJson = json.decode(response.body);

    // Crie um objeto ProductAPI usando o construtor de fábrica
    final product = ProductAPI.fromJson(productJson);

    return product;
  } else {
    // A chamada da API falhou, você pode tratar os erros aqui
    print('Falha na chamada da API: ${response.statusCode}');
    return null; // Retorna null em caso de falha na chamada da API
  }
}
