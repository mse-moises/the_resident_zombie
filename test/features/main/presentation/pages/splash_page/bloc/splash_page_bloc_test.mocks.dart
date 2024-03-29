// Mocks generated by Mockito 5.0.16 from annotations
// in the_resident_zombie/test/features/main/presentation/pages/splash_page/bloc/splash_page_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:the_resident_zombie/core/error/failures.dart' as _i7;
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart'
    as _i8;
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart'
    as _i2;
import 'package:the_resident_zombie/features/user/domain/usecases/get_local_user_usecase.dart'
    as _i5;
import 'package:the_resident_zombie/features/user/domain/usecases/get_user_by_id_usecase.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeUserRepository_0 extends _i1.Fake implements _i2.UserRepository {}

class _FakeGetUserByIdUseCase_1 extends _i1.Fake
    implements _i3.GetUserByIdUseCase {}

class _FakeEither_2<L, R> extends _i1.Fake implements _i4.Either<L, R> {}

/// A class which mocks [GetLocalUserUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetLocalUserUseCase extends _i1.Mock
    implements _i5.GetLocalUserUseCase {
  MockGetLocalUserUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeUserRepository_0()) as _i2.UserRepository);
  @override
  _i3.GetUserByIdUseCase get getUserById =>
      (super.noSuchMethod(Invocation.getter(#getUserById),
          returnValue: _FakeGetUserByIdUseCase_1()) as _i3.GetUserByIdUseCase);
  @override
  _i6.Future<_i4.Either<_i7.Failure, _i8.UserEntity>> call(
          _i5.GetLocalUserNoParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
          returnValue: Future<_i4.Either<_i7.Failure, _i8.UserEntity>>.value(
              _FakeEither_2<_i7.Failure, _i8.UserEntity>())) as _i6
          .Future<_i4.Either<_i7.Failure, _i8.UserEntity>>);
  @override
  String toString() => super.toString();
}
