import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/get_local_user_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/get_user_by_id_usecase.dart';

import 'create_user_usecase_test.mocks.dart';

void main() {
  late MockUserRepository mockRepository;
  late GetLocalUserUseCase usecase;
  late GetUserByIdUseCase getUserByIdUseCase;
  setUp(() {
    mockRepository = MockUserRepository();
    getUserByIdUseCase = GetUserByIdUseCase(repository: mockRepository);
    usecase = GetLocalUserUseCase(
        repository: mockRepository, getUserById: getUserByIdUseCase);
  });

  group(
    'GetLocalUserUseCase:',
    () {
      final tUser =
          UserEntity(id: 'test', name: 'test', age: 30, gender: "test", infected:false);
      test(
        'return a [UserEntity] when both requisitions goes right',
        () async {
          // arrange
          when(mockRepository.getLocalUser())
              .thenAnswer((_) async => Right(tUser));
          when(mockRepository.getUserEntityById(any))
              .thenAnswer((_) async => Right(tUser));
          // act
          final result = await usecase(GetLocalUserNoParams());

          // assert
          expect(result, Right(tUser));
        },
      );

      test(
        'return a [CacheFailure] when the first requisition fail',
        () async {
          // arrange
          when(mockRepository.getLocalUser())
              .thenAnswer((_) async => Left(CacheFailure()));
          // act
          final result = await usecase(GetLocalUserNoParams());

          // assert
          expect(result, Left(CacheFailure()));
        },
      );

      test(
        'return a [ServerFailure] when the first requisition goes right but the second fails',
        () async {
          // arrange
          when(mockRepository.getLocalUser())
              .thenAnswer((_) async => Right(tUser));
          when(mockRepository.getUserEntityById(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          // act
          final result = await usecase(GetLocalUserNoParams());

          // assert
          expect(result, Left(ServerFailure()));
        },
      );

    },
  );
}
