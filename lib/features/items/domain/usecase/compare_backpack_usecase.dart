import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/items/domain/entities/back_pack_entity.dart';

///TODO: COMENTAR
class CompareBackpackUsecase implements UseCase<int, CompareBackPackParams> {
  @override
  Future<Either<Failure, int>> call(params) {
    return Future.value(Right(params.fistBackpackEntity.getBackPackValue() -
        params.secondBackpackEntity.getBackPackValue()));
  }
}

class CompareBackPackParams extends Equatable {
  final BackPackEntity fistBackpackEntity;
  final BackPackEntity secondBackpackEntity;

  CompareBackPackParams(this.fistBackpackEntity, this.secondBackpackEntity);
  @override
  List<Object> get props => [];
}
