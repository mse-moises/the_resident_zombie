import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/items/domain/entities/back_pack_entity.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:the_resident_zombie/features/items/domain/repository/items_repository.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_items_type_usecase.dart';

class GetBackpackFromNumbersUsecase implements UseCase<BackPackEntity, ParamsBackpack> {
  final GetItemsTypeUseCase getItemsType;

  GetBackpackFromNumbersUsecase({required this.getItemsType});

  @override
  Future<Either<Failure, BackPackEntity>> call(params) async {
    final backPack = BackPackEntity();
    final itemsTypeResponse = await getItemsType(NoParams());

    if(itemsTypeResponse.isLeft()) return Left(DeviceFailure());
    
    final itemsTypeResult = itemsTypeResponse.toOption().toNullable()!;
    for(int i = 0; i< itemsTypeResult.length; i++){
      for(int j = 0; j < params.quantities[i]; j++){
        backPack.add(itemsTypeResult[i].clone());
      }
    }

    return Right(backPack);
  }
}

class ParamsBackpack extends Equatable {
  final List<int> quantities;

  ParamsBackpack(this.quantities);
  @override
  List<Object> get props => [];
}
