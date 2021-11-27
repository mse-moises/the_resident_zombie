import 'dart:convert';

import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/core/platform/file_getter.dart';
import 'package:the_resident_zombie/features/items/data/datasource/items_local_datasource.dart';
import 'package:the_resident_zombie/features/items/data/models/item_model.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/features/items/domain/repository/items_repository.dart';

class ItemsRepositoryImpl implements ItemsRepository{

  final ItemsLocalDataSource localDataSource;

  ItemsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<ItemEntity>>> getItemsType() async {
    try{
      return Right(await localDataSource.getItemsType());

    }on DeviceException{
      return Left(DeviceFailure());
    }

  }

}