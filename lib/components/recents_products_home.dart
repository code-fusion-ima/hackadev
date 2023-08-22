// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class RecentsProducts extends StatefulWidget {
  const RecentsProducts({super.key});
  @override
  _RecentsProductsState createState() => _RecentsProductsState();
  }

class _RecentsProductsState extends State<RecentsProducts> {
  var productList = [
    {
      'name': 'Apple Watch SE (2ªG)',
      'picture': 'images/home/AppleWatch2.png',
      'price': 2159.00,
    },
    {
      'name': 'Beats Studio Pro',
      'picture': 'images/home/headphone3.jpg',
      'price': 2999.00,
    },
    {
      'name': 'Smartphone Xiaomi Redmi Note 12 128GB',
      'picture': 'images/home/smartphone1.png',
      'price': 1999.00,
    },
    {
      'name': 'Pendrive Sandisk 64GB',
      'picture': 'images/home/pendrive1.png',
      'price': 45,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: productList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2), 

      itemBuilder: (BuildContext context, int index) {
        return SingleProduct(
          productName: productList[index]['name'],
          productPicture: productList[index]['picture'],
          productPrice: productList[index]['price'],
        );
      });
  }
}

class SingleProduct extends StatelessWidget {
  
  //variables
  final productName;
  final productPicture;
  final productPrice;

  // ignore: use_key_in_widget_constructors
  const SingleProduct({
    this.productName,
    this.productPicture,
    this.productPrice
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: productName, 
        child: Material(
          child: InkWell(
            onTap: () {},
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(productName, style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                ),
              ),
              child: Image.asset(productPicture, fit:BoxFit.cover,)
              ),

          ),
          ),
          ),
    );
  }
}