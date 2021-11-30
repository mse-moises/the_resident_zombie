import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';
import 'package:the_resident_zombie/features/location/domain/repositories/location_repository.dart';
import 'package:the_resident_zombie/features/location/domain/usecases/get_location_usecase.dart';

import 'get_location_usecase_test.mocks.dart';

@GenerateMocks([LocationRepository])
void main() {
  late GetLocationUseCase usecase;
  late MockLocationRepository mockLocationRepository;

  setUp(() {
    mockLocationRepository = MockLocationRepository();
    usecase = GetLocationUseCase(repository: mockLocationRepository);
  });

  final tLocation = LocationEntity(latitude: 0, longitude: 0);

  group(
    'Get location usecase:',
    () {
      test(
        'return a LocationEntity when requested is successful',
        () async {
          // arrange
          when(mockLocationRepository.getCurrentLocation())
              .thenAnswer((_) async => Right(tLocation));
          // act
          final result = await usecase(NoParamsGetLocation());
          // assert
          expect(result, equals(Right(tLocation)));
          verify(mockLocationRepository.getCurrentLocation());
        },
      );

      test(
        'return a [Failure] when requested isnt successful',
        () async {
          // arrange
          when(mockLocationRepository.getCurrentLocation())
              .thenAnswer((_) async => Left(DeviceFailure()));
          // act
          final result = await usecase(NoParamsGetLocation());
          // assert
          expect(result, equals(Left(DeviceFailure())));
        },
      );
    },
  );
}
