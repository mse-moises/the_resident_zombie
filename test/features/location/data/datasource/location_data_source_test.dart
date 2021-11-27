import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/core/platform/location_info.dart';
import 'package:the_resident_zombie/features/location/data/datasources/location_data_source.dart';
import 'package:the_resident_zombie/features/location/data/models/location_model.dart';

import 'location_data_source_test.mocks.dart';

@GenerateMocks([LocalizationInfo])
void main() {
  late MockLocalizationInfo mockLocalizationInfo;
  late LocationDataSourceImpl locationDataSource;
  setUp(() {
    mockLocalizationInfo = MockLocalizationInfo();
    locationDataSource = LocationDataSourceImpl(localizationInfo: mockLocalizationInfo);
  });

  final tLocationModel = LocationModel(latitude: 0.0, longitude: 0.0);
  final tPosition = Position(latitude: 0.0, longitude: 0.0, accuracy: 0.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0, timestamp: null);

  test(
    'return a [LocationModel] when the resquest is successful',
    () async {
      // arrange
      when(mockLocalizationInfo.getCurrentPosition()).thenAnswer((_) async => tPosition);
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
      when(mockLocalizationInfo.getCurrentPosition()).thenThrow(DeviceException());
      // act
      final call = locationDataSource.getCurrentLocation;
      // assert
      expect(()=>call(), throwsA(TypeMatcher<DeviceException>()));
    },
  );
}
