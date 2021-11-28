import 'package:flutter_test/flutter_test.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';

void main() {
  late ItemEntity item;
  setUp(() {
    item = ItemEntity(name: 'test', value: 0);
  });

  group(
    'item entity',
    () {
      test(
        'clone [ItemEntity]',
        () async {
          // act
          final itemClone = item.clone();
          // assert
          expect(item, equals(itemClone));
        },
      );
    },
  );
}
