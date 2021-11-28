import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_items_type_usecase.dart';
import 'package:the_resident_zombie/features/location/domain/usecases/get_location_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';

class UpdateUserLocationUsecase extends UseCase<UserEntity, ParamsUpdateLocation> {
  final UserRepository repository;
  final GetLocationUseCase getLocationUsecase;

  UpdateUserLocationUsecase({required this.getLocationUsecase, required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(params) async {

    final locationEntityResponse = await getLocationUsecase(NoParamsGetLocation());
    if (locationEntityResponse.isLeft()) return Left(DeviceFailure());
    final locationEntity = locationEntityResponse.toOption().toNullable()!;

    return await repository.updateUserLocation(params.identifier, locationEntity.toStringAsCoordinated());
  }
}

class ParamsUpdateLocation extends Equatable {
  final String identifier;

  ParamsUpdateLocation({required this.identifier});
  @override
  List<Object> get props => [identifier];
}
