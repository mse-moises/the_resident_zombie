import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:the_resident_zombie/features/items/domain/repository/items_repository.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_items_type_usecase.dart';

import 'get_items_type_usecase_test.mocks.dart';

@GenerateMocks([ItemsRepository])
void main() {
  late MockItemsRepository repository;
  late GetItemsTypeUseCase usecase;

  setUp(() {
    repository = MockItemsRepository();
    usecase = GetItemsTypeUseCase(repository);
  });

  final tFijiWater = ItemEntity(name: 'Fiji Water', value: 14);
  final tCampbellSoup = ItemEntity(name: 'Campbell Soup', value: 12);
  final tFirstAidPouch = ItemEntity(name: 'First Aid Pouch', value: 10);
  final tAk47 = ItemEntity(name: 'AK47', value: 8);

  final listItems = <ItemEntity>[
    tFijiWater,
    tCampbellSoup,
    tFirstAidPouch,
    tAk47,
  ];

  test(
    'return a list of items',
    () async {
      // arrange
      when(repository.getItemsType()).thenAnswer((_) async => Right(listItems));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, equals(Right(listItems)));
    },
  );

  test(
    'return a [DeviceFailure] of items',
    () async {
      // arrange
      when(repository.getItemsType()).thenAnswer((_) async => Left(DeviceFailure()));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, equals(Left(DeviceFailure())));
    },
  );
}
