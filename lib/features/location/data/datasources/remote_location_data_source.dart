import 'dart:convert';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/features/location/data/models/location_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteLocationDataSource {
  /// Uses the [Geolocator] class from geolocator package to get the device gps info.
  ///
  /// Throws a [DeviceExcpetion] for all error codes.
  Future<LocationModel> getLocationFromId(String id);
}

const String BASE_URL_LOCATION =
    "http://zssn-backend-example.herokuapp.com/api/";

const Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

class RemoteLocationDataSourceImpl implements RemoteLocationDataSource {
  final http.Client client;

  RemoteLocationDataSourceImpl({required this.client});

  @override
  Future<LocationModel> getLocationFromId(String id) async {
    final response = await client.get(
      Uri.parse('${BASE_URL_LOCATION}people/$id.json'),
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return LocationModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
