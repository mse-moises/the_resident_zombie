// Mocks generated by Mockito 5.0.16 from annotations
// in the_resident_zombie/test/features/user/data/repositories/user_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:the_resident_zombie/core/platform/network_info.dart' as _i6;
import 'package:the_resident_zombie/features/user/data/datasources/user_cache_data_source.dart'
    as _i3;
import 'package:the_resident_zombie/features/user/data/datasources/user_remote_data_source.dart'
    as _i5;
import 'package:the_resident_zombie/features/user/data/models/user_model.dart'
    as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeUserModel_0 extends _i1.Fake implements _i2.UserModel {}

/// A class which mocks [UserCacheDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserCacheDataSource extends _i1.Mock
    implements _i3.UserCacheDataSource {
  MockUserCacheDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.UserModel> getUser() =>
      (super.noSuchMethod(Invocation.method(#getUser, []),
              returnValue: Future<_i2.UserModel>.value(_FakeUserModel_0()))
          as _i4.Future<_i2.UserModel>);
  @override
  _i4.Future<void> cacheNumberTrivia(_i2.UserModel? userToCache) =>
      (super.noSuchMethod(Invocation.method(#cacheNumberTrivia, [userToCache]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [UserRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRemoteDataSource extends _i1.Mock
    implements _i5.UserRemoteDataSource {
  MockUserRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.UserModel> createUser(
          String? name, int? age, String? gender) =>
      (super.noSuchMethod(Invocation.method(#createUser, [name, age, gender]),
              returnValue: Future<_i2.UserModel>.value(_FakeUserModel_0()))
          as _i4.Future<_i2.UserModel>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i6.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnect =>
      (super.noSuchMethod(Invocation.getter(#isConnect),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  String toString() => super.toString();
}
