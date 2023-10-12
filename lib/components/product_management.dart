import 'package:flutter/material.dart';
import 'package:fusion_shop_app/components/product_add.dart';
import 'product_list.dart';
import 'horizontal_listview.dart';

class ProductManagement extends StatelessWidget {
  ProductManagement({required this.categorias, Key? key}) : super(key: key);

  final List<String> categorias;

  IconData getIconForCategory(String category) {
    if (category == "TVs") {
      return Icons.tv;
    } else if (category == "Eletrodomésticos") {
      return Icons.electrical_services_rounded;
    } else if (category == "Smartphones") {
      return Icons.smartphone;
    } else if (category == "Smartwaches") {
      return Icons.watch_rounded;
    } else if (category == "Headphones") {
      return Icons.headphones;
    } else if (category == "Pendrives") {
      return Icons.drive_file_rename_outline_sharp;
    } else {
      return Icons.category; // Ícone padrão para outras categorias
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciamento de Produtos'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Outros widgets ou conteúdo da sua página...
          // Lista de botões para cada categoria:
          Container(
            margin: EdgeInsets.symmetric(horizontal: 200),
            height: 600, // Defina uma altura fixa aqui
            child: ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final category = categorias[index];
                final icon = getIconForCategory(category);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Ao clicar em uma categoria, você pode navegar para a página de produtos com a categoria selecionada.
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddProduct(category: category),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, size: 100), // Ícone
                        SizedBox(
                            width: 30), // Espaçamento entre o ícone e o texto
                        Text(category), // Texto da categoria
                      ],
                    ),
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
