import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiService {
 final String url = 'http://localhost:8000/api/produtos';

 Future<List<dynamic>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(url));
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Falha ao buscar produtos');
    }
 }
}