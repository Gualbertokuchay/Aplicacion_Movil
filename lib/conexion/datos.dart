import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';

class ConexionMqttViewModel extends ChangeNotifier {
  late MqttServerClient client;
  bool isConnected = false;
  bool isSubscribed = false;
  bool switchValue = false; // Estado del interruptor

  ConexionMqttViewModel() {
    client = MqttServerClient('broker.emqx.io', 'mqttx_eb5cefaf');
    client.port = 1883;
    client.logging(on: true);
    client.onConnected = _onConnected;
    client.onDisconnected = _onDisconnected;
    client.onSubscribed = _onSubscribed;
    client.onSubscribeFail = _onSubscribeFail;
    client.onUnsubscribed = _onUnsubscribed;
    client.pongCallback = _pong;
    client.secure = false; // No se utiliza seguridad TLS

    final connMessage = MqttConnectMessage()
        .keepAliveFor(60)
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce)
        .withClientIdentifier('myClientId')
        .authenticateAs('user', 'pass'); // Agregar el nombre de usuario y contraseña
    client.connectionMessage = connMessage;

    connect();
  }

  void _onConnected() {
    isConnected = true;
    print('Connected to MQTT broker');
    notifyListeners();
  }

  void _onDisconnected() {
    isConnected = false;
    isSubscribed = false;
    print('Disconnected from MQTT broker');
    notifyListeners();
  }

  void _onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  void _onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  void _onUnsubscribed(String? topic) {
    print('Unsubscribed topic: $topic');
  }

  void _pong() {
    print('Ping response client callback invoked');
  }

  Future<void> connect() async {
    try {
      await client.connect();
      print('Connected to MQTT broker');
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(message.payload.message);

      print('Received message: $payload from topic: ${c[0].topic}>');
    });
  }

  void publishMessage(String message) {
    if (isConnected) {
      final topic = 'foco14';
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
      print('Published message: $message');
    }
  }

  void subscribe() {
    if (isConnected && !isSubscribed) {
      final topic = 'foco14';
      client.subscribe(topic, MqttQos.atLeastOnce);
      isSubscribed = true;
      print('Subscribed to topic: $topic');
      notifyListeners();
    }
  }

  void unsubscribe() {
    if (isConnected && isSubscribed) {
      final topic = 'foco14';
      client.unsubscribe(topic);
      isSubscribed = false;
      print('Unsubscribed from topic: $topic');
      notifyListeners();
    }
  }

  void disconnect() {
    if (isConnected) {
      client.disconnect();
      isConnected = false;
      isSubscribed = false;
      print('Disconnected from MQTT broker');
      notifyListeners();
    }
  }

  @override
  void dispose() {
    client.disconnect();
    super.dispose();
  }
}

class ConexionMqttView extends StatelessWidget {
  final ConexionMqttViewModel viewModel;

  const ConexionMqttView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MQTT Connection'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Device Status:',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    SizedBox(height: 8),
                    SwitchListTile(
                      title: Text('Activar Focos'),
                      value: viewModel.switchValue,
                      onChanged: (value) {
                        viewModel.switchValue = value; // Actualiza el valor del interruptor
                        if (viewModel.isConnected) {
                          viewModel.publishMessage(value ? '0' : '1'); // Envía '1' si está activado, '0' si está desactivado
                        }
                        viewModel.notifyListeners();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConexionMqtt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConexionMqttViewModel(),
      child: Consumer<ConexionMqttViewModel>(
        builder: (context, viewModel, _) {
          return ConexionMqttView(viewModel: viewModel);
        },
      ),
    );
  }
}
