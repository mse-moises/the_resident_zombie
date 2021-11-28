import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';
import 'package:the_resident_zombie/features/location/domain/usecases/get_location_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/update_user_location_usecase.dart';

import 'create_user_usecase_test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late MockLocationRepository mockLocationRepository;

  late UpdateUserLocationUsecase updateUserLocationUsecase;
  late GetLocationUseCase getLocationUsecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockLocationRepository = MockLocationRepository();

    getLocationUsecase = GetLocationUseCase(mockLocationRepository);
    updateUserLocationUsecase = UpdateUserLocationUsecase(
        repository: mockUserRepository, getLocationUsecase: getLocationUsecase);
  });

  final tIdentifier = 'test';
  final tLocation = LocationEntity(latitude: 0, longitude: 0);

  void setSuccessUserRepository() {
    bool res = true;
    when(mockUserRepository.updateUserLocation(any, any))
        .thenAnswer((_) => Future.value(Right(res)));
  }

  void setFailUserRepository() {
    when(mockUserRepository.updateUserLocation(any, any))
        .thenAnswer((_) async => Left(ServerFailure()));
  }

  void setSuccessLocationRepository() {
    when(mockLocationRepository.getCurrentLocation())
        .thenAnswer((_) async => Right(tLocation));
  }

  void setFailLocationRepository() {
    when(mockLocationRepository.getCurrentLocation())
        .thenAnswer((_) async => Left(DeviceFailure()));
  }

  group(
    'Update user location:',
    () {
      test(
        'return a bool if the request is successful',
        () async {
          // arrange
          setSuccessLocationRepository();
          setSuccessUserRepository();

          // act
          final result = await updateUserLocationUsecase(
              ParamsUpdateLocation(identifier: tIdentifier));

          // assert
          expect(result, Right(true));
        },
      );

      test(
        'return a [DeviceFailure] if the request of location is not successful',
        () async {
          // arrange
          setFailLocationRepository();
          setSuccessUserRepository();

          // act
          final result = await updateUserLocationUsecase(
              ParamsUpdateLocation(identifier: tIdentifier));

          // assert
          expect(result, Left(DeviceFailure()));
        },
      );

      test(
        'return a [ServerFailure] if the request to update the location is not successful',
        () async {
          // arrange
          setSuccessLocationRepository();
          setFailUserRepository();

          // act
          final result = await updateUserLocationUsecase(
              ParamsUpdateLocation(identifier: tIdentifier));

          // assert
          expect(result, Left(ServerFailure()));
        },
      );
    },
  );
}
