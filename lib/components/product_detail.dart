import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_button/like_button.dart';
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
  var relatedProduct;

  void initState() {
    super.initState();
    relatedProduct = products
        .where((element) => element.category == widget.product.category)
        .toList();
  }

  // Função chamada quando uma aba da BottomBar é pressionada
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                icon: const Icon(Icons.notifications_none,
                    color: Color(0xFFFFFFFF)),
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
                child: Column(
                  // Ajuste inicial para implementar o rating bar
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Ajuste final para implementar o rating bar
                    Text(
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
                    const SizedBox(height: 10), // Início do rating bar
                    Row(
                      children: [
                        RatingBar.builder(
                            initialRating: 3.5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemBuilder: (context, _) =>
                                const Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (rating) {}),
                        const SizedBox(width: 5),
                        const Text(
                            "(1278)"), // Fim do rating bar incluindo a quantidade (estática) de avaliações já realizadas.
                      ],
                    ),
                  ],
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
                  formatPrice(
                      widget.product.price), // Formata o preço do produto
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
                  width: MediaQuery.of(context).size.width - 60.0,
                  child: Text(
                    widget.product.description, // Descrição do produto
                    textAlign: TextAlign
                        .justify, // Alterado o alinhamento para justificado
                    style: const TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      color: Color(0xFFD155A8),
                    ),
                  ),
                ),
              ),

              // Início da restruturação do "Adicionar ao carrinho"
              Container(
                height: 80,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        //ADICIONAR ROTA DO CARRINHO AQUI
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => Cart()
                        //     )
                        // );
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.purple[400],
                        ),
                        child: const Center(
                          child: Text(
                            "Adicionar ao carrinho",
                            style: TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5)),

                    //Botão favoritar dinâmico
                    const SizedBox(
                      width: 50,
                      child: LikeButton(),
                    )
                  ],
                ),
              ),
              // ...

              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 20.0), // Espaçamento vertical ao redor da caixa
                  padding:
                      EdgeInsets.all(10.0), // Preenchimento interno da caixa
                  decoration: BoxDecoration(
                    color: Color.fromARGB(
                        255, 241, 214, 233), // Cor de fundo da caixa
                    borderRadius: BorderRadius.circular(
                        10.0), // Borda arredondada da caixa
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 221, 67, 152)
                            .withOpacity(0.5), // Sombra da caixa
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Alinhar produtos à esquerda
                    children: [
                      Text(
                        'Produtos relacionados',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD155A8),
                        ),
                      ),
                      SizedBox(
                        height:
                            150.0, // Defina a altura da lista de produtos relacionados
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: relatedProduct.length,
                          itemBuilder: (context, index) {
                            final product = relatedProduct[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    product.imagePath,
                                    height: 80.0,
                                    width: 80.0,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontFamily: 'Varela',
                                      fontSize: 16.0,
                                      color: Color(0xFFD155A8),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            //bottomNavigationBar: BottomBar(currentIndex: _currentIndex),
          )),
    );
  }
}
