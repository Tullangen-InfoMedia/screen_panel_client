import 'dart:io';

import 'main.dart';

Future<void> launchUrl(String url, double scale) async {
  switch (os) {
    case "windows":
      await Process.run("taskkill", ["/IM", processName, "/F"]);
      await Process.run(
        browserPath,
        ["--ignore-certificate-errors", "--aggressive-cache-discard", "--force-device-scale-factor=$scale", "--kiosk", "--app=$url"],
      );
      break;
    case "linux":
      await Process.run("killall", ["-9", processName]);
      final ProcessResult result = await Process.run(
        browserPath,
        ["--ignore-certificate-errors", "--aggressive-cache-discard", "--force-device-scale-factor=$scale", "--kiosk", "--app=$url"],
      );
      print(result.stderr);
      break;
  }
}
