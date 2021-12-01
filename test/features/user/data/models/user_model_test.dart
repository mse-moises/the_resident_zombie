import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:the_resident_zombie/features/user/data/models/user_model.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tUserModel =
      UserModel(id: '21cb70ac-4783-4bdf-8a03-575661d06bfd', name: 'teste59', age: 5, gender: 'F', infected:false);

  group(
    'User model:',
    () {
      test('userModel should be a subclass of UserEntity', () async {
        // assert
        expect(tUserModel, isA<UserEntity>());
      });

      test('return a valid model from JSON', () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('user.json'));
        // act
        final result = UserModel.fromJson(jsonMap);
        // assert
        expect(result, tUserModel);
      });

      test('return a valid JSON from model', () async {
        // arrange
        final result = tUserModel.toJson();
        // act
        final expectMap = {
          "id":"21cb70ac-4783-4bdf-8a03-575661d06bfd",
          "name": "teste59",
          "age": 5,
          "gender": "F",
          "infected":false
        };

        final tUserExpected = UserModel.fromJson(expectMap);

        // assert

        expect(result, expectMap);
      });
    },
  );
}
