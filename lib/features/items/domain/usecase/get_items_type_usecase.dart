import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/items/domain/entities/back_pack_entity.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:the_resident_zombie/features/items/domain/repository/items_repository.dart';

class GetItemsTypeUseCase implements UseCase<List<ItemEntity>, NoParamsGetItemType>{
  final ItemsRepository repository;

  GetItemsTypeUseCase(this.repository);
  @override
  Future<Either<Failure, List<ItemEntity>>> call(params) async {
    return await repository.getItemsType();
  }

}

class NoParamsGetItemType extends Equatable {
  @override
  List<Object> get props => [];
}
