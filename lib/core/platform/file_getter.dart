import 'dart:io';

abstract class FileGetter {
  Future<String> getFile(String name);
}

class FileGetterImpl implements FileGetter {
  @override
  Future<String> getFile(String name) {
    return Future.value(File('assets/json/$name').readAsStringSync());

  }
}
