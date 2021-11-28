import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/save_contact_usecase.dart';

import 'create_user_usecase_test.mocks.dart';

void main() {
  late MockUserRepository repository;
  late SaveContactUsecase usecase;

  setUp(() {
    repository = MockUserRepository();
    usecase = SaveContactUsecase(repository: repository);
  });

  group(
    'SaveContactUsecase:',
    () {
      final tIdentifier = "test";
      test(
        'return the Id when the request to save was successful',
        () async {
          // arrange
          when(repository.saveContact(any)).thenAnswer((_) async =>Right(tIdentifier));
          // act
          final result = await usecase(ParamsSaveContact(identifier: tIdentifier));
          // assert
          expect(result, equals(Right(tIdentifier)));
        },
      );

      test(
        'return the [CacheFailure] when the request to save was unsuccessful',
        () async {
          // arrange
          when(repository.saveContact(any)).thenAnswer((_) async =>Left(CacheFailure()));
          // act
          final result = await usecase(ParamsSaveContact(identifier: tIdentifier));
          // assert
          expect(result, equals(Left(CacheFailure())));
        },
      );
    },
  );
}
