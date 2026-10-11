// Web-only implementation — compiled only when dart.library.html is available.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';

void triggerWebDownload(Uint8List bytes, String fileName) {
  final blob = html.Blob([bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..click();
  Future.delayed(const Duration(seconds: 2), () {
    html.Url.revokeObjectUrl(url);
  });
}

