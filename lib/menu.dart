import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:invernadero/Screen/Calendario.dart';
import 'package:invernadero/Screen/Comunidad.dart';
import 'package:invernadero/Screen/Gu%C3%ADa.dart';
import 'package:invernadero/conexion/datos.dart';


class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ConexionMqtt(),
  ];

  final List<IconData> _icons = [
    Icons.contact_emergency, // Icono para Calendario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Invernadero'),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.indicator,
        snakeViewColor: Colors.black,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _icons.map((icon) {
          return BottomNavigationBarItem(
            icon: Icon(icon),
            label: '',
          );
        }).toList(),
      ),
    );
  }
}
