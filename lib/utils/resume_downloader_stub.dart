import 'dart:typed_data';

// Stub for non-web platforms (macOS, Android, iOS, Windows, Linux).
// url_launcher / Process handles opening the PDF on these platforms.
void triggerWebDownload(Uint8List bytes, String fileName) {
  // No-op on non-web platforms; local file handling is used instead.
}

