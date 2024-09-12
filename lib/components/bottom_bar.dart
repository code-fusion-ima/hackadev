import 'package:flutter/material.dart';
import 'cart.dart';
import 'notificationPage.dart';
import 'profilePage.dart';
import 'settingsPage.dart';
import 'package:fusion_shop_app/main.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  // Defina a página inicial como a página inicial
  Widget _currentPage = HomePage();

  final List<Map<String, dynamic>> _pages = [
    {'page': HomePage(), 'icon': Icons.home},
    {'page': Carrinho(), 'icon': Icons.shopping_cart},
    {'page': NotificationPage(), 'icon': Icons.notifications_active},
    {'page': ProfilePage(), 'icon': Icons.person},
    {'page': SettingsPage(), 'icon': Icons.settings},
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: Colors.transparent,
      elevation: 9.0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          color: Colors.white,
          border: Border.all(
            color: Color.fromARGB(255, 217, 70, 119),
            width: 2.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildButtons(),
        ),
      ),
    );
  }

  List<Widget> _buildButtons() {
    return _pages.asMap().entries.map((entry) {
      final int index = entry.key;
      final Map<String, dynamic> pageData = entry.value;
      final Widget page = pageData['page'];

      return IconButton(
        icon: Icon(
          pageData['icon'],
          size: 30.0,
          color: _currentPage == page ? Colors.pink : Colors.black,
        ),
        onPressed: () {
          setState(() {
            _currentPage = page;
          });

          // Navegue para a página correspondente
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      );
    }).toList();
  }
}
