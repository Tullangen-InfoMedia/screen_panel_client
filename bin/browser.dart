import 'dart:io';

import 'main.dart';

Future<void> launchUrl(String url) async {
  switch (os) {
    case "windows":
      await Process.run("taskkill", ["/IM", processName, "/F"]);
      await Process.run(browserPath, ["--ignore-certificate-errors", "--aggressive-cache-discard", "--kiosk", "--app=$url"]);
      break;
    case "linux":
      await Process.run("killall", ["-9", processName]);
      final ProcessResult result =
          await Process.run(browserPath, ["--ignore-certificate-errors", "--aggressive-cache-discard", "--kiosk", "--app=$url"]);
      print(result.stdout);
      print(result.stderr);
      break;
  }
}
