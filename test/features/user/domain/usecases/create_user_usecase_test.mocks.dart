// Mocks generated by Mockito 5.0.16 from annotations
// in the_resident_zombie/test/features/user/domain/usecases/create_user_usecase_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:the_resident_zombie/core/error/failures.dart' as _i5;
import 'package:the_resident_zombie/core/params/confirmation.dart' as _i7;
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart'
    as _i11;
import 'package:the_resident_zombie/features/items/domain/repository/items_repository.dart'
    as _i10;
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart'
    as _i9;
import 'package:the_resident_zombie/features/location/domain/repositories/location_repository.dart'
    as _i8;
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart'
    as _i6;
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i3.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.UserEntity>> createUser(String? name,
          int? age, String? gender, String? location, String? items) =>
      (super.noSuchMethod(
          Invocation.method(#createUser, [name, age, gender, location, items]),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.UserEntity>>.value(
              _FakeEither_0<_i5.Failure, _i6.UserEntity>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.UserEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.UserEntity>> updateUserLocation(
          String? id, String? location) =>
      (super.noSuchMethod(
          Invocation.method(#updateUserLocation, [id, location]),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.UserEntity>>.value(
              _FakeEither_0<_i5.Failure, _i6.UserEntity>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.UserEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> saveContact(String? id) =>
      (super.noSuchMethod(Invocation.method(#saveContact, [id]),
              returnValue: Future<_i2.Either<_i5.Failure, String>>.value(
                  _FakeEither_0<_i5.Failure, String>()))
          as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.UserEntity>> getUserEntityById(
          String? id) =>
      (super.noSuchMethod(Invocation.method(#getUserEntityById, [id]),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.UserEntity>>.value(
              _FakeEither_0<_i5.Failure, _i6.UserEntity>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.UserEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<String>>> getAllContactsIds() =>
      (super.noSuchMethod(Invocation.method(#getAllContactsIds, []),
              returnValue: Future<_i2.Either<_i5.Failure, List<String>>>.value(
                  _FakeEither_0<_i5.Failure, List<String>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<String>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.Confirmation>> flagUserAsInfected(
          String? id) =>
      (super.noSuchMethod(Invocation.method(#flagUserAsInfected, [id]),
          returnValue: Future<_i2.Either<_i5.Failure, _i7.Confirmation>>.value(
              _FakeEither_0<_i5.Failure, _i7.Confirmation>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i7.Confirmation>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.Confirmation>> tradeWithUser(
          String? pick, String? pay, String? otherUserName) =>
      (super.noSuchMethod(
          Invocation.method(#tradeWithUser, [pick, pay, otherUserName]),
          returnValue: Future<_i2.Either<_i5.Failure, _i7.Confirmation>>.value(
              _FakeEither_0<_i5.Failure, _i7.Confirmation>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i7.Confirmation>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [LocationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocationRepository extends _i1.Mock
    implements _i8.LocationRepository {
  MockLocationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i9.LocationEntity>>
      getCurrentLocation() =>
          (super.noSuchMethod(Invocation.method(#getCurrentLocation, []),
                  returnValue:
                      Future<_i2.Either<_i5.Failure, _i9.LocationEntity>>.value(
                          _FakeEither_0<_i5.Failure, _i9.LocationEntity>()))
              as _i4.Future<_i2.Either<_i5.Failure, _i9.LocationEntity>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [ItemsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockItemsRepository extends _i1.Mock implements _i10.ItemsRepository {
  MockItemsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i11.ItemEntity>>> getItemsType() =>
      (super.noSuchMethod(Invocation.method(#getItemsType, []),
              returnValue:
                  Future<_i2.Either<_i5.Failure, List<_i11.ItemEntity>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i11.ItemEntity>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i11.ItemEntity>>>);
  @override
  String toString() => super.toString();
}
