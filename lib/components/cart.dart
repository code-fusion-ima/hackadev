import 'package:flutter/material.dart';
import 'package:fusion_shop_app/components/payment.dart';
import 'package:fusion_shop_app/components/product_detail.dart';
import 'package:fusion_shop_app/components/product_list.dart';

class Carrinho extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CarrinhoState();
  }
}

final CartItems cartItems = CartItems();
final CartPrice cartPrice = CartPrice();
final CartImage cartImage = CartImage();

class CarrinhoState extends State<Carrinho> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 217, 70, 119), // Cor do AppBar
        title: Text('Página do Carrinho'),
      ),
      body: 
       Column(
        children: [
          Expanded(
            child: CartItemsWidget(cartItems: cartItems, cartPrice: cartPrice, itemCount: itemCount, cartImage: cartImage,),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => RadioExampleApp()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 217, 70, 119), // Cor de fundo do botão
            ),
            child: Text("Finalizar pagamento"),
          ),
        ],
      ),
    );
  }
}
