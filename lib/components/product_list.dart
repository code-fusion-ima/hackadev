import 'package:flutter/material.dart';
import 'bottom_bar.dart';
import 'product_detail.dart';
import 'package:intl/intl.dart';

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
  int _currentIndex = 2; // Índice para controlar a aba selecionada na BottomBar

  // Função chamada quando uma aba da BottomBar é pressionada
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filtra os produtos pela categoria selecionada.
    List<Product> filteredProducts = products
        .where((product) => product.category == widget.category)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 217, 70, 119),
        title: Text('Produtos da Categoria: ${widget.category}'),
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
      bottomNavigationBar: BottomBar(currentIndex: _currentIndex),
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
              tag: product.imagePath, // Tag para animação Hero
              child: Container(
                height: 80.0,
                width: 80.0,
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

  // Construtor para a classe 'Product'.
  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.imagePath,
      this.isFavorite = false,
      required this.description,
      required this.category,
      this.isAddedToCart = false});
}

// Lista de produtos (simulando um JSON)
List<Product> products = [
  Product(
    id: 1,
    name: "Máquina de lavar Electrolux",
    price: 18990.05,
    imagePath: 'images/produtos/eletrodomesticos/maquina.png',
    description:
        'A Lavadora de Roupas Electrolux LED14 possui a Tecnologia Jet&Clean que dilui até 100% do sabão e o amaciante, além de manter o dispenser sempre limpo e sem resíduos. Conta também com o sistema de Lavagem com Ciclos Rápidos, otimiza o tempo dos programas de forma automática, evitando o desgaste e mantendo o cuidado com os tecidos, Alem de possuir 11 programações de lavagens que deixa o produto ainda mais eficiente.',
    category: 'Eletrodomésticos',
    isFavorite: true,
    isAddedToCart: false,
  ),
  Product(
    id: 2,
    name: "Micro-ondas Electrolux",
    price: 699.00,
    imagePath: 'images/produtos/eletrodomesticos/microondas.png',
    description:
        'Desenvolvido com um design contemporâneo e sofisticado, o Micro-ondas ME36B da Electrolux além de facilitar o seu dia a dia irá deixar a sua cozinha ainda mais elegante e completa. Ele tem capacidade de até 36 Litros, Múltiplas Funções como Fermentar, Desidratar, Derreter, Cozinhar Delicado e Cozinhar além de uma Potência de 1600W.',
    category: 'Eletrodomésticos',
    isFavorite: false,
    isAddedToCart: true,
  ),
  Product(
    id: 3,
    name: "Frigobar Brastemp Retrô",
    price: 2089.05,
    imagePath: 'images/produtos/eletrodomesticos/frigobar.png',
    description:
        'O Frigobar BRA08BG, traz um produto que une a beleza dos anos 50 com a tecnologia dos anos modernos, isso para oferecer a você um produto de qualidade. São 76 litros de capacidade e compartimentos modulares na porta para uma melhor organização e otimização do espaço. O freezer é ideal para fazer gelo e guardar alimentos congelados.',
    category: 'Eletrodomésticos',
    isFavorite: true,
    isAddedToCart: false,
  ),
  Product(
    id: 4,
    name: "Coifa de Parede Fischer",
    price: 1299.00,
    imagePath: 'images/produtos/eletrodomesticos/coifa.png',
    description:
        'Fabricada em ano inox escovado e vidro temperado, a Coifa possui função de depurador ou exaustor. Acompanha filtro de alumínio e de carvão ativado que garantem a máxima eficiência na purificação do ar. A Coifa de parede Fischer Fit possui controle eletromecânico, três níveis de velocidade e lâmpada de LED. Fácil controle e extrema eficiência para quem busca uma cozinha bonita e higienizada.',
    category: 'Eletrodomésticos',
    isFavorite: false,
    isAddedToCart: true,
  ),
  Product(
    id: 5,
    name: "Smartphone Samsung Galaxy A34",
    price: 1599.00,
    imagePath: 'images/produtos/smartphones/smartphone-samsung.png',
    description:
        'Com sua deslumbrante tela Super Amoled de 6,6" e uma incrível taxa de atualização de 120Hz, você desfrutará de imagens nítidas e movimentos suaves. Com um amplo armazenamento de 128GB, você terá espaço de sobra para seus aplicativos, imagePaths e vídeos favoritos.',
    category: 'Smartphones',
    isFavorite: true,
    isAddedToCart: false,
  ),
  Product(
    id: 6,
    name: "Smartphone Motorola E22",
    price: 799.00,
    imagePath: 'images/produtos/smartphones/smartphone-motorola.png',
    description: 'O Motorola Moto E 22 possui uma tela IPS LCD de 6,5'
        ' com proporção de 20:9 para você ver tudo sem rolar para lá e para cá. Com uma taxa de atualização rápida de 90 Hz³, você troca de um app para outro e navega em sites de maneira suave e fluida. Além disso, ele conta com 3 câmeras, sendo 2 traseiras, uma de 16 MP e uma de profundidade de 2MP que deixará suas imagePaths mais bonitas.',
    category: 'Smartphones',
    isFavorite: false,
    isAddedToCart: true,
  ),
  Product(
    id: 7,
    name: "Smartphone Xiaomi Redmi 10C",
    price: 1799.00,
    imagePath: 'images/produtos/smartphones/smartphone-xiomi.png',
    description:
        'O Android Enterprise Recommended oferece um ecossistema de dispositivos e serviços verificados pelo Google™ em relação aos requisitos de nível empresarial para atualizações de desempenho, consistência e segurança..',
    category: 'Smartphones',
    isFavorite: true,
    isAddedToCart: false,
  ),
  Product(
    id: 8,
    name: "Smartphone Positivo Twist 4 S514",
    price: 487.51,
    imagePath: 'images/produtos/smartphones/smartphone-positivo.png',
    description:
        'Momentos únicos, capturas reais. Capture seus melhores momentos e reviva-os sempre que quiser com a câmera traseira de 8 Mpx. Além disso, com a câmera frontal com flash, prepare-se para compartilhar selfies mais brilhantes em suas redes sociais.',
    category: 'Smartphones',
    isFavorite: false,
    isAddedToCart: true,
  ),
  Product(
    id: 9,
    name: "Smart TV LED 32'' HD LG",
    price: 1239.00,
    imagePath: 'images/produtos/smartv/smart-lg.png',
    description:
        'Transforme sua sala em um verdadeiro centro de entretenimento com a Smart TV LED 32'
        ' HD LG ThinQAI Alexa 32LQ620. Com recursos avançados como Google Assistente, Alexa integrada e ThinQ AI, controlar sua TV nunca foi tão fácil e intuitivo.',
    category: 'TVs',
    isFavorite: true,
    isAddedToCart: false,
  ),
  Product(
    id: 10,
    name: "Smart TV LED 65'' TCL 4K UHD Google TV HDR",
    price: 3199.00,
    imagePath: 'images/produtos/smartv/smart-google.png',
    description: 'A Smart TV LED 65'
        ' 65P735 da TCL conta com altíssima tecnologia de imagem e som para sua sala. A Smart TV conta com tela de 65'
        ' em LED com resolução 4K e HDR para você desfrutar de alta qualidade de imagem para seu conteúdo, som com 19W de potência, conexão Bluetooth, Wifi e compatibilidade com assistentes de voz e os principais aplicativos de streaming.',
    category: 'TVs',
    isFavorite: false,
    isAddedToCart: true,
  ),
  Product(
    id: 11,
    name: 'Smart TV 42' ' LED Philco',
    price: 1519.05,
    imagePath: 'images/produtos/smartv/smart-philco.png',
    description: 'A Smart TV 42'
        ' LED PTV42G52RCF da Philco proporciona a qualidade ideal para você desfrutar e relaxar na frente da sua tv. A TV conta com display em D-LED de 42'
        ', resolução FHD, alta qualidade de brilho e contraste, alto-falante de 20Wrms, Wi-Fi Dual Band, dolby audio. Conte também com as conexões HDMI, RF para TV e TV a cabo, USB, Ethernet, P2 e RCA para fones de ouvido e autofalantes e conversor digital integrado.',
    category: 'TVs',
    isFavorite: true,
    isAddedToCart: false,
  ),
];