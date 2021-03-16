import 'dart:async';

import 'package:flutter/services.dart';

class HeicToJpg {
  static const MethodChannel _channel = const MethodChannel('heic_to_jpg');

  /// Convert HEIC/HEIF Image to JPEG Image.
  /// Get [heicPath] path as an input and return [jpg] path.
  /// You can set [jpgPath] if you want to set the output file path.
  /// If you don't set it the output file path is made in cache directory of each platform.
  static Future<String?> convert(String heicPath, {String? jpgPath}) async {
    final String? jpg = await _channel
        .invokeMethod('convert', {"heicPath": heicPath, "jpgPath": jpgPath});
    return jpg;
  }
}
