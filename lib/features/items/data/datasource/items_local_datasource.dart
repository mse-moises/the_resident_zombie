import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/core/platform/file_getter.dart';
import 'package:the_resident_zombie/features/items/data/models/item_model.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';

abstract class ItemsLocalDataSource {
  Future<List<ItemEntity>> getItemsType();
}

const String itemsFileName = "items";
class ItemLocalDataSourceImpl implements ItemsLocalDataSource {
  final FileGetter fileGetter;

  ItemLocalDataSourceImpl({required this.fileGetter});
  @override
  Future<List<ItemModel>> getItemsType() async {
    final itemsJson = json.decode(await fileGetter.getFile("$itemsFileName.json"));
    List<ItemModel> items = [];
    for (var item in itemsJson) {
      final itemModel = ItemModel.fromJson(item);
      items.add(itemModel);
    }

    return items;
  }
}
