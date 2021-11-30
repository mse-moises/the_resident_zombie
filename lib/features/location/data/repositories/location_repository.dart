import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/features/location/data/datasources/local_location_data_source.dart';
import 'package:the_resident_zombie/features/location/data/datasources/remote_location_data_source.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/features/location/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocalLocationDataSource localDatasource;
  final RemoteLocationDataSource remoteDatasource;

  LocationRepositoryImpl(
      {required this.localDatasource, required this.remoteDatasource});
  @override
  Future<Either<Failure, LocationEntity>> getCurrentLocation() async {
    return await getPositionFromGeolocator();
  }

  Future<Either<Failure, LocationEntity>> getPositionFromGeolocator() async {
    try {
      return Right(await localDatasource.getCurrentLocation());
    } on DeviceException {
      return Left(DeviceFailure());
    }
  }

  @override
  Future<Either<Failure, LocationEntity>> getLocationFromId(
      String identifier) async {
    try {
      return Right(await remoteDatasource.getLocationFromId(identifier));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
