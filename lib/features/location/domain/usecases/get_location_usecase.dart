import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';
import 'package:the_resident_zombie/features/location/domain/repositories/location_repository.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/create_user_usecase.dart';

class GetLocationUseCase implements UseCase<LocationEntity,NoParamsGetLocation> {
  final LocationRepository repository;

  GetLocationUseCase(this.repository);
  @override
  Future<Either<Failure, LocationEntity>> call(NoParamsGetLocation noParams) async {
    return await repository.getCurrentLocation();
  }
}

class NoParamsGetLocation extends Equatable {
  @override
  List<Object> get props => [];
}
