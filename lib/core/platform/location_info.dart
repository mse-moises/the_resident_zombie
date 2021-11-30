import 'package:location/location.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/features/location/data/models/location_model.dart';

abstract class LocalizationInfo {
  Future<LocationModel> getCurrentPosition();
}

class LocalizationInfoImpl implements LocalizationInfo {
  Location location = Location();
  LocalizationInfoImpl();

  @override
  Future<LocationModel> getCurrentPosition() async {
    try {
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          throw DeviceException();
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          throw DeviceException();
        }
      }

      _locationData = await location.getLocation();

      return LocationModel(
          latitude: _locationData.latitude!,
          longitude: _locationData.longitude!);
    } catch (e) {
      throw DeviceException();
    }

    /*
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      throw DeviceException();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        throw DeviceException();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw DeviceException();
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
    */
  }
}
