import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

abstract class FileGetter {
  Future<String> getFile(String path);
}

class FileGetterImpl implements FileGetter {
  @override
  Future<String> getFile(String path) async {
    return await rootBundle.loadString("$path.json");
  }
}
