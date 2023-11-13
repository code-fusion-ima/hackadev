import 'package:flutter/material.dart';
import 'product_add.dart';
import 'api_service.dart';

class ProductManagement extends StatefulWidget {
  @override
  _ProductManagement createState() => _ProductManagement();
}

class _ProductManagement extends State<ProductManagement> {
  List<dynamic> products = [];
  List<String> categories = [];

  ApiService apiService = ApiService(); // Instância da ApiService

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Alteração para chamar a função correta
  }

  Future<void> fetchProducts() async {
    try {
      List<dynamic> fetchedProducts = await apiService.getProducts(); // Utilizando a função da ApiService
      setState(() {
        var categorySet = Set<String>.from(fetchedProducts.map((product) => product['category']));
        categories = categorySet.toList();
        products = fetchedProducts;
      });
    } catch (e) {
      throw Exception('Falha ao carregar os produtos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Categorias'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _navigateToAddProductPage(categories[index]);
            },
            child: ListTile(
              title: Text(categories[index]), // Exibindo cada categoria
            ),
          );
        },
      ),
    );
  }

  // Função para navegar para a página AddProduct com a categoria selecionada
  void _navigateToAddProductPage(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProduct(category: category),
      ),
    );
  }
}
