import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';

class BackPackEntity extends Equatable {
  List<ItemEntity> items = [];

  BackPackEntity({startWithItems}){
    if(startWithItems != null) items.addAll(startWithItems);
  }

  void add(ItemEntity itemEntity) {
    items.add(itemEntity);
  }

  
  String inventoryToString() {
    List<ItemEntity> allEntities = []..addAll(items);

    List<List<ItemEntity>> allSameEntities = [];

    if(allEntities.isEmpty) return '';

    while(!allEntities.isEmpty){
      final itemEntity = allEntities[0];
      // get the name of the item
      String firstItemName = itemEntity.name;
      // array that gonna contain all the item with the same name
      final sameItems = <ItemEntity>[];

            // travel throught the list searching for items with the same name
      for (int i = allEntities.length - 1;
          i >= 0 && allEntities.isNotEmpty;
          i--) {
        final itemEntityAux = allEntities[i];

        //test if is the same name
        if (itemEntityAux.name == firstItemName) {
          sameItems.add(itemEntityAux);
          //remove from the allEntities list so it cannot be counted again
          allEntities.remove(itemEntityAux);
        }
      }

      allSameEntities.add(sameItems);
    }

    // should have a array of subarrays with the same itens

    // sort list  by list with more items to list with less items
    allSameEntities.sort((a, b) => b.length.compareTo(a.length));

    String stringToReturn = "";

    for (int i = 0; i < allSameEntities.length; i++) {
      List<ItemEntity> list = allSameEntities[i];
      final string = "${list[0].name}:${list.length}";

      if (i != 0) {
        stringToReturn += ";$string";
      } else {
        stringToReturn += string;
      }
    }

    return stringToReturn;
  }

  int getBackPackValue(){
    int value = 0;
    for(ItemEntity item in items){
      value += item.value;
    }
    return value;
  }

  @override
  List<Object> get props => [items];
}
