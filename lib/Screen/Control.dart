// import 'package:flutter/material.dart';

// class ControlClima extends StatefulWidget {
//   const ControlClima({Key? key}) : super(key: key);

//   @override
//   State<ControlClima> createState() => _ControlClimaState();
// }

// class _ControlClimaState extends State<ControlClima> {
//   bool iluminacion = false;

//   void cambiarIluminacion(bool value) {
//     setState(() {
//       iluminacion = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Control de Clima'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ControlWidget(
//               title: 'Iluminación',
//               value: iluminacion,
//               onChanged: cambiarIluminacion,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ControlWidget extends StatelessWidget {
//   final String title;
//   final bool value;
//   final ValueChanged<bool> onChanged;

//   const ControlWidget({
//     required this.title,
//     required this.value,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.green,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: ListTile(
//         title: Text(
//           title,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 44, 39, 39)),
//         ),
//         trailing: Switch(
//           value: value,
//           onChanged: onChanged,
//           activeColor: Colors.white,
//         ),
//       ),
//     );
//   }
// }
