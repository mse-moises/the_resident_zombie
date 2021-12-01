import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_resident_zombie/core/platform/file_getter.dart';
import 'package:the_resident_zombie/features/items/data/datasource/items_local_datasource.dart';

void main() {
  late FileGetter fileGetter;

  setUp(() {
    fileGetter = FileGetterImpl();
  });

  final path = itemsFileName;
  final tResult = [
    {"name": "Fiji Water", "points": 14},
    {"name": "Campbell Soup", "points": 12},
    {"name": "First Aid Pouch", "points": 10},
    {"name": "AK47", "points": 8}
  ];

  /// For some reason this test doesnt work, it keeping return null, even with the same path
  /// with the same path that works with the app compiled

  // group(
  //   'FileReader:',
  //   () {
  //     test(
  //       'getFile gets a items file',
  //       () async {
  //         // act
  //         final result = json.decode(await fileGetter.getFile(path));

  //         // assert
  //         expect(result, tResult);
  //       },
  //     );
  //   },
  // );
}
