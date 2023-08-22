// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';

//my own imports
import 'package:fusion_shop_app/components/horizontal_listview.dart';
import 'package:fusion_shop_app/components/recents_products_home.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomePage(),
    )
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 200,
      width: 200,
      child: AnotherCarousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/carousel/tvs.jpg'),
          AssetImage('images/carousel/eletros.jpg'),
          AssetImage('images/carousel/smartphones.png'),
          AssetImage('images/carousel/smartwaches.png'),
          AssetImage('images/carousel/headphones.png'),
          AssetImage('images/carousel/pendrives.jpg')
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 800),
        dotSize: 4.0,
        // dotColor:  const Color.fromARGB(144, 158, 158, 158),
        indicatorBgPadding: 5.0,
      ),
    );
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromARGB(255, 217, 70, 119),
        title: const Text('Fusion Shop'),
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.search, color: Colors.white,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart, color: Colors.white,)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
          //header
          UserAccountsDrawerHeader(
            accountName: Text('Code Fusion'), 
            accountEmail: Text('codefusion@email.com'),
          currentAccountPicture: GestureDetector(
            child: new CircleAvatar(
              backgroundColor: Color.fromARGB(255, 44, 207, 226),
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
          decoration: new BoxDecoration(
            color: Color.fromARGB(255, 217, 70, 119),
          ),
          ),

          //body
        InkWell(
          onTap: (){},
          child: ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home, color: Colors.purple[300]),
          ),
        ),

        InkWell(
          onTap: (){},
          child: ListTile(
            title: Text('Minha conta'),
            leading: Icon(Icons.person, color: Colors.purple[300]),
          ),
        ),

        InkWell(
          onTap: (){},
          child: ListTile(
            title: Text('Meus pedidos'),
            leading: Icon(Icons.shopping_basket, color: Colors.purple[300]),
          ),
        ),

        InkWell(
          onTap: (){},
          child: ListTile(
            title: Text('Categorias'),
            leading: Icon(Icons.dashboard, color: Colors.purple[300]),
          ),
        ),

        InkWell(
          onTap: (){},
          child: ListTile(
            title: Text('Favoritos'),
            leading: Icon(Icons.favorite, color: Colors.purple[300]),
          ),
        ),

        Divider(),

        InkWell(
          onTap: (){},
          child: ListTile(
            title: Text('Configuração'),
            leading: Icon(Icons.settings),
          ),
        ),

        InkWell(
          onTap: (){},
          child: ListTile(
            title: Text('Sobre'),
            leading: Icon(Icons.help, color: Color.fromARGB(255, 4, 164, 250)),
          ),
        ),
        ],
      ),
    ),
    body: new ListView(
      children: <Widget>[
        //image carousel home
        image_carousel,

        //padding widget
        new Padding(padding: const EdgeInsets.all(15.0),
        child:new Text('Categorias'),),

        //Horizontal list view begins here
        HorizontalList(),

        //padding widget
        new Padding(padding: const EdgeInsets.all(18),
          child: new Text('Produtos recentes'),
        ),
        
        //grid view
        Container(
          height: 320,
          child: RecentsProducts(),
        ),
      ],
    ),
   );
  }
}
