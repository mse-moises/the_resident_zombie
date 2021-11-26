import 'package:geolocator/geolocator.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/features/location/data/datasources/location_data_source.dart';
import 'package:the_resident_zombie/features/location/data/models/location_model.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/features/location/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource datasource;

  LocationRepositoryImpl({required this.datasource});
  @override
  Future<Either<Failure, LocationEntity>> getCurrentLocation() async {
    return await getPositionFromGeolocator();
  }

  Future<Either<Failure, LocationEntity>> getPositionFromGeolocator() async {
    try {
      return Right(await datasource.getCurrentLocation());
    } on DeviceException {
      return Left(DeviceFailure());
    }
  }
}
