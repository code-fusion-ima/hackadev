//Importando o pacote flutter/material.dart e definindo a classe ItemsWidget como um StatelessWidget. Esse widget recebe uma lista de produtos como argumento no construtor.

import 'package:flutter/material.dart';

class ItemsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> produtos;

  ItemsWidget({required this.produtos});

//O método build é implementado, conforme exigido por um StatelessWidget. Este método define a estrutura e a aparência dos itens na grade com base na lista de produtos fornecida.
  @override
  Widget build(BuildContext context) {

//GridView.count é usado para exibir os produtos em uma grade de duas colunas. Cada produto é representado como um Container com uma imagem, nome, descrição e preço. O widget InkWell envolve a imagem, permitindo a detecção de toques.

    return SingleChildScrollView(
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        shrinkWrap: true,
        childAspectRatio: (150 / 195),
        children: [
          for (int i = 0; i < produtos.length; i++)
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF212325),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 8,
                  )
                ],
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Image.asset(
                        "${produtos[i]['foto']}",
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  //Aqui  é exibido o nome e a descrição do produto. A descrição é limitada aos primeiros 100 caracteres para evitar que ocupe muito espaço na tela.
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${produtos[i]['nome']}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "${produtos[i]['descricao'].substring(0, 100)}...", // Mostra os primeiros 100 caracteres
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //O preço do produto na parte inferior do Container.
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "R\$ ${produtos[i]['valor']}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}


