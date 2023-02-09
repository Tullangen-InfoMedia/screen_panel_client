import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'commands.dart';

const int port = 8023;

late final String ip;
late final String key;
late final String browserPath;
late final String processName;
late final String os;

Future<void> connect() async {
  try {
    print("Attempting socket connection to $ip:$port");
    final Socket socket = await Socket.connect(ip, port);
    print("Connected to: ${socket.remoteAddress.address}:${socket.remotePort}");

    socket.listen(
      (Uint8List data) {
        final String command = String.fromCharCodes(data);
        print(command);
        handleCommand(socket, command.split("\n"));
      },
      onError: (error) {
        print("Error: $error");
      },
      onDone: () {
        print("Connection lost");
        socket.destroy();

        Future.delayed(const Duration(seconds: 10)).then((_) => connect());
      },
      cancelOnError: false,
    );

    print("Attempting authentication with key: $key");
    socket.add("AUTH:$key".codeUnits);

    void sendLiveRequest() {
      socket.add("LIVE".codeUnits);

      Future.delayed(const Duration(seconds: 15)).then((_) => sendLiveRequest());
    }

    Future.delayed(const Duration(seconds: 15)).then((_) => sendLiveRequest());
  } catch (e) {
    print("Error: $e");
    Future.delayed(const Duration(seconds: 10)).then((_) => connect());
  }
}

void main(List<String> arguments) async {
  ip = arguments.first;

  final File configFile = File("screen.config.json");
  final String configString = await configFile.readAsString();

  final Map configJson = jsonDecode(configString) as Map;

  os = configJson["OS"] as String;
  key = configJson["Key"] as String;
  browserPath = configJson["BrowserPath"] as String;
  processName = configJson["ProcessName"] as String;

  connect();
}
