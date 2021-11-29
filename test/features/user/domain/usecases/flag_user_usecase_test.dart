import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/core/params/confirmation.dart';

import 'package:the_resident_zombie/features/user/domain/usecases/flag_user_as_infected_usecase.dart';

import 'create_user_usecase_test.mocks.dart';

void main() {
  late MockUserRepository repository;
  late FlagUserAsInfectedUseCase usecase;
  setUp(() {
    repository = MockUserRepository();
    usecase = FlagUserAsInfectedUseCase(repository: repository);
  });

  group(
    'Flag user as infected:',
    () {
      String tIdentifier = "test";
      test(
        'shoud return a bool when the resquest is successful',
        () async {
          final tReturn = Confirmation();
          // arrange
          when(repository.flagUserAsInfected(any))
              .thenAnswer((_) async => Right(tReturn));
          // act
          final result = await usecase(FlagParams(identifier: tIdentifier));

          // assert
          expect(result, Right(Confirmation()));
        },
      );

      test(
        'shoud return a [ServerFailure] when the resquest is successful',
        () async {
          bool tReturn = true;
          // arrange
          when(repository.flagUserAsInfected(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          // act
          final result = await usecase(FlagParams(identifier: tIdentifier));

          // assert
          expect(result, Left(ServerFailure()));
        },
      );
    },
  );
}
