import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';

class ItemModel extends ItemEntity {
  ItemModel({
    required name,
    required value,
  }) : super(
          name: name,
          value: value,
        );

  factory ItemModel.fromJson(Map<String, dynamic> map) {
    return ItemModel(
      name: map['name'],
      value: map['points'],
    );
  }
}
