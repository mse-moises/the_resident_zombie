import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/core/params/confirmation.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';
import 'package:the_resident_zombie/features/location/domain/usecases/compare_location_usecase.dart';

void main() {
  late CompareLocationUseCase usecase;

  setUp(() {
    usecase = CompareLocationUseCase();
  });

  group(
    'CompareLocationUseCase:',
    () {
      final tFirstLocation = LocationEntity(latitude: 0, longitude: 0);
      final tSecondLocation =
          LocationEntity(latitude: 0.0001, longitude: 0.0001);
      final tThirdLocation = LocationEntity(latitude: 0.01, longitude: 0.01);
      test(
        'return a [Confirmation] confirm when the locatins are near',
        () async {
          // act
          final result = await usecase(CompareLocationsParams(tFirstLocation, tSecondLocation));
          // assert
          expect(result, Right(Confirmation()));
        },
      );

      test(
        'return a [Confirmation] confirm when the locatins are the same',
        () async {
          // act
          final result = await usecase(CompareLocationsParams(tFirstLocation, tFirstLocation));
          // assert
          expect(result, Right(Confirmation()));
        },
      );

      test(
        'return a [LocationTradeFailure] when the location arent near',
        () async {
          // act
          final result = await usecase(CompareLocationsParams(tFirstLocation, tThirdLocation));
          // assert
          expect(result, Left(LocationTradeFailure()));
        },
      );
    },
  );
}
