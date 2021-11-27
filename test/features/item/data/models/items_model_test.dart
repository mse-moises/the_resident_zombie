import 'package:flutter_test/flutter_test.dart';
import 'package:the_resident_zombie/features/items/data/models/item_model.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';

void main() {
  late ItemModel itemModel;

  setUp(() {
    itemModel = ItemModel(name: "test", value: 0);
  });

  test(
    'is a subclass of [ItemEntity]',
    () async {
      expect(itemModel, isA<ItemEntity>());
    },
  );
}
