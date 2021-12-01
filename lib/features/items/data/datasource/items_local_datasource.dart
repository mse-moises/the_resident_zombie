import 'dart:convert';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/core/platform/file_getter.dart';
import 'package:the_resident_zombie/features/items/data/models/item_model.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:flutter/services.dart' show rootBundle;

abstract class ItemsLocalDataSource {
  Future<List<ItemEntity>> getItemsType();
}

const String itemsFileName = "assets/json/items";

class ItemLocalDataSourceImpl implements ItemsLocalDataSource {
  final FileGetter fileGetter;

  ItemLocalDataSourceImpl({required this.fileGetter});
  @override
  Future<List<ItemModel>> getItemsType() async {
    late List itemsJson;
    try {
      itemsJson =  json.decode(await fileGetter.getFile(itemsFileName));
      //json.decode(await rootBundle.loadString(
          //"$itemsFileName.json"));
    } catch (e) {
      print(e);
      throw DeviceException();
    }
    List<ItemModel> items = [];
    for (var item in itemsJson) {
      final itemModel = ItemModel.fromJson(item);
      items.add(itemModel);
    }

    return items;
  }
}
