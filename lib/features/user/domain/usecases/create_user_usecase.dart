import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_backpack_from_numbers_usecase.dart';
import 'package:the_resident_zombie/features/location/domain/usecases/get_location_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';

class CreateUserUsecase implements UseCase<UserEntity, Params> {
  final UserRepository repository;
  final GetLocationUseCase getLocationUsecase;
  final GetBackpackFromNumbersUsecase getBackpackUsecase;

  CreateUserUsecase(
      {required this.repository, required this.getLocationUsecase, required this.getBackpackUsecase});

  Future<Either<Failure, UserEntity>> call(Params params) async {
    
    final locationEntityResponse = await getLocationUsecase(NoParams());

    if(locationEntityResponse.isLeft()) return Left(DeviceFailure());

    final locationEntity = locationEntityResponse.toOption().toNullable()!;
    
    final backpackResponse = await getBackpackUsecase(ParamsBackpack(params.itemQuantity));

    if(backpackResponse.isLeft()) return Left(DeviceFailure());

    final backpack = backpackResponse.toOption().toNullable()!;
    
    return await repository.createUser(params.name, params.age, params.gender, locationEntity.toStringAsCoordinated(), backpack.inventoryToString());
  }
}

class Params extends Equatable {
  final String name;
  final int age;
  final String gender;
  final List<int> itemQuantity;

  Params({required this.name, required this.age, required this.gender, required this.itemQuantity});

  @override
  List<Object> get props => [name, age, gender];
}
