import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fusion_shop_app/api/getFiles.dart';
import 'package:fusion_shop_app/components/bottom_bar.dart';
import 'package:fusion_shop_app/components/product_detail.dart';
import 'product_list.dart';
import 'custom_app_bar.dart';
import '../api/getFiles.dart';

class AddProduct extends StatefulWidget {
  final String category;

  AddProduct({required this.category});

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool _hasExecutedOnce = false;
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    if (!_hasExecutedOnce) {
      fetchAndConvertProducts().then((products) {
        setState(() {
          _products = products;
        });
      });
      _hasExecutedOnce = true;
    }
  }

  Future<List<Product>> fetchAndConvertProducts() async {
    List<dynamic> dynamicProducts = await ProductsCategoryList();

    List<Product> products = dynamicProducts.map((dynamicData) {
      return Product(
        id: dynamicData['id'],
        name: dynamicData['name'],
        price: dynamicData['price'].toDouble(),
        imagePath: dynamicData['imagePath'],
        description: dynamicData['description'],
        category: dynamicData['category'],
        isFavorite: dynamicData['isFavorite'],
        isAddedToCart: dynamicData['isAddedToCart'],
        manufacturer: dynamicData['manufacturer'],
        stockQuantity: dynamicData['stockQuantity'],
      );
    }).toList();

    return products;
  }

  Future<List> ProductsCategoryList() async {
    List<dynamic> data = await fetchProducts();

    print(widget.category);

    List<dynamic> tvProducts = data
        .where((product) => product['category'] == widget.category)
        .toList();

    return tvProducts;
  }

  @override
  Widget build(BuildContext context) {
    // Verifique se os produtos foram carregados antes de construir a interface.

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
              children: _products.map((product) {
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
            builder: (context) => ProductDetail(
              product: product,
            ),
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