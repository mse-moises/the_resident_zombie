import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';
import 'package:the_resident_zombie/features/location/domain/repositories/location_repository.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';

class GetLocationFromIdUseCase
    implements UseCase<LocationEntity, GetLocationFromIdParams> {
      final LocationRepository repository;

  GetLocationFromIdUseCase({required this.repository});
  @override
  Future<Either<Failure, LocationEntity>> call(params) async{
    return await repository.getLocationFromId(params.identifier);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class GetLocationFromIdParams extends Equatable {
  final String identifier;

  GetLocationFromIdParams(this.identifier);
  @override
  List<Object> get props => [identifier];
}
