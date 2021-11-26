import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_resident_zombie/features/location/data/models/location_model.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tLocationModel = LocationModel(x: 0, y: 0);

  test(
    'locationModel should be a subclass of LocationEntity',
    () async {
      // assert
      expect(tLocationModel, isA<LocationEntity>());
    },
  );

  group(
    'last location',
    () {
      final tString = "POINT (0.0 0.0)";
      test(
        'return a valid String from model method to String',
        () async {
          // arrange
          final expectString = tString;

          // act
          final result = tLocationModel.toString();

          // assert
          expect(result, equals(tString));
        },
      );

      test(
        'return a valid Model from String',
        () async {
          // act
          final result = LocationModel.fromString(tString);

          // assert
          expect(result, equals(tLocationModel));
        },
      );

      test(
        'return a valid Model from JSON',
        () async {
          // act
          final result = LocationModel.fromJson(json.decode(fixture('user.json')));

          // assert
          expect(result, isA<LocationModel>());
          

        },
      );
    },
  );
}
