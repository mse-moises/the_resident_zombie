import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/core/platform/file_getter.dart';
import 'package:the_resident_zombie/features/items/data/datasource/items_local_datasource.dart';
import 'package:the_resident_zombie/features/items/data/repository/items_repository.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:the_resident_zombie/features/items/domain/repository/items_repository.dart';

import 'items_repository_test.mocks.dart';

@GenerateMocks([ItemsLocalDataSource])
void main() {
  late MockItemsLocalDataSource mockItemsLocalDataSource;
  late ItemsRepositoryImpl repository;

  setUp(() {
    mockItemsLocalDataSource = MockItemsLocalDataSource();
    repository = ItemsRepositoryImpl(localDataSource: mockItemsLocalDataSource);
  });

  final tFijiWater = ItemEntity(name: 'Fiji Water', value: 14);
  final tCampbellSoup = ItemEntity(name: 'Campbell Soup', value: 12);
  final tFirstAidPouch = ItemEntity(name: 'First Aid Pouch', value: 10);
  final tAk47 = ItemEntity(name: 'AK47', value: 8);

  final List<ItemEntity> listItems = <ItemEntity>[
    tFijiWater,
    tCampbellSoup,
    tFirstAidPouch,
    tAk47,
  ];

  group(
    'Items repository:',
    () {
      test(
        'get a list of items from items repository',
        () async {
          // arrange
          when(mockItemsLocalDataSource.getItemsType())
              .thenAnswer((_) async => listItems);
          // act
          final result = await repository.getItemsType();
          // assert
          expect(result, equals(Right(listItems)));
        },
      );

      test(
        'return [DeviceFailure] from items repository',
        () async {
          // arrange
          when(mockItemsLocalDataSource.getItemsType())
              .thenThrow(DeviceException());
          // act

          final result = await repository.getItemsType();

          // assert
          expect(result, Left(DeviceFailure()));
        },
      );
    },
  );
}
