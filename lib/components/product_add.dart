import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'product_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'api_service.dart';

String formatPrice(double? price) {
  if (price == null) {
    return 'Preço não informado';
  }
  final NumberFormat formatoMoeda =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  return formatoMoeda.format(price);
}

class AddProduct extends StatefulWidget {
  final String category;

  AddProduct({required this.category});

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<Product> products = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController manufacturerController = TextEditingController();
  final TextEditingController stockQuantityController = TextEditingController();
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    selecionarProdutos(widget.category).then((loadedProducts) {
      setState(() {
        products = loadedProducts;
      });
    });
  }

  Future<void> _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  void exibirDetalhesProduto(BuildContext context, Product produto) async {
    final detailedProduct = await buscarDetalhesProduto(produto.id ?? 0);

    if (detailedProduct != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Detalhes do Produto'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detailedProduct.name ?? '',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Preço: ${formatPrice(detailedProduct.price)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Descrição: ${detailedProduct.description ?? ''}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fabricante: ${detailedProduct.manufacturer ?? ''}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Quantidade em Estoque: ${detailedProduct.stockQuantity ?? 0}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Fechar'),
              ),
            ],
          );
        },
      );
    } else {
      Fluttertoast.showToast(msg: 'Erro ao buscar detalhes do produto');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Produto - ${widget.category}'),
        backgroundColor: Color.fromARGB(255, 217, 70, 119),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categoria: ${widget.category}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome do Produto*'),
            ),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Preço do Produto*'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d+\.?\d{0,2}'),
                ),
              ],
              validator: (value) {
                if (value == null ||
                    double.tryParse(value) == null ||
                    double.parse(value) <= 0) {
                  return 'Por favor, insira um preço válido maior que zero.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: descriptionController,
              decoration:
                  const InputDecoration(labelText: 'Descrição do Produto*'),
              maxLines: 3,
            ),
            TextFormField(
              controller: manufacturerController,
              decoration: const InputDecoration(labelText: 'Fabricante*'),
            ),
            TextFormField(
              controller: stockQuantityController,
              decoration:
                  const InputDecoration(labelText: 'Quantidade em Estoque*'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 20),

            // Adicione o botão de seleção de imagem
            ElevatedButton(
              onPressed: _selectImage,
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 217, 70, 119), // Cor desejada
              ),
              child: Text(
                'Selecionar Imagem',
                style: TextStyle(color: Colors.white), // Cor do texto
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    priceController.text.isEmpty ||
                    descriptionController.text.isEmpty ||
                    manufacturerController.text.isEmpty ||
                    stockQuantityController.text.isEmpty ||
                    _selectedImage == null) {
                  Fluttertoast.showToast(
                      msg: 'Por favor, preencha todos os campos obrigatórios.');
                  return;
                }

                final newProduct = Product(
                  id: getNextProductId(products),
                  name: nameController.text,
                  price: double.tryParse(priceController.text) ?? 0.0,
                  description: descriptionController.text,
                  category: widget.category,
                  imagePath: _selectedImage!
                      .path, // Use o caminho da imagem selecionada
                  manufacturer: manufacturerController.text,
                  stockQuantity:
                      int.tryParse(stockQuantityController.text) ?? 0,
                );

                final success = await cadastrarProduct(newProduct);

                if (success) {
                  setState(() {
                    products.add(newProduct);
                  });

                  nameController.clear();
                  priceController.clear();
                  descriptionController.clear();
                  manufacturerController.clear();
                  stockQuantityController.clear();

                  Fluttertoast.showToast(msg: 'Produto adicionado com sucesso');
                } else {
                  Fluttertoast.showToast(msg: 'Erro ao cadastrar produto');
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 217, 70, 119),
              ),
              child: const Text('Salvar Produto'),
            ),
            const SizedBox(height: 20),
            Text(
              'Produtos da Categoria: ${widget.category}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  child: GestureDetector(
                    onTap: () {
                      exibirDetalhesProduto(context, product);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              product.imagePath ?? '',
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name ?? '',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Descrição: ${product.description ?? ''}',
                                ),
                                Text(
                                  'Preço: ${formatPrice(product.price)}',
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Ação de edição
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // Ação de exclusão
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

Future<bool> cadastrarProduct(Product newProduct) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/produto/cadastro'),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: jsonEncode(newProduct.toJson()),
    );

    if (response.statusCode == 200) {
      print('Produto cadastrado com sucesso');
      return true;
    } else {
      print('Erro ao cadastrar produto: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Erro ao cadastrar produto: $e');
    return false;
  }
}

Future<List<Product>> selecionarProdutos(String? category) async {
  if (category == null) {
    print('Categoria não pode ser nula');
    return [];
  }

  ApiService apiService = ApiService();

  try {
    List<dynamic> produtos = await apiService.getProducts();

    List<Product> products = produtos
        .where((obj) {
          if (obj["category"] is String) {
            return obj["category"] == category;
          } else {
            return false;
          }
        })
        .map((obj) {
          return Product(
            id: obj["id"],
            name: obj["name"],
            category: obj["category"],
            description: obj["description"],
            imagePath: obj["imagePath"],
            price: obj["price"]?.toDouble(),
            manufacturer: obj["manufacturer"],
            stockQuantity: obj["stockQuantity"],
          );
        })
        .toList();

    return products;
  } catch (e) {
    print('Erro ao buscar produtos: $e');
    return [];
  }
}

Future<Product?> buscarDetalhesProduto(int productId) async {
  try {
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/produto/$productId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> produto = jsonDecode(response.body);
      return Product(
        id: produto["id"],
        name: produto["name"],
        category: produto["category"],
        description: produto["description"],
        imagePath: produto["imagePath"],
        price: produto["price"]?.toDouble(),
        manufacturer: produto["manufacturer"],
        stockQuantity: produto["stockQuantity"],
      );
    } else {
      print('Erro ao buscar detalhes do produto: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Erro ao buscar detalhes do produto: $e');
    return null;
  }
}

int getNextProductId(List<Product> products) {
  if (products.isEmpty) {
    return 1;
  } else {
    return products
            .map((product) => product.id ?? 0)
            .reduce((a, b) => a > b ? a : b) +
        1;
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              formatPrice(product.price),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              product.description ?? '',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Image.network(
              product.imagePath ?? '',
              fit: BoxFit.cover,
              height: 150.0,
            ),
          ],
        ),
      ),
    );
  }
}
