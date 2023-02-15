import 'dart:convert';
import 'dart:io';

import 'browser.dart';
import 'main.dart';

void handleCommand(Socket socket, List<String> command) {
  switch (command.first) {
    case "INFO":
      String? encodedUrl;
      double scale = 1;

      for (final String dataLine in command) {
        if (dataLine.startsWith("URL")) {
          encodedUrl = dataLine.split(":").last;
        } else if (dataLine.startsWith("SCALE")) {
          scale = double.tryParse(dataLine.split(":").last) ?? scale;
        }
      }

      if (encodedUrl != null && encodedUrl.isNotEmpty) {
        launchUrl(String.fromCharCodes(base64Decode(encodedUrl)), scale);
      }

      break;
    case "REBOOT":
      print("Got reboot command");

      reboot();

      break;
    default:
      print("Unknown command: ${command.first}");
  }
}

Future<void> reboot() async {
  switch (os) {
    case "windows":
      await Process.run("shutdown", ["/r", "/t", "0"]);
      break;
    case "linux":
      await Process.run("sudo", ["systemctl", "start", "reboot.target"]);
      break;
  }
}
