import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product_list.dart';
import 'custom_app_bar.dart';

class AddProduct extends StatelessWidget {
  final String category;

  AddProduct({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Adicionar Produto - $category',
        backgroundColor: const Color.fromARGB(255, 217, 70, 119),
      ),
      body: Center(
        child: Text(
            'Esta é a página para adicionar produtos à categoria $category.'),
      ),
    );
  }
}
