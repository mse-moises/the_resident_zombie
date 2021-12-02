// Mocks generated by Mockito 5.0.16 from annotations
// in the_resident_zombie/test/features/user/presentation/trade/trade_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i8;

import 'package:dartz/dartz.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:the_resident_zombie/core/error/failures.dart' as _i9;
import 'package:the_resident_zombie/core/params/confirmation.dart' as _i10;
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart'
    as _i12;
import 'package:the_resident_zombie/features/items/domain/repository/items_repository.dart'
    as _i6;
import 'package:the_resident_zombie/features/items/domain/usecase/compare_backpack_usecase.dart'
    as _i4;
import 'package:the_resident_zombie/features/items/domain/usecase/get_backpack_from_numbers_usecase.dart'
    as _i3;
import 'package:the_resident_zombie/features/items/domain/usecase/get_items_type_usecase.dart'
    as _i11;
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart'
    as _i2;
import 'package:the_resident_zombie/features/user/domain/usecases/trade_with_user_usecase.dart'
    as _i7;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeUserRepository_0 extends _i1.Fake implements _i2.UserRepository {}

class _FakeGetBackpackFromNumbersUsecase_1 extends _i1.Fake
    implements _i3.GetBackpackFromNumbersUsecase {}

class _FakeCompareBackpackUsecase_2 extends _i1.Fake
    implements _i4.CompareBackpackUsecase {}

class _FakeEither_3<L, R> extends _i1.Fake implements _i5.Either<L, R> {}

class _FakeItemsRepository_4 extends _i1.Fake implements _i6.ItemsRepository {}

/// A class which mocks [TradeWithUserUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockTradeWithUserUseCase extends _i1.Mock
    implements _i7.TradeWithUserUseCase {
  MockTradeWithUserUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeUserRepository_0()) as _i2.UserRepository);
  @override
  _i3.GetBackpackFromNumbersUsecase get getBackpackUsecase =>
      (super.noSuchMethod(Invocation.getter(#getBackpackUsecase),
              returnValue: _FakeGetBackpackFromNumbersUsecase_1())
          as _i3.GetBackpackFromNumbersUsecase);
  @override
  _i4.CompareBackpackUsecase get compareUsecase =>
      (super.noSuchMethod(Invocation.getter(#compareUsecase),
              returnValue: _FakeCompareBackpackUsecase_2())
          as _i4.CompareBackpackUsecase);
  @override
  _i8.Future<_i5.Either<_i9.Failure, _i10.Confirmation>> call(
          _i7.TradeParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
          returnValue: Future<_i5.Either<_i9.Failure, _i10.Confirmation>>.value(
              _FakeEither_3<_i9.Failure, _i10.Confirmation>())) as _i8
          .Future<_i5.Either<_i9.Failure, _i10.Confirmation>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetItemsTypeUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetItemsTypeUseCase extends _i1.Mock
    implements _i11.GetItemsTypeUseCase {
  MockGetItemsTypeUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.ItemsRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeItemsRepository_4()) as _i6.ItemsRepository);
  @override
  _i8.Future<_i5.Either<_i9.Failure, List<_i12.ItemEntity>>> call(
          _i11.GetItemsTypeNoParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue:
                  Future<_i5.Either<_i9.Failure, List<_i12.ItemEntity>>>.value(
                      _FakeEither_3<_i9.Failure, List<_i12.ItemEntity>>()))
          as _i8.Future<_i5.Either<_i9.Failure, List<_i12.ItemEntity>>>);
  @override
  String toString() => super.toString();
}