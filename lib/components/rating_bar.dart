import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'custom_app_bar.dart';

class Rating extends StatefulWidget {
  @override
  RatingState createState() => RatingState();
}

class RatingState extends State<Rating> {
  double averageRating = 4.9; // Média das avaliações
  List<Review> fictitiousReviews = [
    Review('Cliente 1', 5.0, 'Excelente produto!'),
    Review('Cliente 2', 4.0, 'Muito bom.'),
    // Adicione mais avaliações fictícias conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Avaliações do Produto',
          backgroundColor: Color.fromARGB(255, 217, 70, 119),
        ),
        body: Column(
          children: [
            // Widget para exibir a média de avaliação e permitir que os usuários avaliem
            ProductRatingWidget(
              averageRating: averageRating,
              onRatingSubmitted: (response) {
                if (true) {
                  // Adiciona uma avaliação fictícia para qualquer valor de classificação
                  fictitiousReviews.add(Review(
                      'Cliente ${fictitiousReviews.length + 1}',
                      response.rating,
                      response.comment));
                }
                setState(() {}); // Atualiza a interface após a avaliação
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: fictitiousReviews.length,
                itemBuilder: (context, index) {
                  final review = fictitiousReviews[index];
                  return ListTile(
                    title: Text(review.userName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Exibe a avaliação do cliente, usando estrelas
                        RatingBar.builder(
                          initialRating: review.rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        Text(review.comment), // Exibe o comentário do cliente
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
    );
  }
}

class ProductRatingWidget extends StatelessWidget {
  final double averageRating;
  final ValueChanged<RatingDialogResponse> onRatingSubmitted;

  ProductRatingWidget({
    required this.averageRating,
    required this.onRatingSubmitted,
  });

  @override
  Widget build(BuildContext context) {
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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Exibe a média de avaliação atual
              RatingBar.builder(
                initialRating: averageRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20, // Define o tamanho das estrelas
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
              SizedBox(width: 8), // Espaçamento entre a média e as estrelas
              Text(
                averageRating.toString(), // Exibe a média atual em texto
                style: TextStyle(
                  color: Color(0xFFD155A8),
                  height: 1.0,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 20), // Espaçamento entre a média e o botão
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
                message: const Text(
                  'Queremos saber sua Opinião, gostou do produto?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                image: Image.asset(
                  'images/readme/logo-fusion-shop.png',
                  height: 100,
                ),
                submitButtonText: 'Avaliar',
                commentHint: 'Deixe seu Feedback',
                onCancelled: () => print('Cancelar'),
                onSubmitted: onRatingSubmitted,
              );

              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => _dialog,
              );
            },
            child: const Text('Avalie você também'),
          ),
        ],
      ),
    );
  }
}

class Review {
  final String userName;
  final double rating;
  final String comment;

  Review(this.userName, this.rating, this.comment);
}
