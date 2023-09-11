import 'package:flutter/material.dart';
import 'product_list.dart';
import 'bottom_bar.dart';
import 'related_products.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  const ProductDetail({required this.product, Key? key}) : super(key: key);

  @override
  ProductDetailState createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetail> {
  int _currentIndex = 1; // Índice para controlar a aba selecionada na BottomBar

  // Função chamada quando uma aba da BottomBar é pressionada
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 217, 70, 119),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFFFFF)),
          onPressed: () {
            Navigator.of(context).pop(); // Fecha a página ao pressionar o botão Voltar
          },
        ),
        title: const Text(
          'Detalhes do Produto',
          style: TextStyle(
            fontFamily: 'Varela',
            fontSize: 20.0,
            color: Color(0xFFFFFFFF),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFFFFFFFF)),
            onPressed: () {
              // Adicione ação para lidar com notificações aqui
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              // Título do produto
              widget.product.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Varela',
                fontSize: 42.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD155A8),
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          Hero(
            tag: widget.product.imagePath,
            child: Image.asset(
              widget.product.imagePath,
              height: 150.0,
              width: 100.0,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20.0),
          Center(
            child: Text(
              formatPrice(widget.product.price), // Formata o preço do produto
              style: const TextStyle(
                fontFamily: 'Varela',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD155A8),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Center(
            child: Text(
              widget.product.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFD155A8),
                fontFamily: 'Varela',
                fontSize: 24.0,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(
                widget.product.description, // Descrição do produto
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                  color: Color(0xFFD155A8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: const Color(0xFFD155A8),
              ),
              child: const Center(
                child: Text(
                  'Adicionar ao carrinho',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Relatedproduct(selectedProduct: widget.product)
        ],
      ),
      bottomNavigationBar: BottomBar(currentIndex: _currentIndex), // Barra de navegação inferior
    );
  }
}
