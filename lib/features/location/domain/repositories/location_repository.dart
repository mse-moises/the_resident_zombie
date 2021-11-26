import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';

abstract class LocationRepository {
  Future<Either<Failure,LocationEntity>> getCurrentLocation();
}