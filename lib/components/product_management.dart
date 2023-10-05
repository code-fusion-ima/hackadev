import 'package:flutter/material.dart';
import 'package:fusion_shop_app/components/product_add.dart';
import 'product_list.dart';
import 'horizontal_listview.dart';

class ProductManagement extends StatelessWidget {
 ProductManagement({required this.categorias, Key? key}) : super(key: key);

  final List<String> categorias;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciamento de Produtos'),
      ),
      body: Column(
        children: [
          // Outros widgets ou conteúdo da sua página...

          // Lista de botões para cada categoria:
          Container(
            height: 300, // Defina uma altura fixa aqui
            child: ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    // Ao clicar em uma categoria, você pode navegar para a página de produtos com a categoria selecionada.
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddProduct(category: categorias[index]),
                      ),
                    );
                  },
                  child: Text(categorias[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
