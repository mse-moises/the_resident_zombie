import 'package:flutter_test/flutter_test.dart';
import 'package:the_resident_zombie/features/items/domain/entities/back_pack_entity.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';

void main() {
  late BackPackEntity emptyBackPack;
  late BackPackEntity backPackWithItem;
  late ItemEntity item;

  setUp(() {
    emptyBackPack = BackPackEntity();
    backPackWithItem = BackPackEntity();

    ItemEntity item = ItemEntity(name: 'Fiji Water', value: 14);
    backPackWithItem.add(item);
  });

  final tItem0 = ItemEntity(name: 'Fiji Water', value: 14);
  final tItem1 = ItemEntity(name: 'Fiji Water', value: 14);
  final tItem2 = ItemEntity(name: 'Campbell Soup', value: 14);
  final String tString = "Fiji Water:2;Campbell Soup:1";

  test(
    'add [ItemEntity] to backpack',
    () async {
      // act
      emptyBackPack.add(tItem0);
      // assert
      expect(emptyBackPack, equals(backPackWithItem));
      expect(emptyBackPack.items.length, 1);
    },
  );

  test(
    'get right String format from toString method on backpack ',
    () async {
      // act
      emptyBackPack.add(tItem0);
      emptyBackPack.add(tItem1);
      emptyBackPack.add(tItem2);
      // assert
      expect(emptyBackPack.toString(), equals(tString));
    },
  );
}
