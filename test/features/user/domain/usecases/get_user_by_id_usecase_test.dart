import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/get_user_by_id_usecase.dart';

import 'create_user_usecase_test.mocks.dart';

void main() {
  late MockUserRepository repository;
  late GetUserByIdUseCase usecase;

  setUp(() {
    repository = MockUserRepository();
    usecase = GetUserByIdUseCase(repository: repository);
  });

  group(
    'Get user by id usecase:',
    () {
      final tUserEntity =
          UserEntity(id: 'test', age: 30, gender: 'test', name: 'test', infected:false);
      final tIdentifier = "test";
      test(
        'return a [UserEntity] from repository',
        () async {
          // arrange
          when(repository.getUserEntityById(any))
              .thenAnswer((_) async => Right(tUserEntity));
          // act
          final result =
              await usecase(GetUserByIdParams(identifier: tIdentifier));

          // assert
          expect(result, Right(tUserEntity));
        },
      );
      test(
        'return a [ServerFailure] from repository',
        () async {
          // arrange
          when(repository.getUserEntityById(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          // act
          final result =
              await usecase(GetUserByIdParams(identifier: tIdentifier));

          // assert
          expect(result, Left(ServerFailure()));
        },
      );
    },
  );
}
