import 'package:flutter_test/flutter_test.dart';
import 'package:the_resident_zombie/features/items/data/models/item_model.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';

void main() {
  late ItemModel itemModel;

  setUp(() {
    itemModel = ItemModel(name: "test", value: 0);
  });

  group(
    'Item model:',
    () {
      test(
        'is a subclass of [ItemEntity]',
        () async {
          expect(itemModel, isA<ItemEntity>());
        },
      );

      final tJson = {"name": "Fiji Water", "points": 14};

      test(
        'should create a [ItemModel] from json',
        () async {
          // act
          final tItemModel = ItemModel.fromJson(tJson);
          // assert
          expect(itemModel, isA<ItemModel>());
        },
      );
    },
  );
}
