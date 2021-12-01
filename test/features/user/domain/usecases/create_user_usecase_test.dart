import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:the_resident_zombie/features/items/domain/repository/items_repository.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_backpack_from_numbers_usecase.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_items_type_usecase.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';
import 'package:the_resident_zombie/features/location/domain/repositories/location_repository.dart';
import 'package:the_resident_zombie/features/location/domain/usecases/get_location_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/create_user_usecase.dart';

import 'create_user_usecase_test.mocks.dart';

@GenerateMocks([UserRepository])
@GenerateMocks([LocationRepository])
@GenerateMocks([ItemsRepository])
void main() {
  late CreateUserUsecase createUserUsecase;
  late GetLocationUseCase getLocationUsecase;
  late GetBackpackFromNumbersUsecase getBackpackFromNumbersUsecase;
  late GetItemsTypeUseCase getItemsTypeUseCase;

  late MockUserRepository mockUserRepository;
  late MockLocationRepository mockLocationRepository;
  late MockItemsRepository mockItemsRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockLocationRepository = MockLocationRepository();
    mockItemsRepository = MockItemsRepository();

    getLocationUsecase = GetLocationUseCase(repository: mockLocationRepository);
    getItemsTypeUseCase = GetItemsTypeUseCase(repository: mockItemsRepository);
    getBackpackFromNumbersUsecase =
        GetBackpackFromNumbersUsecase(getItemsType: getItemsTypeUseCase);

    createUserUsecase = CreateUserUsecase(
        repository: mockUserRepository,
        getLocationUsecase: getLocationUsecase,
        getBackpackUsecase: getBackpackFromNumbersUsecase);
  });

  final tName = "test";
  final int tAge = 30;
  final tGender = "M";
  final tPositionString = "POINT (-46.67105 -23.618437)";
  final tItemsList = <int>[4, 3, 2, 1];
  final UserEntity tUser =
      UserEntity(name: tName, age: tAge, gender: tGender, id: 'test');

  void mockSuccessCreateUser() {
    when(mockUserRepository.createUser(any, any, any, any, any))
        .thenAnswer((_) async => Right(tUser));
  }

  void mockFailCreateUser() {
    when(mockUserRepository.createUser(any, any, any, any, any))
        .thenAnswer((_) async => Left(ServerFailure()));
  }

  // mockItemsRepository data
  final listItems = <ItemEntity>[
    ItemEntity(name: 'Fiji Water', value: 14),
    ItemEntity(name: 'Campbell Soup', value: 12),
    ItemEntity(name: 'First Aid Pouch', value: 10),
    ItemEntity(name: 'AK47', value: 8),
  ];

  void mockSuccessBackpack() {
    when(mockItemsRepository.getItemsType())
        .thenAnswer((_) async => Right(listItems));
  }

  void mockFailBackpack() {
    when(mockItemsRepository.getItemsType())
        .thenAnswer((_) async => Left(DeviceFailure()));
  }

  // mockLocationRepository
  final LocationEntity tLocation = LocationEntity(latitude: 0, longitude: 0);

  void mockSuccessLocation() {
    when(mockLocationRepository.getCurrentLocation())
        .thenAnswer((_) async => Right(tLocation));
  }

  void mockFailLocation() {
    when(mockLocationRepository.getCurrentLocation())
        .thenAnswer((_) async => Left(DeviceFailure()));
  }

  group(
    'Create user usecase:',
    () {
      test(
        'get User Entity for the UserRepository when request to create a user',
        () async {
          // arrange

          mockSuccessCreateUser();
          mockSuccessLocation();
          mockSuccessBackpack();

          // act
          final result = await createUserUsecase(CreateUserParams(
              name: tName,
              age: tAge,
              gender: tGender,
              itemQuantity: tItemsList));

          // assert
          expect(result, Right(tUser));
        },
      );

      test(
        'get a [DeviceFailure] when the request to get the location fails',
        () async {
          // arrange

          mockSuccessCreateUser();
          mockFailLocation();

          // act
          final result = await createUserUsecase(CreateUserParams(
              name: tName,
              age: tAge,
              gender: tGender,
              itemQuantity: tItemsList));

          // assert
          expect(result, equals(Left(DeviceFailure())));
        },
      );

      test(
        'get a [DeviceFailure] when the request to get the get the backpack fails',
        () async {
          // arrange
          mockSuccessCreateUser();
          mockSuccessLocation();
          mockFailBackpack();

          // act
          final result = await createUserUsecase(CreateUserParams(
              name: tName,
              age: tAge,
              gender: tGender,
              itemQuantity: tItemsList));

          // assert
          expect(result, equals(Left(DeviceFailure())));
        },
      );

      test(
        'get a [Failure] for the UserRepository when the request to create a user fails',
        () async {
          // arrange
          mockFailCreateUser();
          mockSuccessLocation();
          mockSuccessBackpack();

          // act
          final result = await createUserUsecase(CreateUserParams(
              name: tName,
              age: tAge,
              gender: tGender,
              itemQuantity: tItemsList));

          // assert
          expect(result, equals(Left(ServerFailure())));
        },
      );
    },
  );
}
