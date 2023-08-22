import 'package:ecommerce/widgets/items_widget.dart'; //tela inicial
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//lista para filtrar os produtos com base na categoria
final List<String> categorias = ["Eletrônicos", "Smartphones", "Smart TVs"];

//classe _HomeScreenState, é o estado da tela inicial. Ela estende _HomeScreenState e usa SingleTickerProviderStateMixin, o que é comum quando você precisa de um TabController para controlar guias (abas).
class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
//_tabController é usada para controlar as abas na parte superior da tela.
  late TabController _tabController;

//No método initState, _tabController, foi inicializado definindo seu comprimento como 4 (indicando 4 abas), associando-o ao mixin this, e configurando um ouvinte para atualizar a interface do usuário quando a aba é trocada.
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handTabSelection);
    super.initState();
  }

//A função _handTabSelection atualiza o estado quando a aba for trocada.
  _handTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

//O método dispose, libera os recursos do _tabController quando a tela for descartada.
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Função para obter produtos com base na categoria selecionada
  List<Map<String, dynamic>> _getProducts(String category) {
    if (category == "Eletrônicos") {
      return [
        {
          'id': 1,
          'nome': "Máquina de lavar Electrolux",
          'valor': '1.8990,05',
          'foto': 'images/maquina.png',
          'descricao':
              'A Lavadora de Roupas Electrolux LED14 possui a Tecnologia Jet&Clean que dilui até 100% do sabão e o amaciante, além de manter o dispenser sempre limpo e sem resíduos. Conta também com o sistema de Lavagem com Ciclos Rápidos, otimiza o tempo dos programas de forma automática, evitando o desgaste e mantendo o cuidado com os tecidos, Alem de possuir 11 programações de lavagens que deixa o produto ainda mais eficiente.',
          'categoria': 'Eletrônicos',
        },
        {
          'id': 2,
          'nome': "Micro-ondas Electrolux",
          'valor': '699,00',
          'foto': 'images/microondas.png',
          'descricao':
              'Desenvolvido com um design contemporâneo e sofisticado, o Micro-ondas ME36B da Electrolux além de facilitar o seu dia a dia irá deixar a sua cozinha ainda mais elegante e completa. Ele tem capacidade de até 36 Litros, Múltiplas Funções como Fermentar, Desidratar, Derreter, Cozinhar Delicado e Cozinhar além de uma Potência de 1600W.',
          'categoria': 'Eletrônicos',
        },
        {
          'id': 3,
          'nome': "Frigobar Brastemp Retrô",
          'valor': '2.089,05',
          'foto': 'images/frigobar.png',
          'descricao':
              'O Frigobar BRA08BG, traz um produto que une a beleza dos anos 50 com a tecnologia dos anos modernos, isso para oferecer a você um produto de qualidade. São 76 litros de capacidade e compartimentos modulares na porta para uma melhor organização e otimização do espaço. O freezer é ideal para fazer gelo e guardar alimentos congelados.',
          'categoria': 'Eletrônicos',
        },
        {
          'id': 4,
          'nome': "Coifa de Parede Fischer",
          'valor': '1.299,00',
          'foto': 'images/coifa.png',
          'descricao':
              'Fabricada em ano inox escovado e vidro temperado, a Coifa possui função de depurador ou exaustor. Acompanha filtro de alumínio e de carvão ativado que garantem a máxima eficiência na purificação do ar. A Coifa de parede Fischer Fit possui controle eletromecânico, três níveis de velocidade e lâmpada de LED. Fácil controle e extrema eficiência para quem busca uma cozinha bonita e higienizada.',
          'categoria': 'Eletrônicos',
        },
      ];
    } else if (category == "Smartphones") {
      return [
        {
          'id': 5,
          'nome': "Smartphone Samsung Galaxy A34",
          'valor': '1.599,00',
          'foto': 'images/smartphone-samsung.png',
          'descricao':
              'Com sua deslumbrante tela Super Amoled de 6,6" e uma incrível taxa de atualização de 120Hz, você desfrutará de imagens nítidas e movimentos suaves. Com um amplo armazenamento de 128GB, você terá espaço de sobra para seus aplicativos, fotos e vídeos favoritos.',
          'categoria': 'Smartphones',
        },
        {
          'id': 6,
          'nome': "Smartphone Motorola E22",
          'valor': '799,00',
          'foto': 'images/smartphone-motorola.png',
          'descricao': 'O Motorola Moto E 22 possui uma tela IPS LCD de 6,5'
              ' com proporção de 20:9 para você ver tudo sem rolar para lá e para cá. Com uma taxa de atualização rápida de 90 Hz³, você troca de um app para outro e navega em sites de maneira suave e fluida. Além disso, ele conta com 3 câmeras, sendo 2 traseiras, uma de 16 MP e uma de profundidade de 2MP que deixará suas fotos mais bonitas.',
          'categoria': 'Smartphones',
        },
        {
          'id': 7,
          'nome': "Smartphone Xiaomi Redmi 10C",
          'valor': '1.799,00',
          'foto': 'images/smartphone-xiomi.png',
          'descricao':
              'O Android Enterprise Recommended oferece um ecossistema de dispositivos e serviços verificados pelo Google™ em relação aos requisitos de nível empresarial para atualizações de desempenho, consistência e segurança..',
          'categoria': 'Smartphones',
        },
        {
          'id': 8,
          'nome': "Smartphone Positivo Twist 4 S514",
          'valor': '487,51',
          'foto': 'images/smartphone-positivo.png',
          'descricao':
              'Momentos únicos, capturas reais. Capture seus melhores momentos e reviva-os sempre que quiser com a câmera traseira de 8 Mpx. Além disso, com a câmera frontal com flash, prepare-se para compartilhar selfies mais brilhantes em suas redes sociais.',
          'categoria': 'Smartphones',
        },
      ];
    } else if (category == "Smart TVs") {
      return [
        {
          'id': 9,
          'nome': "Smart TV LED 32'' HD LG",
          'valor': '1.239,00',
          'foto': 'images/smart-lg.png',
          'descricao':
              'Transforme sua sala em um verdadeiro centro de entretenimento com a Smart TV LED 32'
                  ' HD LG ThinQAI Alexa 32LQ620. Com recursos avançados como Google Assistente, Alexa integrada e ThinQ AI, controlar sua TV nunca foi tão fácil e intuitivo.',
          'categoria': 'Smart TVs',
        },
        {
          'id': 10,
          'nome': "Smart TV LED 65'' TCL 4K UHD Google TV HDR",
          'valor': '3.199,00',
          'foto': 'images/smart-google.png',
          'descricao': 'A Smart TV LED 65'
              ' 65P735 da TCL conta com altíssima tecnologia de imagem e som para sua sala. A Smart TV conta com tela de 65'
              ' em LED com resolução 4K e HDR para você desfrutar de alta qualidade de imagem para seu conteúdo, som com 19W de potência, conexão Bluetooth, Wifi e compatibilidade com assistentes de voz e os principais aplicativos de streaming.',
          'categoria': 'Smart TVs',
        },
        {
          'id': 11,
          'nome': 'Smart TV 42' ' LED Philco',
          'valor': '1.519,05',
          'foto': 'images/smart-philco.png',
          'descricao': 'A Smart TV 42'
              ' LED PTV42G52RCF da Philco proporciona a qualidade ideal para você desfrutar e relaxar na frente da sua tv. A TV conta com display em D-LED de 42'
              ', resolução FHD, alta qualidade de brilho e contraste, alto-falante de 20Wrms, Wi-Fi Dual Band, dolby audio. Conte também com as conexões HDMI, RF para TV e TV a cabo, USB, Ethernet, P2 e RCA para fones de ouvido e autofalantes e conversor digital integrado.',
          'categoria': 'Smart TVs',
        },
      ];
    }
    // Retorne uma lista vazia como fallback
    return [];
  }

//No método build, é construída a interface da tela. Isso inclui a AppBar, a TabBar com as abas, a barra de pesquisa e a exibição de produtos com base na categoria selecionada.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //SafeArea: Este widget garante que o conteúdo da tela não seja exibido sob as áreas sensíveis à tela, como a barra de status.
        child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: ListView(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: Color(0xFFA257D4),
                unselectedLabelColor: Colors.white.withOpacity(0.5),
                isScrollable: true,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 3,
                      color: Color(0xFFA257D4),
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 16)),
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                tabs: [
                  Tab(text: "Eletrônicos"),
                  Tab(text: "Smartphones"),
                  Tab(text: "Smart TVs"),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: [
                  ItemsWidget(produtos: _getProducts("Eletrônicos")),
                  ItemsWidget(produtos: _getProducts("Smartphones")),
                  ItemsWidget(produtos: _getProducts("Smart TVs")),
                ][_tabController.index],
              )
            ],
          ),
        ),
      ),
    );
  }
}