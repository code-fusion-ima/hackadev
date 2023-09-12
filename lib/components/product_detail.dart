// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'product_list.dart';
import 'bottom_bar.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fusion_shop_app/components/rating_bar.dart';

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
            Navigator.of(context)
                .pop(); // Fecha a página ao pressionar o botão Voltar
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
            icon:
                const Icon(Icons.notifications_none, color: Color(0xFFFFFFFF)),
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
          SizedBox(
            height: 150.0,
            child: Column(
              children: [
                const Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white30,
                        ),
                      ),
                    ),
                    Text(
                      'Avaliações do Produto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFFD155A8),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                        color: Colors.white30,
                      )),
                    ),
                    const Text(
                      '4.9',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Color(0xFFD155A8),
                          height: 1.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                    Rating()), // 
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          BottomBar(currentIndex: _currentIndex), // Barra de navegação inferior
    );
  }
}