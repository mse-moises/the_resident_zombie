import 'package:geolocator/geolocator.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/core/platform/localization_info.dart';
import 'package:the_resident_zombie/features/location/data/models/location_model.dart';

abstract class LocationDataSource {
  /// Uses the [Geolocator] class from geolocator package to get the device gps info.
  ///
  /// Throws a [DeviceExcpetion] for all error codes.
  Future<LocationModel> getCurrentLocation();
}

class LocationDataSourceImpl implements LocationDataSource {
  final LocalizationInfo localizationInfo;

  LocationDataSourceImpl({required this.localizationInfo});
  @override
  Future<LocationModel> getCurrentLocation() async {

    final position = await localizationInfo.getCurrentPosition();
    
    final location = LocationModel(
        latitude: position.latitude, longitude: position.longitude);

    return location;
  }



}
