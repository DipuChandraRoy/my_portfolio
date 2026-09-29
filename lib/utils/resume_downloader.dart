// resume_downloader.dart
// Platform-agnostic resume download helper.
// Uses conditional imports so dart:html is only compiled on web builds.

export 'resume_downloader_stub.dart'
    if (dart.library.html) 'resume_downloader_web.dart';
