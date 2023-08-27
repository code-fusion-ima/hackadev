import 'package:flutter/material.dart';
import 'product_list.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const <Widget>[
          Categoria(
            imageLocation: 'images/icons/tv-icon.png', 
            imageCaption: 'TVs',
          ),
          
          Categoria(
            imageLocation: 'images/icons/eletro-icon.png',
            imageCaption: 'Eletrodomésticos',
            ),
          
          Categoria(
            imageLocation: 'images/icons/smartphone-icon.png',
            imageCaption: 'Smartphones',
            ),
          
          Categoria(
            imageLocation: 'images/icons/smartwatch-icon.png',
            imageCaption: 'Smartwaches',
            ),
          
          Categoria(
            imageLocation: 'images/icons/headphone-icon.png',
            imageCaption: 'Headphones',
            ),
          
          Categoria(
            imageLocation: 'images/icons/pendrive-icon.png',
            imageCaption: 'Pendrives',
          ),
        ],
        ),
    );
  }
}

class Categoria extends StatelessWidget {
  const Categoria({
    super.key, 
    required this.imageLocation, 
    required this.imageCaption
  });

  //variables
  final String imageLocation;
  final String imageCaption;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(1.0),
    child: InkWell(onTap: (){
       Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ProductList(category: imageCaption),
          ));
    },
    child: Container(
      width: 150.0,
      alignment: Alignment.center,
      child: ListTile(
        title: Image.asset(imageLocation, width: 70, height: 50),
        subtitle: Container(
          alignment: Alignment.topCenter,
          child: Text(imageCaption),
        ) ,
        ),
    )
    ),
    );
  }
}