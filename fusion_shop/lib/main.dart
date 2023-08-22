import 'package:ecommerce/screens/Home_screen.dart'; //Tela inicial
import 'package:flutter/material.dart'; //pacote que que cria interfaces de usuário

//void main é o ponto de entrada
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //método build, é obrigatório em um StatelessWidget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF212325),//cor de fundo da nossa tabela
      ),
      home: HomeScreen(),//Tela mostrada quando o app for iniciado
    );
  }
}