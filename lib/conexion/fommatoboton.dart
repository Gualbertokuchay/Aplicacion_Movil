// import 'package:flutter/material.dart';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';

// class ConexionMqtt {
//   late MqttServerClient client;

//   ConexionMqtt() {
//     client = MqttServerClient('broker.emqx.io', 'mqttx_25474d23');
//     client.port = 1883;
//     client.logging(on: true);
//   }

//   void connect() async {
//     try {
//       await client.connect();
//       print('Connected to MQTT broker');
//     } catch (e) {
//       print('Exception: $e');
//       client.disconnect();
//     }
//   }

//   void disconnect() {
//     if (client.connectionStatus!.state == MqttConnectionState.connected) {
//       client.disconnect();
//       print('Disconnected from MQTT broker');
//     }
//   }

//   void publishMessage(String topic, String message) {
//     if (client.connectionStatus!.state == MqttConnectionState.connected) {
//       final builder = MqttClientPayloadBuilder();
//       builder.addString(message);
//       client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
//       print('Published message: $message');
//     }
//   }
// }

// class ControlClima extends StatefulWidget {
//   const ControlClima({Key? key}) : super(key: key);

//   @override
//   State<ControlClima> createState() => _ControlClimaState();
// }

// class _ControlClimaState extends State<ControlClima> {
//   bool iluminacion = false;
//   late ConexionMqtt mqttClient;

//   @override
//   void initState() {
//     super.initState();
//     mqttClient = ConexionMqtt();
//     mqttClient.connect();
//   }

//   void cambiarIluminacion(bool value) {
//     setState(() {
//       iluminacion = value;
//       if (iluminacion) {
//         mqttClient.publishMessage('My/topic', '0');
//         print('Mensaje enviado: 0');
//       } else {
//         mqttClient.publishMessage('My/topic', '1');
//         print('Mensaje enviado: 1');
//       }
//     });
//   }

//   @override
//   void dispose() {
//     mqttClient.disconnect();
//     super.dispose();
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
