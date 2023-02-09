import 'dart:convert';
import 'dart:io';

import 'browser.dart';

void handleCommand(Socket socket, List<String> command) {
  switch (command.first) {
    case "INFO":
      print("Got info: $command");

      for (final String dataLine in command) {
        if (dataLine.startsWith("URL")) {
          final String encodedUrl = dataLine.split(":").last;
          if (encodedUrl.isNotEmpty) {
            launchUrl(String.fromCharCodes(base64Decode(encodedUrl)));
          }
          break;
        }
      }

      break;
    default:
      print("Unknown command: ${command.first}");
  }
}
