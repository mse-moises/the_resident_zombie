import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/items/domain/entities/back_pack_entity.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:the_resident_zombie/features/items/domain/repository/items_repository.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_backpack_from_numbers_usecase.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_items_type_usecase.dart';

import 'get_items_type_usecase_test.mocks.dart';

@GenerateMocks([ItemsRepository])
void main() {
  late MockItemsRepository mockItemsRepository;
  late GetItemsTypeUseCase getItemsTypeUseCase;
  late GetBackpackFromNumbersUsecase getBackpackUsecase;

  setUp(() {
    mockItemsRepository = MockItemsRepository();
    getItemsTypeUseCase = GetItemsTypeUseCase(mockItemsRepository);
    getBackpackUsecase =
        GetBackpackFromNumbersUsecase(getItemsType: getItemsTypeUseCase);
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

  final tQuantities = [4,3,2,1];

  final listItemsInBackpack = <ItemEntity>[
    tFijiWater.clone(),
    tFijiWater.clone(),
    tFijiWater.clone(),
    tFijiWater.clone(),
    tCampbellSoup.clone(),
    tCampbellSoup.clone(),
    tCampbellSoup.clone(),
    tFirstAidPouch.clone(),
    tFirstAidPouch.clone(),
    tAk47.clone(),
  ];

  final tBackpack = BackPackEntity(startWithItems: listItemsInBackpack);

  final tParams = BackPackParams(tQuantities);

  group(
    'Get backpack usecase:',
    () {
      test(
        'return a backpack entity',
        () async {
          // arrange
          when(mockItemsRepository.getItemsType()).thenAnswer((_) async =>Right(listItems));
          // act
          final result = await getBackpackUsecase(tParams);
          // assert
          expect(result, Right(tBackpack));
        },
      );

      test(
        'return a [DeviceFailure]',
        () async {
          // arrange
          when(mockItemsRepository.getItemsType()).thenAnswer((_) async =>Left(DeviceFailure()));
          // act
          final result = await getBackpackUsecase(tParams);
          // assert
          expect(result, Left(DeviceFailure()));
        },
      );
    },
  );
}
