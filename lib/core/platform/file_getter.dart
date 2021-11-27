import 'dart:io';

String getFile(String name) => File('assets/json/$name').readAsStringSync();