import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/core/platform/file_getter.dart';
import 'package:the_resident_zombie/features/items/data/datasource/items_local_datasource.dart';
import 'package:the_resident_zombie/features/items/data/models/item_model.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';

import 'item_local_datasource_test.mocks.dart';

@GenerateMocks([FileGetter])
void main() {
  late MockFileGetter mockFilleGetter;
  late ItemLocalDataSourceImpl itemLocalDataSourceImpl;

  setUp(() {
    mockFilleGetter = MockFileGetter();
    itemLocalDataSourceImpl =
        ItemLocalDataSourceImpl(fileGetter: mockFilleGetter);
  });

  final tFile =
      '[{"name": "Fiji Water", "points": 14},{"name": "Campbell Soup", "points": 12},{"name": "First Aid Pouch", "points": 10},{"name": "AK47", "points": 8}]';

  final tFijiWater = ItemModel(name: 'Fiji Water', value: 14);
  final tCampbellSoup = ItemModel(name: 'Campbell Soup', value: 12);
  final tFirstAidPouch = ItemModel(name: 'First Aid Pouch', value: 10);
  final tAk47 = ItemModel(name: 'AK47', value: 8);

  final List<ItemModel> listItems = <ItemModel>[
    tFijiWater,
    tCampbellSoup,
    tFirstAidPouch,
    tAk47,
  ];

  group(
    'Items local datasource:',
    () {
      test(
        'retun a list of [ItemModel]',
        () async {
          // arrange
          when(mockFilleGetter.getFile(any)).thenAnswer((_) async => tFile);
          // act
          final result = await itemLocalDataSourceImpl.getItemsType();
          // assert
          expect(result, equals(listItems));
        },
      );

      test(
        'throw a [DeviceException]',
        () async {
          // arrange
          when(mockFilleGetter.getFile(any)).thenThrow(DeviceException());
          // act
          final call = itemLocalDataSourceImpl.getItemsType;
          // assert
          expect(() => call(), throwsA(TypeMatcher<DeviceException>()));
        },
      );
    },
  );
}
