import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/core/params/confirmation.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/compare_backpack_usecase.dart';

import 'package:the_resident_zombie/features/items/domain/usecase/get_backpack_from_numbers_usecase.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_items_type_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/trade_with_user_usecase.dart';

import 'create_user_usecase_test.mocks.dart';

void main() {
  late MockUserRepository userRepository;
  late MockItemsRepository itemsRepository;

  late GetItemsTypeUseCase getItemsType;
  late CompareBackpackUsecase compareUsecase;
  late GetBackpackFromNumbersUsecase getBackpackUsecase;
  late TradeWithUserUseCase usecase;

  setUp(() {
    userRepository = MockUserRepository();
    itemsRepository = MockItemsRepository();

    compareUsecase = CompareBackpackUsecase();
    getItemsType = GetItemsTypeUseCase(itemsRepository);
    getBackpackUsecase =
        GetBackpackFromNumbersUsecase(getItemsType: getItemsType);
    usecase = TradeWithUserUseCase(
        getBackpackUsecase: getBackpackUsecase,
        repository: userRepository,
        compareUsecase: compareUsecase);
  });

  group(
    'Trade with user usecase:',
    () {
      final tPick = [0, 0, 2, 0];
      final tPay = [0, 1, 0, 1];
      final tPayNotcompatible = [2, 1, 5, 1];
      final tListEmpty = [0, 0, 0, 0];
      final tOtherUserName = "test";

      final tParams =
          TradeParams(pick: tPick, pay: tPay, otherUserName: tOtherUserName);
      final tParamsNotCompatible = TradeParams(
          pick: tPick, pay: tPayNotcompatible, otherUserName: tOtherUserName);
      final tParamsEmpty =
          TradeParams(pick: tListEmpty, pay: tListEmpty, otherUserName: tOtherUserName);

      final listItems = <ItemEntity>[
        ItemEntity(name: 'Fiji Water', value: 14),
        ItemEntity(name: 'Campbell Soup', value: 12),
        ItemEntity(name: 'First Aid Pouch', value: 10),
        ItemEntity(name: 'AK47', value: 8),
      ];
      test(
        'return a [Confirmation] if the request was successful',
        () async {
          // arrange
          when(userRepository.tradeWithUser(any, any, any))
              .thenAnswer((_) async => Right(Confirmation()));
          when(itemsRepository.getItemsType())
              .thenAnswer((_) async => Right(listItems));

          // act
          final result = await usecase(tParams);

          // assert
          expect(result, Right(Confirmation()));
        },
      );

      test(
        'return a [DeviceFailure] if it cannot get the items type in get backpack by numbers usecase',
        () async {
          // arrange
          when(userRepository.tradeWithUser(any, any, any))
              .thenAnswer((_) async => Right(Confirmation()));
          when(itemsRepository.getItemsType())
              .thenAnswer((_) async => Left(DeviceFailure()));

          // act
          final result = await usecase(tParams);

          // assert
          expect(result, Left(DeviceFailure()));
        },
      );

      test(
        'return a [ServerFailure] if the request to trade wasnt successful',
        () async {
          // arrange
          when(userRepository.tradeWithUser(any, any, any))
              .thenAnswer((_) async => Left(ServerFailure()));
          when(itemsRepository.getItemsType())
              .thenAnswer((_) async => Right(listItems));

          // act
          final result = await usecase(tParams);

          // assert
          expect(result, Left(ServerFailure()));
        },
      );

      test(
        'return a [BackPackFailure] if the value of the trade is not compatible',
        () async {
          // arrange
          when(userRepository.tradeWithUser(any, any, any))
              .thenAnswer((_) async => Right(Confirmation()));
          when(itemsRepository.getItemsType())
              .thenAnswer((_) async => Right(listItems));

          // act
          final result = await usecase(tParamsNotCompatible);

          // assert
          expect(result, Left(BackPackComparationFailure(-78)));
        },
      );

      test(
        'return a [BackPackFailure] if both backpack are compatibles but are empty',
        () async {
          // arrange
          when(userRepository.tradeWithUser(any, any, any))
              .thenAnswer((_) async => Right(Confirmation()));
          when(itemsRepository.getItemsType())
              .thenAnswer((_) async => Right(listItems));

          // act
          final result = await usecase(tParamsEmpty);

          // assert
          expect(result, Left(BackPackComparationFailure(0)));
        },
      );
    },
  );
}
