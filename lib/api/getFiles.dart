import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchProducts() async {
  final url = Uri.parse('http://localhost:3000/products');
  final response = await http.get(url);
  print('teste');
  var userdata = [];

  if (response.statusCode == 200) {
    var getdat = jsonDecode(response.body);

    for (var a = 0; a < getdat.length; a++) {
      var obj = {
        "id": getdat[a]['id'],
        "name": getdat[a]['name'],
        "price": getdat[a]['price'],
        "imagePath": getdat[a]['imagePath'],
        "description": getdat[a]['description'],
        "category": getdat[a]['category'],
        "isFavorite": getdat[a]['isFavorite'],
        "isAddedToCart": getdat[a]['isAddedToCart'],
        "manufacturer": getdat[a]['manufacturer'],
        "stockQuantity": getdat[a]['stockQuantity']
      };
      userdata.add(obj);
    }

    return userdata;
  } else {
    print('Falha na chamada da API: ${response.statusCode}');
    throw Exception('Não foi possível obter os dados da API');
  }
}