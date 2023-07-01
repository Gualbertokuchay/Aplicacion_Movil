import 'package:flutter/material.dart';

class Comunidad extends StatefulWidget {
  const Comunidad({Key? key}) : super(key: key);

  @override
  State<Comunidad> createState() => _ComunidadState();
}

class _ComunidadState extends State<Comunidad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunidad de Agricultores'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenido a la Comunidad de Agricultores',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  'Aquí puedes conectarte con otros agricultores, compartir experiencias y hacer preguntas relacionadas con la agricultura en invernaderos.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción al hacer clic en el botón de "Publicar"
                    },
                    child: const Text('Publicar'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Últimas publicaciones',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // Aquí puedes agregar una lista de publicaciones
              ],
            ),
          ),
        ],
      ),
    );
  }
}
