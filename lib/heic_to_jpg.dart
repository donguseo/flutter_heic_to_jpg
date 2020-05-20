import 'dart:async';

import 'package:flutter/services.dart';

class HeicToJpg {
  static const MethodChannel _channel =
      const MethodChannel('heic_to_jpg');

  /// Convert HEIC/HEIF Image to JPEG Image. 
  /// Get [heic] path as an input and return [jpg] path. 
  static Future<String> convert(String heic) async {
    final String jpg = await _channel.invokeMethod('convert', {"heicPath" : heic});
    return jpg;
  }
}
