import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/params/confirmation.dart';

import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/items/domain/entities/back_pack_entity.dart';

///TODO: COMENTAR
class CompareBackpackUsecase
    implements UseCase<Confirmation, CompareBackPackParams> {
  @override
  Future<Either<Failure, Confirmation>> call(params) {
    int difference = params.fistBackpackEntity.getBackPackValue() -
        params.secondBackpackEntity.getBackPackValue();

    //To check if both backpack are not empty
    int valueConfirmation = params.fistBackpackEntity.getBackPackValue();

    if (difference == 0 && valueConfirmation!=0) {
      return Future.value(Right(Confirmation()));
    } else {
      return Future.value(Left(BackPackComparationFailure(difference)));
    }
  }
}

class CompareBackPackParams extends Equatable {
  final BackPackEntity fistBackpackEntity;
  final BackPackEntity secondBackpackEntity;

  CompareBackPackParams(this.fistBackpackEntity, this.secondBackpackEntity);
  @override
  List<Object> get props => [];
}
