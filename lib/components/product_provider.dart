import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Crie uma classe Provider
class ProductProvider extends ChangeNotifier {
  List<Map<String, dynamic>> products = [];
  List<String> categories = [];

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/api/produtos'));

    if (response.statusCode == 200) {
      List<dynamic> productsData = json.decode(response.body)['produtos'];
      products = productsData.cast<Map<String, dynamic>>();

      // Categorias dos produtos cadastrados no Banco de Dados
      categories = products
          .map((product) => product['categoria'].toString())
          .toSet()
          .toList();

      notifyListeners();
    } else {
      print('Falha ao recuperar produtos');
    }
  }
}
