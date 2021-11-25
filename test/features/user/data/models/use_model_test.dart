import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/features/user/data/models/user_model.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tUserModel = UserModel(name: 'Fabio Akita', age: 30, gender: 'M');

  test('userModel should be a subclass of UserEntity', () async {
    // assert
    expect(tUserModel, isA<UserEntity>());
  });

  group('fromJson', () {
    test('return a valid model from JSON',
      () async {
        // arrange
        final Map<String,dynamic>  jsonMap = json.decode(fixture('user.json'));
        // act
        final result = UserModel.fromJson(jsonMap);
        // assert
        expect(result, tUserModel);
      }
    );
  }
  );
}
