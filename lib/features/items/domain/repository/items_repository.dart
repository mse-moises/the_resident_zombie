import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';


abstract class ItemsRepository {
  Future<Either<Failure,List<ItemEntity>>> getItemsType();
}