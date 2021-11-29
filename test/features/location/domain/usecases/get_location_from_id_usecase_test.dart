import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';

import 'package:the_resident_zombie/features/location/domain/usecases/get_location_from_id_usecase.dart';

import '../../../user/domain/usecases/create_user_usecase_test.mocks.dart';

void main() {
  late MockLocationRepository repository;
  late GetLocationFromIdUseCase usecase;

  setUp(() {
    repository = MockLocationRepository();
    usecase = GetLocationFromIdUseCase(repository: repository);
  });

  group(
    'GetLocationFromIdUseCase:',
    () {
      final tId = "test";
      final tlocation = LocationEntity(latitude: 0, longitude: 0);
      test(
        'return a [LocationEntity]',
        () async {
          // arrange
          when(repository.getLocationFromId(any))
              .thenAnswer((_) async => Right(tlocation));
          // act
          final result = await usecase(GetLocationFromIdParams(tId));

          // assert
          expect(result, Right(tlocation));
        },
      );

      test(
        'return a [ServerFailure]',
        () async {
          // arrange
          when(repository.getLocationFromId(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          // act
          final result = await usecase(GetLocationFromIdParams(tId));

          // assert
          expect(result, Left(ServerFailure()));
        },
      );
    },
  );
}
