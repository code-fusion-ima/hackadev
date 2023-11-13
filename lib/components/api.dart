import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product.dart';

class Api {
 static const String baseUrl = 'http://localhost:8000/api/produtos';

 Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
 }
}