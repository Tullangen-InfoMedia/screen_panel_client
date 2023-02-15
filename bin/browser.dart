import 'dart:io';

import 'main.dart';

Future<void> launchUrl(String url, double scale) async {
  final List<String> browserArgs = [
    "--ignore-certificate-errors",
    "--aggressive-cache-discard",
    "--device-scale-factor=$scale",
    "--force-device-scale-factor=$scale",
    "--kiosk",
    "--app=$url"
  ];

  for (final String arg in browserArgs) {
    print(arg);
  }

  switch (os) {
    case "windows":
      await Process.run("taskkill", ["/IM", processName, "/F"]);
      final ProcessResult result = await Process.run(browserPath, browserArgs);
      print(result.stderr);
      break;
    case "linux":
      await Process.run("killall", ["-9", processName]);
      final ProcessResult result = await Process.run(browserPath, browserArgs);
      print(result.stderr);
      break;
  }
}
