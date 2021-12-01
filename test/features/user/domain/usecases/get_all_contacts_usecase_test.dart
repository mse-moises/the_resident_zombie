import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/get_all_contacts_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/get_user_by_id_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';

import 'create_user_usecase_test.mocks.dart';

void main() {
  late MockUserRepository repository;
  late GetUserByIdUseCase getUserUsecase;
  late GetAllContactsUsecase getAllContactsUsecase;

  setUp(() {
    repository = MockUserRepository();
    getUserUsecase = GetUserByIdUseCase(repository: repository);
    getAllContactsUsecase = GetAllContactsUsecase(
        getUserByIdUseCase: getUserUsecase, repository: repository);
  });

  group(
    'GetAllContactsUsecase:',
    () {
      final tName = "test";
      final tAge = 30;
      final tGender = "t";
      final tIds = ["test", "test", "test"];
      final tUser = UserEntity(id:'test',name: tName, age: tAge, gender: tGender);
      final tUsers = [
        UserEntity(id: 'test', name: tName, age: tAge, gender: tGender),
        UserEntity(id: 'test', name: tName, age: tAge, gender: tGender),
        UserEntity(id: 'test', name: tName, age: tAge, gender: tGender),
      ];

      test(
        'return a List of UserEntitty if it was successful',
        () async {
          // arrange
          when(repository.getAllContactsIds())
              .thenAnswer((_) async => Right(tIds));
          when(repository.getUserEntityById(any))
              .thenAnswer((_) async => Right(tUser));

          // act
          final result = await getAllContactsUsecase(GetAllContactsParams());

          var finalResultToCompare;

          if (result.isRight()) {
            finalResultToCompare =
                result.toOption().toNullable() as List<UserEntity>;
          }

          // assert
          expect(finalResultToCompare, equals(tUsers));
        },
      );

      test(
        'return a [CacheFAilure] if it the requst for all the contacts ids wasnt sucessful',
        () async {
          // arrange
          when(repository.getAllContactsIds())
              .thenAnswer((_) async => Left(CacheFailure()));
          when(repository.getUserEntityById(any))
              .thenAnswer((_) async => Right(tUser));

          // act
          final result = await getAllContactsUsecase(GetAllContactsParams());

          // assert
          expect(result, Left(CacheFailure()));
        },
      );

      test(
        'return a List of UserEntitty even if the request for the users models wasnt successful',
        () async {
          // arrange
          when(repository.getAllContactsIds())
              .thenAnswer((_) async => Right(tIds));
          when(repository.getUserEntityById(any))
              .thenAnswer((_) async => Left(ServerFailure()));

          // act
          final result = await getAllContactsUsecase(GetAllContactsParams());

          var finalResultToCompare;

          if (result.isRight()) {
            finalResultToCompare =
                result.toOption().toNullable() as List<UserEntity>;
          }

          // assert
          expect(finalResultToCompare, isA<List<UserEntity>>());
        },
      );
    },
  );
}
