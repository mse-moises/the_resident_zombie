import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/core/params/confirmation.dart';
import 'package:the_resident_zombie/features/items/domain/entities/back_pack_entity.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/compare_backpack_usecase.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_backpack_from_numbers_usecase.dart';

void main() {
  late CompareBackpackUsecase usecase;
  late BackPackEntity higherValue;
  late BackPackEntity lowerValue;
  setUp(() {
    usecase = CompareBackpackUsecase();
    higherValue = BackPackEntity(startWithItems: [ItemEntity(name:"test",value:10),ItemEntity(name:"test",value:10)]);
    lowerValue = BackPackEntity(startWithItems: [ItemEntity(name:"test",value:5),ItemEntity(name:"test",value:5),ItemEntity(name:"test",value:5)]);
  });

  group(
    'Compare Backpack Usecase:',
    () {
      test(
        'should return a 5',
        () async {
          // act
          final result = await usecase(CompareBackPackParams(higherValue,lowerValue));
          // assert
          expect(result, Left(BackPackComparationFailure(5)));
        },
      );

      test(
        'should return a -5',
        () async {
          // act
          final result = await usecase(CompareBackPackParams(lowerValue,higherValue));
          // assert
          expect(result, Left(BackPackComparationFailure(-5)));
        },
      );

      test(
        'should return a Confirmation',
        () async {
          // act
          final result = await usecase(CompareBackPackParams(higherValue,higherValue));
          // assert
          expect(result, Right(Confirmation()));
        },
      );
    },
  );
}
