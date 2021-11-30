import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/core/platform/location_info.dart';
import 'package:the_resident_zombie/features/location/data/datasources/local_location_data_source.dart';
import 'package:the_resident_zombie/features/location/data/models/location_model.dart';

import 'local_location_data_source_test.mocks.dart';

@GenerateMocks([LocalizationInfo])
void main() {
  late MockLocalizationInfo mockLocalizationInfo;
  late LocalLocationDataSourceImpl locationDataSource;
  setUp(() {
    mockLocalizationInfo = MockLocalizationInfo();
    locationDataSource =
        LocalLocationDataSourceImpl(localizationInfo: mockLocalizationInfo);
  });

  final tLocationModel = LocationModel(latitude: 0.0, longitude: 0.0);
  

  group(
    'Location data source:',
    () {
      test(
        'return a [LocationModel] when the resquest is successful',
        () async {
          // arrange
          when(mockLocalizationInfo.getCurrentPosition())
              .thenAnswer((_) async => tLocationModel);
          // act
          final result = await locationDataSource.getCurrentLocation();
          // assert
          expect(result, equals(tLocationModel));
        },
      );

      test(
        'throw a [DeviceException] when the resquest is unsuccessful',
        () async {
          // arrange
          when(mockLocalizationInfo.getCurrentPosition())
              .thenThrow(DeviceException());
          // act
          final call = locationDataSource.getCurrentLocation;
          // assert
          expect(() => call(), throwsA(TypeMatcher<DeviceException>()));
        },
      );
    },
  );
}
