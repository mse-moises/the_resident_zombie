import 'package:flutter_test/flutter_test.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';

void main() {
  late LocationEntity tLocationEntity;

  setUp(() {
    tLocationEntity = LocationEntity(latitude: 0.0, longitude: 0.0);
  });

  final String tString = "POINT (0.0 0.0)";

  test(
    'should return a valid String from toString of a [LocationEntity]',
    () async {
      // act
      final result = tLocationEntity.toString();
      // assert
      expect(result, equals(tString));
    },
  );
}
