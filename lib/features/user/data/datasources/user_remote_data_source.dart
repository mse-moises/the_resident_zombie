import 'dart:convert';

import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/features/user/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  ///Send a http post request for the http://zssn-backend-example.herokuapp.com/api/people.json endpoint.
  ///
  ///
  ///Throws a [ServerException] for all error codes.
  Future<UserModel> createUser(
      String name, int age, String gender, String location, String items);
  Future<UserModel> updateUserLocation(String id, String location);
  Future<UserModel> getUserEntityById(String id);
  Future<bool> flagUserAsInfected(String id);
}

const String BASE_URL = "http://zssn-backend-example.herokuapp.com/api/";

const Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});
  @override
  Future<UserModel> createUser(String name, int age, String gender,
      String location, String items) async {
    final body = {
      "person": {
        "name": name,
        "age": age,
        "gender": gender,
        "lonlat": location,
        "items": items
      }
    };

    final response = await client.post(
      Uri.parse('${BASE_URL}people.json'),
      headers: requestHeaders,
      body: body,
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> updateUserLocation(String id, String location) async {
    final body = {
      "person": {
        "lonlat": location,
      }
    };

    final response = await client.patch(
      Uri.parse('${BASE_URL}people/$id.json'),
      headers: requestHeaders,
      body: body,
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUserEntityById(String id) async {
    final response = await client.get(
      Uri.parse('${BASE_URL}people/$id.json'),
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> flagUserAsInfected(String id) async {
    final body = {"infected": id};

    final response = await client.post(
      Uri.parse('${BASE_URL}people/$id/report_infection.json'),
      headers: requestHeaders,
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 202) {
      return true;
    } else {
      throw ServerException();
    }
  }
}
