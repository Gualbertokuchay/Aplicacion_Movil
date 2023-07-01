import 'package:flutter/material.dart';

class CatalogoPlantas extends StatefulWidget {
  const CatalogoPlantas({Key? key}) : super(key: key);

  @override
  State<CatalogoPlantas> createState() => _CatalogoPlantasState();
}

class _CatalogoPlantasState extends State<CatalogoPlantas> {
  final List<Map<String, dynamic>> plantas = [
    {
      'nombre': 'Fragaria',
      'imagenUrl': 'https://upload.wikimedia.org/wikipedia/commons/c/cd/Strawberry_Seedling.jpg',
      'temperatura': '20-25°C',
      'luzSolar': 'Alta',
      'cuidados': 'Riego diario',
    },
    {
      'nombre': 'Chaya',
      'imagenUrl': 'https://www.gob.mx/cms/uploads/article/main_image/18160/chaya.jpg',
      'temperatura': '18-22°C',
      'luzSolar': 'Media',
      'cuidados': 'Riego cada 2 días',
    },
    {
      'nombre': 'Sapote',
      'imagenUrl': 'https://cdn.shopify.com/s/files/1/0416/6438/1085/products/MameyTree-3.jpg?v=1680181415',
      'temperatura': '18-22°C',
      'luzSolar': 'Media',
      'cuidados': 'Riego cada 2 días',
    },
    {
      'nombre': 'Ciruela',
      'imagenUrl': 'https://www.mexicodesconocido.com.mx/wp-content/uploads/2020/04/1475786695881-1-900x506.jpg',
      'temperatura': '18-22°C',
      'luzSolar': 'Media',
      'cuidados': 'Riego cada 2 días',
    },
    {
      'nombre': 'Henequén',
      'imagenUrl': 'https://www.gob.mx/cms/uploads/image/file/421074/Henequ_n_2.jpg',
      'temperatura': '20-30°C',
      'luzSolar': 'Alta',
      'cuidados': 'Riego moderado',
    },
    {
      'nombre': 'Chacá',
      'imagenUrl': 'https://www.yucatan.gob.mx/docs/galerias/chaka/1.jpg',
      'temperatura': '25-35°C',
      'luzSolar': 'Alta',
      'cuidados': 'Riego regular',
    },
    {
      'nombre': 'Flor de Mayo',
      'imagenUrl': 'https://lh4.ggpht.com/XdpBgyAd4vwPAhEubN0owRP56KH3mxwjcbIZu1oYZbv1hiQiHksOhp-aXoldMJ4i5p9T-zgPwZ3-qnC6iHw=s600',
      'temperatura': '25-35°C',
      'luzSolar': 'Media',
      'cuidados': 'Riego frecuente',
    },
    {
      'nombre': 'Pitahaya',
      'imagenUrl': 'https://cdn0.ecologiaverde.com/es/posts/1/1/2/cuidados_de_la_pitaya_para_su_cultivo_2211_1_600.jpg',
      'temperatura': '20-30°C',
      'luzSolar': 'Alta',
      'cuidados': 'Riego escaso',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Catálogo de plantas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: plantas.length,
          itemBuilder: (context, index) {
            final planta = plantas[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetallesPlanta(planta: planta),
                  ),
                );
              },
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.network(
                          planta['imagenUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              planta['nombre'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Temperatura: ${planta['temperatura']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Luz solar: ${planta['luzSolar']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Cuidados: ${planta['cuidados']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetallesPlanta extends StatelessWidget {
  final Map<String, dynamic> planta;

  const DetallesPlanta({required this.planta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planta['nombre']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Hero(
                tag: planta['nombre'],
                child: Image.network(
                  planta['imagenUrl'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Temperatura: ${planta['temperatura']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Luz solar: ${planta['luzSolar']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Cuidados: ${planta['cuidados']}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
