// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:fusion_shop_app/components/product_detail.dart';

class Rating extends StatelessWidget {
  const Rating({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 217, 70, 119),
        title: const Text('Avaliações dos produtos'),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFFFFF)),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Fecha a página ao pressionar o botão Voltar
          },
        ),
      ),
        body: const ProductRatingWidget(),
      ),
    );
  }
}

class ProductRatingWidget extends StatelessWidget {
  const ProductRatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable, unnecessary_const
    const color2 = const Color.fromARGB(255, 217, 70, 119);
    return SizedBox(
      height: 150.0,
      child: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
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
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white30,
                  ),
                ),
              ),
              
              ElevatedButton(
                onPressed: () {
                  final _dialog = RatingDialog(
                    initialRating: 1.0,
                    title: const Text(
                      'Deixe sua Opinião',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Avaliação do Produto
                    message: const Text(
                      'Queremos saber sua Opinião, gostou do Produto?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                    // Logo
                    image: Image.asset(
                      'images/readme/logo-fusion-shop.png', 
                      height: 100,  
                    ),
                    submitButtonText: 'Avaliar',
                    commentHint: 'Deixe seu Feedback',
                    onCancelled: () => print('Cancelar'),
                    onSubmitted: (response) {
                      print(
                          'Avaliação: ${response.rating}, Comentário: ${response.comment}');

                      if (response.rating < 3.0) {
                        // enviar comentários
                      } else {
                        _rateAndReviewApp();
                      }
                    },
                  );

                  // Mostre o diálogo
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => _dialog,
                  );
                },
                child: const Text('Avaliar'),
              ),
              const BottomAppBar(color: Color.fromARGB(255, 217, 70, 119),)
            ],
          ),
        ],
      ),
    );
  }

  void _rateAndReviewApp() {
    //lógica para avaliar.
    print('Avaliar o produto');
  }
}