// Web-only implementation — compiled only when dart.library.html is available.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

void triggerWebDownload(String assetPath, String fileName) {
  final anchor = html.AnchorElement(href: assetPath)
    ..setAttribute('download', fileName)
    ..click();
}
