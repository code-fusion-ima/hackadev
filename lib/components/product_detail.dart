import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fusion_shop_app/api/getFiles.dart';
import 'package:like_button/like_button.dart';
import 'product_list.dart';
import 'bottom_bar.dart';
import 'related_products.dart';
import 'rating_bar.dart';
import 'custom_app_bar.dart';

class CartItems {
  static final CartItems _singleton = CartItems._internal();

  factory CartItems() {
    return _singleton;
  }

  CartItems._internal();
  final List<String> items = [];
}

class CartPrice {
  final List<double> prices = [];
}

class CartImage {
  final List<ImageProvider> imagens = [];
}

class CartItemsWidget extends StatelessWidget {
  final CartItems cartItems;
  final CartPrice cartPrice;
  final CartImage cartImage;
  double itemCount;

  CartItemsWidget({
    required this.cartImage,
    required this.cartItems,
    required this.cartPrice,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.items.length,
            itemBuilder: (BuildContext context, int index) {
              if (index < cartPrice.prices.length) {
                final priceText = cartPrice.prices[index].toStringAsFixed(2);
                return Column(
                  children: [
                    ListTile(
                      leading: Image(image: cartImage.imagens[index]),
                      title: Center(child: Text(cartItems.items[index])),
                      subtitle: Center(child: Text('Preço: $priceText')),
                    ),
                    ElevatedButton(
                      onPressed: () {}, // Sem funcionalidade
                      child: Text('Remover'),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    ListTile(
                      //leading: Image(image: cartImage.imagens[index]),
                      title: Center(child: Text(cartItems.items[index])),
                    ),
                    // ElevatedButton(
                    //   onPressed: (){
                    //       //double removedPrice = cartPrice.prices[index];
                    //       //print('$itemCount');
                    //       cartItems.items.removeAt(index);
                    //       cartPrice.prices.removeAt(index);
                    //       cartImage.imagens.removeAt(index);
                    //       // Atualiza o total
                    //       //itemCount -= removedPrice;
                    //       print('$itemCount');
                    //},
                    //  style: ElevatedButton.styleFrom(
                    //   primary: const Color.fromARGB(255, 207, 210, 208), // Defina a cor verde aqui
                    // ),
                    //}, // Sem funcionalidade
                    // child: Text('Remover'),
                    // ),
                  ],
                );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'Total: \$${itemCount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final CartItems cartItems = CartItems();
final CartPrice cartPrice = CartPrice();
final CartImage cartImage = CartImage();
double itemCount = 0;

class ProductDetail extends StatefulWidget {
  final int? id;

  const ProductDetail({this.id, Key? key}) : super(key: key);

  @override
  ProductDetailState createState() => ProductDetailState(id);
}

class ProductDetailState extends State<ProductDetail> {
  final int? id;
  ProductAPI? productAPI;

  ProductDetailState(this.id);
  @override
  void initState() {
    super.initState();
    if (id != null) {
      GetProductId(id);
    }
  }

  Future<ProductAPI?> GetProductId(int? id) async {
    final productId = id;

    if (id != null) {
      final fetchedProduct = await fetchProduct(productId);

      if (fetchedProduct != null) {
        print(
            'Produto encontrado: ${fetchedProduct.name}, Preço: ${fetchedProduct.price}');
        return fetchedProduct; // Retornar o produto buscado
      } else {
        print('Produto não encontrado ou erro na chamada da API.');
      }
    }

    return null; // Retornar nulo se algo der errado
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Detalhes do Produto',
          backgroundColor: Color.fromARGB(255, 217, 70, 119),
        ),
        body: FutureBuilder<ProductAPI?>(
          future: GetProductId(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Aguarde enquanto os dados estão sendo buscados
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Trate qualquer erro que possa ter ocorrido durante a busca
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else {
              // Exiba o nome do produto se os dados foram buscados com sucesso
              final productAPI = snapshot.data;

              return ListView(
                children: [
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      children: [
                        Text(
                          productAPI?.name ?? 'Nome do produto',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 42.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD155A8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Hero(
                    tag: productAPI?.imagePath ??
                        'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled.png',
                    child: Image.asset(
                      productAPI?.imagePath ??
                          'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled.png', // Substitua pelo caminho real da imagem
                      height: 150.0,
                      width: 100.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Resto do seu código...
                  const SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      formatPrice(
                        productAPI?.price ?? 0,
                      ), // Formata o preço do produto
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
                      productAPI?.name ?? 'Nome do produto',
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
                        productAPI?.description ??
                            'Descrição não encontrada', // Descrição do produto
                        textAlign: TextAlign.justify,
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
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.purple[400],
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  final productImagePath = productAPI
                                          ?.imagePath ??
                                      'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled.png';
                                  final productImageProvider =
                                      AssetImage(productImagePath);
                                  cartImage.imagens.add(productImageProvider);
                                  final productName =
                                      productAPI?.name ?? 'Nome do produto';
                                  cartItems.items.add(productName);
                                  final productPrice = productAPI?.price ?? 0;
                                  cartPrice.prices.add(productPrice);
                                  itemCount = (itemCount + 0);
                                  print('$cartImage.imagens');
                                });
                              },
                              child: Center(
                                child: Text(
                                  "Adicionar ao carrinho",
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
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5)),
                        // Botão favoritar dinâmico
                        SizedBox(
                          width: 50,
                          child: LikeButton(),
                        )
                      ],
                    ),
                  ), // Fim da restruturação do "Adicionar ao carrinho"
                  const SizedBox(height: 10), // Início do rating bar
                  Center(
                    child: Column(
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
                          onRatingUpdate: (rating) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Rating()),
                            );
                          },
                        ),
                        const SizedBox(width: 5),
                        const Text("(1278)"),
                      ],
                    ),
                  ),

                  // Relatedproduct(selectedProduct: productAPI!)
                ],
              );
            }
          },
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
