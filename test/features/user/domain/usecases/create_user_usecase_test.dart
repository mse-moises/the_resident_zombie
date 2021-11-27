import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';
import 'package:the_resident_zombie/features/location/domain/repositories/location_repository.dart';
import 'package:the_resident_zombie/features/location/domain/usecases/get_location_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/create_user_usecase.dart';

import 'create_user_usecase_test.mocks.dart';

@GenerateMocks([UserRepository])
@GenerateMocks([LocationRepository])
void main() {
  late CreateUserUsecase createUserUsecase;
  late GetLocationUseCase getLocationUsecase;

  late MockUserRepository mockUserRepository;
  late MockLocationRepository mockLocationRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockLocationRepository = MockLocationRepository();

    getLocationUsecase = GetLocationUseCase(mockLocationRepository);

    createUserUsecase = CreateUserUsecase(
        repository: mockUserRepository, getLocationUsecase: getLocationUsecase);
  });

  final tName = "test";
  final int tAge = 30;
  final tGender = "M";
  final tPositionString = "POINT (-46.67105 -23.618437)";

  final UserEntity tUser = UserEntity(name: tName, age: tAge, gender: tGender);
  final LocationEntity tLocation = LocationEntity(latitude: 0, longitude: 0);

  void mockSuccessLocation(){
    when(mockLocationRepository.getCurrentLocation())
          .thenAnswer((_) async => Right(tLocation));
          
  }
  void mockFailLocation(){
    when(mockLocationRepository.getCurrentLocation())
          .thenAnswer((_) async => Left(DeviceFailure()));
  }
  test(
    'get User Entity for the UserRepository when request to create a user',
    () async {
      // arrange
      when(mockUserRepository.createUser(any, any, any, any))
          .thenAnswer((_) async => Right(tUser));

      mockSuccessLocation();

      // act
      final result = await createUserUsecase(
          Params(name: tName, age: tAge, gender: tGender));

      // assert
      expect(result, Right(tUser));
    },
  );

  test(
    'get a [DeviceFailure] for the UserRepository when the request to get the location fails',
    () async {
      // arrange
      when(mockUserRepository.createUser(any, any, any, any))
          .thenAnswer((_) async => Right(tUser));

      mockFailLocation();

      // act
      final result = await createUserUsecase(
          Params(name: tName, age: tAge, gender: tGender));

      // assert
      expect(result, equals(Left(DeviceFailure())));
    },
  );

  test(
    'get a [Failure] for the UserRepository when the request to create a user fails',
    () async {
      // arrange
      when(mockUserRepository.createUser(any, any, any, any))
          .thenAnswer((_) async => Left(ServerFailure()));

      mockSuccessLocation();

      // act
      final result = await createUserUsecase(
          Params(name: tName, age: tAge, gender: tGender));

      // assert
      expect(result, equals(Left(ServerFailure())));
    },
  );
}
