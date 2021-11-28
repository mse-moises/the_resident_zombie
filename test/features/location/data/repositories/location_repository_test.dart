import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/location/data/datasources/location_data_source.dart';
import 'package:the_resident_zombie/features/location/data/models/location_model.dart';
import 'package:the_resident_zombie/features/location/data/repositories/location_repository.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';
import 'package:the_resident_zombie/features/location/domain/repositories/location_repository.dart';

import 'location_repository_test.mocks.dart';

@GenerateMocks([LocationDataSource])
void main() {
  late MockLocationDataSource mockLocationDataSource;
  late LocationRepositoryImpl locationRepository;

  setUp(() {
    mockLocationDataSource = MockLocationDataSource();
    locationRepository =
        LocationRepositoryImpl(datasource: mockLocationDataSource);
  });

  final tLocationModel = LocationModel(latitude: 0.0, longitude: 0.0);

  final LocationEntity tLocationEntity = tLocationModel;

  group(
    'Location repository:',
    () {
      test(
        'return a [LocalizationEntity] from requisition to datasource then the request is valid',
        () async {
          // arrange
          when(mockLocationDataSource.getCurrentLocation())
              .thenAnswer((_) async => tLocationModel);
          // act
          final result = await locationRepository.getCurrentLocation();
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
          final result = await locationRepository.getCurrentLocation();
          // assert
          expect(result, equals(Left(DeviceFailure())));
        },
      );
    },
  );
}
