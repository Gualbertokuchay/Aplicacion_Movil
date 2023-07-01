import 'dart:async';

import 'package:flutter/material.dart';
import 'package:invernadero/login.dart';

class WelcomeViewModel {}

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  final WelcomeViewModel viewModel = WelcomeViewModel();
  bool showButton = true; // Estado para controlar la visibilidad del botón
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;
  late Animation<double> _shakeAnimation;
  late Timer _timer;
  int jumpCount = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4), // Ajusta la duración de la animación
    );

    _rotateAnimation =
        Tween<double>(begin: 0, end: 2 * 3.14159).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut, // Cambia la curva de animación
    ));

    _shakeAnimation = Tween<double>(begin: -10, end: 10).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (jumpCount < 3) {
          // Meneo de derecha a izquierda
          _animationController.reverse();
          Timer(Duration(milliseconds: 500), () {
            _animationController.forward();
          });
          jumpCount++;
        } else {
          // Detener la animación por 2 segundos
          _animationController.reset();
          Timer(Duration(seconds: 2), () {
            _animationController.forward();
          });
          jumpCount = 0; // Reiniciar el contador de saltos
        }
      }
    });

    _animationController.forward();

    // Iniciar el timer para reiniciar la animación cada 2 segundos
    _timer = Timer.periodic(Duration(seconds: 2), (_) {
      setState(() {
        showButton = true;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel(); // Cancelar el timer al finalizar
    super.dispose();
  }

  void navigateToNextPage() {
    setState(() {
      showButton = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.green[100], // Fondo en tono verde claro para la naturaleza
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotateAnimation.value,
                  child: Transform.translate(
                    offset: Offset(_shakeAnimation.value, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Image.asset(
                        'assets/calentamiento2.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 14),
            Text(
              "Bienvenido a nuestro sistema de invernaderos",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Texto en color negro para mayor contraste
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30), // Ajusta la separación entre el texto y el botón
            showButton
                ? GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity! > 0) {
                        // Deslizamiento hacia la derecha
                        navigateToNextPage();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 50), // Margen superior para bajar el botón
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green[900], // Botón en tono verde oscuro
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white, // Icono en color blanco para mayor contraste
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Desliza",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white, // Texto en color blanco para mayor contraste
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
