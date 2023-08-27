import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;

  const BottomBar({required this.currentIndex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista de ícones para a BottomBar
    List<IconData> icons = [
      Icons.home,
      Icons.favorite,
      Icons.notifications_active,
      Icons.person,
      Icons.settings,
    ];

    // Retorna uma BottomAppBar com uma série de ícones
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
            color: Color.fromARGB(255, 217, 70, 119), // Cor da borda personalizada
            width: 2.0, // Largura da borda
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < icons.length; i++)
              // Aplica escala apenas ao ícone selecionado para criar um efeito visual
              Transform.scale(
                scale: currentIndex == i ? 1.2 : 1.0, // Aumenta o tamanho para o ícone selecionado
                child: Icon(
                  icons[i],
                  color: currentIndex == i
                      ? Color.fromARGB(255, 217, 70, 119) // Cor personalizada para o ícone selecionado
                      : Colors.grey, // Cor cinza para ícones não selecionados
                ),
              ),
          ],
        ),
      ),
    );
  }
}
