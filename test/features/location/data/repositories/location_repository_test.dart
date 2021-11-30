import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/location/data/datasources/local_location_data_source.dart';
import 'package:the_resident_zombie/features/location/data/datasources/remote_location_data_source.dart';
import 'package:the_resident_zombie/features/location/data/models/location_model.dart';
import 'package:the_resident_zombie/features/location/data/repositories/location_repository.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';
import 'location_repository_test.mocks.dart';

@GenerateMocks([LocalLocationDataSource])
@GenerateMocks([RemoteLocationDataSource])
void main() {
  late MockLocalLocationDataSource mockLocationDataSource;
  late MockRemoteLocationDataSource mockRemoteDataSource;
  late LocationRepositoryImpl repository;

  setUp(() {
    mockLocationDataSource = MockLocalLocationDataSource();
    mockRemoteDataSource = MockRemoteLocationDataSource();
    repository = LocationRepositoryImpl(
        localDatasource: mockLocationDataSource,
        remoteDatasource: mockRemoteDataSource);
  });

  final tLocationModel = LocationModel(latitude: 0.0, longitude: 0.0);

  final LocationEntity tLocationEntity = tLocationModel;

  group(
    'Location repository:',
    () {
      group(
        'Get current location -',
        () {
          test(
            'return a [LocalizationEntity] from requisition to datasource then the request is valid',
            () async {
              // arrange
              when(mockLocationDataSource.getCurrentLocation())
                  .thenAnswer((_) async => tLocationModel);
              // act
              final result = await repository.getCurrentLocation();
              // assert
              expect(result, equals(Right(tLocationEntity)));
            },
          );

          test(
            'return a [DeviceFailure] from requisition to datasource when the request is unsucessful',
            () async {
              // arrange
              when(mockLocationDataSource.getCurrentLocation())
                  .thenThrow(DeviceException());
              // act
              final result = await repository.getCurrentLocation();
              // assert
              expect(result, equals(Left(DeviceFailure())));
            },
          );
        },
      );

      group(
        'Get location by id -',
        () {
          final tLocationModel = LocationModel(latitude: 0, longitude: 0);
          final tId = 'test';
          test(
            'return a [LocationModel]',
            () async {
              // arrange
              when(mockRemoteDataSource.getLocationFromId(any))
                  .thenAnswer((_) async => tLocationModel);
              // act

              final result = await repository.getLocationFromId(tId);

              // assert
              expect(result, Right(tLocationModel));
            },
          );

          test(
            'return a [ServerFailure]',
            () async {
              // arrange
              when(mockRemoteDataSource.getLocationFromId(any))
                  .thenThrow(ServerException());
              // act

              final result = await repository.getLocationFromId(tId);

              // assert
              expect(result, Left(ServerFailure()));
            },
          );
        },
      );
    },
  );
}
