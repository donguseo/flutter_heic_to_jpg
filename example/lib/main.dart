import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String heicUrl = 'https://filesamples.com/samples/image/heic/sample1.heic';
  String? jpeg;
  bool initialized = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (initialized) return;
    initialized = true;
    WidgetsBinding.instance!.addPostFrameCallback((Duration timeStamp) async {
      String? tmp = await showDialog(
        builder: (context) => FutureProgressDialog(downloadAndConvert()),
          context: context,
      );
      setState(() {
        jpeg = tmp;
      });
    });
  }

  Future<String?> downloadAndConvert() async {
    File heicFile = await _downloadFile(heicUrl, 'a.heic');
    String convertedPath = (await getTemporaryDirectory()).path + "/b.heic";
    return HeicToJpg.convert(heicFile.path, jpgPath: convertedPath);
  }

  @override
  Widget build(BuildContext context) {
    initPlatformState();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: (jpeg != null && jpeg!.isNotEmpty)
            ? Image.file(File(jpeg!))
            : Text('No Image'),
      ),
    );
  }

  static var httpClient = new HttpClient();
  Future<File> _downloadFile(String url, String filename) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getTemporaryDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}
