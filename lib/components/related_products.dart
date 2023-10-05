import 'package:flutter/material.dart';
import 'package:fusion_shop_app/api/getFiles.dart';
import 'product_list.dart';
import 'product_detail.dart';

class Relatedproduct extends StatelessWidget {
  final ProductAPI selectedProduct;

  const Relatedproduct({required this.selectedProduct, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future:
          loadProductsFromJson(), // Chama a função para carregar os produtos.
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Indicador de carregamento enquanto espera.
        }

        if (snapshot.hasError) {
          return Text('Erro ao carregar produtos: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return Text('Nenhum dado disponível');
        }

        final List<Product> products = snapshot.data!;

        // Agora você pode usar a lista de produtos normalmente.
        List<Product> filteredProducts = products
            .where((product) => product.category == selectedProduct.category)
            .toList();

        return SizedBox(
          height: 500.0, // Defina a altura conforme necessário.
          child: ListView(
            scrollDirection: Axis.vertical, // Defina o scroll vertical.
            children: <Widget>[
              const SizedBox(height: 15.0),
              Text(
                "PRODUTOS RELACIONADOS",
                style: const TextStyle(
                  color: Color(0xFFD155A8),
                  fontFamily: 'Varela',
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              // Grade de cartões de produtos.
              Container(
                padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                width: MediaQuery.of(context).size.width - 30.0,
                height: MediaQuery.of(context).size.height - 50.0,
                child: GridView.count(
                  crossAxisCount:
                      1, // Defina para 1 para exibir em colunas verticais.
                  primary: false,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 1.5,
                  // children: filteredProducts.map((product) {
                  //   return _buildCard(
                  //     product,
                  //     context,
                  //   );
                  // }).toList(),
                ),
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        );
      },
    );
  }

  // Função para construir um widget de cartão de produto.
  Widget _buildCard(ProductAPI product, context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0, right: 3.0),
      child: InkWell(
        onTap: () {
          // Navega para a página de detalhes do produto.
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetail(
                id: product.id,
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
                tag: product.imagePath, // Tag para animação Hero
                child: Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(product.imagePath),
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
            ],
          ),
        ),
      ),
    );
  }
}
