import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/features/user/data/models/user_model.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';

void main() {
  final tUserModel = UserModel(name: 'test', age: 1, gender: 'test');

  test('userModel should be a subclass of UserEntity', () async {
    // assert
    expect(tUserModel, isA<UserEntity>());
  });
}
