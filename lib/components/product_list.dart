import 'package:flutter/material.dart';
import 'bottom_bar.dart';
import 'product_detail.dart';
import 'package:intl/intl.dart';
import 'custom_app_bar.dart';
import 'dart:convert';
import 'package:flutter/services.dart'; // Para carregar o JSON do arquivo local.

Future<List<Product>> loadProductsFromJson() async {
  final jsonString = await rootBundle.loadString('back/product.json');

  final List<dynamic> jsonList = json.decode(jsonString)['products'];

  final List<Product> products = jsonList.map((json) {
    return Product(
        id: json['id'],
        name: json['name'],
        price: json['price'].toDouble(),
        imagePath: json['imagePath'],
        description: json['description'],
        category: json['category'],
        isFavorite: json['isFavorite'],
        isAddedToCart: json['isAddedToCart'],
        manufacturer: json['manufacturer'],
        stockQuantity: json['stockQuantity']);
  }).toList();

  return products; // Retorna a lista de produtos.
}

// Função que formata o preço dos produtos em string (moeda brasileira)
String formatPrice(double price) {
  final NumberFormat formatoMoeda =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  return formatoMoeda.format(price);
}

class ProductList extends StatefulWidget {
  final String category;

  const ProductList({required this.category, Key? key}) : super(key: key);

  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends State<ProductList> {
  late List<Product> products = []; // Lista de produtos carregada do JSON.

  @override
  void initState() {
    super.initState();
    loadProductsFromJson().then((loadedProducts) {
      setState(() {
        products = loadedProducts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Verifique se os produtos foram carregados antes de construir a interface.
    if (products == null) {
      return CircularProgressIndicator(); // Mostrar um indicador de carregamento, por exemplo.
    }

    // Filtra os produtos pela categoria selecionada.
    List<Product> filteredProducts = products
        .where((product) => product.category == widget.category)
        .toList();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Produtos da Categoria: ${widget.category}',
        backgroundColor: const Color.fromARGB(255, 217, 70, 119),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 15.0),
          // Grade de cartões de produtos.
          Container(
            padding: const EdgeInsets.only(right: 5.0, left: 5.0),
            width: MediaQuery.of(context).size.width - 30.0,
            height: MediaQuery.of(context).size.height - 50.0,
            child: GridView.count(
              crossAxisCount: 2,
              primary: false,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: 0.8,
              children: filteredProducts.map((product) {
                return _buildCard(
                  product,
                  context,
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 15.0),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

// Função para construir um widget de cartão de produto.
Widget _buildCard(Product product, context) {
  return Padding(
    padding:
        const EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0, right: 3.0),
    child: InkWell(
      onTap: () {
        // Navega para a página de detalhes do produto.
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetail(id: product.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD155A8).withOpacity(0.2),
              spreadRadius: 3.0,
              blurRadius: 5.0,
            )
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  product.isFavorite
                      ? const Icon(Icons.favorite, color: Color(0xFFD155A8))
                      : const Icon(Icons.favorite_border,
                          color: Color(0xFFD155A8)),
                ],
              ),
            ),
            Hero(
              tag: product.imagePath ??
                  '', // Use uma string vazia como valor padrão
              child: Container(
                height: 80.0,
                width: 80.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(product.imagePath ??
                        ''), // Use uma string vazia como valor padrão
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 3.5),
            Text(
              formatPrice(product.price),
              style: const TextStyle(
                color: Color(0xFFD155A8),
                fontFamily: 'Varela',
                fontSize: 16.0,
              ),
            ),
            Container(
              height: 40.0,
              child: Text(
                product.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  color: Color(0xFFD155A8),
                  fontFamily: 'Varela',
                  fontSize: 14.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                color: const Color(0xFFD155A8),
                height: 1.0,
              ),
            ),
            // Exibe opções para adicionar ao carrinho.
            Padding(
              padding:
                  const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (!product.isAddedToCart) ...[
                    const Icon(
                      Icons.shopping_basket,
                      color: Color(0xFFD155A8),
                      size: 20.0,
                    ),
                    const Text(
                      'Adicionar ao carrinho',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        color: Color(0xFFD155A8),
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                  if (product.isAddedToCart) ...[
                    const Icon(
                      Icons.remove_circle_outline,
                      color: Color(0xFFD155A8),
                      size: 12.0,
                    ),
                    const Text(
                      '1',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        color: Color(0xFFD155A8),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    const Icon(
                      Icons.add_circle_outline,
                      color: Color(0xFFD155A8),
                      size: 12.0,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Define uma classe 'Product' para representar produtos.
class Product {
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

  // Construtor para a classe 'Product'.
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    this.isFavorite = false,
    required this.description,
    required this.category,
    this.isAddedToCart = false,
    required this.manufacturer,
    required this.stockQuantity,
  });

  // Método toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imagePath': imagePath,
      'description': description,
      'category': category,
      'manufacturer': manufacturer,
      'stockQuantity': stockQuantity,
      'isFavorite': isFavorite,
      'isAddedToCart': isAddedToCart,
    };
  }
}
