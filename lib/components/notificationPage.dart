import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'bottom_bar.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Notificações',
          backgroundColor: Color.fromARGB(255, 217, 70, 119),
        ),
      body: Container(
        // Adicionar outros widgets ou conteúdo da página de notificações aqui
      ),
       bottomNavigationBar: BottomBar(),
    );
  }
}
