import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/location/domain/usecases/get_location_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';

class CreateUserUsecase implements UseCase<UserEntity, Params> {
  final UserRepository repository;
  final GetLocationUseCase getLocationUsecase;

  CreateUserUsecase(
      {required this.repository, required this.getLocationUsecase});

  Future<Either<Failure, UserEntity>> call(Params params) async {
    
    final locationEntity = await getLocationUsecase(NoParams());

    if(locationEntity.isLeft()) return Left(DeviceFailure());
    
    return await repository.createUser(params.name, params.age, params.gender, locationEntity.toString());
  }
}

class Params extends Equatable {
  final String name;
  final int age;
  final String gender;

  Params({required this.name, required this.age, required this.gender});

  @override
  List<Object> get props => [name, age, gender];
}
