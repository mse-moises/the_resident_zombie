import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_resident_zombie/core/platform/file_getter.dart';

void main() {

  final tName = "items.json";
  final tResult = [{ "name": "Fiji Water", "points": 14 }, { "name": "Campbell Soup", "points": 12 }, { "name": "First Aid Pouch", "points": 10 }, { "name": "AK47", "points": 8 }];
  test(
    'getFile gets a items file',
    () async {
      // act
      final result = json.decode(getFile(tName));

      // assert
      expect(result,tResult);
    },
  );
}
