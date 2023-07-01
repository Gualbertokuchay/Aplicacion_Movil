import 'package:flutter/material.dart';

class Guia extends StatefulWidget {
  const Guia({Key? key}) : super(key: key);

  @override
  State<Guia> createState() => _GuiaState();
}

class _GuiaState extends State<Guia> {
  List<String> problemas = [
    'Plagas',
    'Enfermedades',
    'Deficiencias nutricionales',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guía de Solución de Problemas'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: problemas.length,
        itemBuilder: (context, index) {
          final problema = problemas[index];
          return ListTile(
            title: Text(
              problema,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesProblema(problema: problema),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetallesProblema extends StatelessWidget {
  final String problema;

  const DetallesProblema({required this.problema, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          problema,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Consejos para solucionar el problema "$problema"',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Aquí puedes proporcionar consejos prácticos y soluciones para el problema seleccionado.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ConsejoWidget(
              titulo: 'Consejo 1:',
              descripcion:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean eget commodo mauris, nec laoreet nulla. Sed aliquet placerat turpis at posuere.',
            ),
            const SizedBox(height: 16),
            ConsejoWidget(
              titulo: 'Consejo 2:',
              descripcion:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean eget commodo mauris, nec laoreet nulla. Sed aliquet placerat turpis at posuere.',
            ),
          ],
        ),
      ),
    );
  }
}

class ConsejoWidget extends StatelessWidget {
  final String titulo;
  final String descripcion;

  const ConsejoWidget({
    required this.titulo,
    required this.descripcion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(descripcion),
          ],
        ),
      ),
    );
  }
}
