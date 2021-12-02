import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
//import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/core/params/confirmation.dart';
import 'package:the_resident_zombie/features/user/data/datasources/user_remote_data_source.dart';
import 'package:the_resident_zombie/features/user/data/models/user_model.dart';

import '../../../../fixture/fixture_reader.dart';

import '../../../location/data/datasource/remote_location_data_source_test.mocks.dart';


@GenerateMocks([http.Client])
void main() {
  late UserRemoteDataSource datasource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    datasource = UserRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockGetHttpClient200ReturnUser() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('user.json'), 200));
  }

  void setUpMockGetHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('SomethingWentWrong', 404));
  }

  void setUpMockPostHttpClient201ReturnUser() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response(fixture('user.json'), 201));
  }

  void setUpMockPostHttpClientFailure404() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('SomethingWentWrong', 404));
  }

  void setUpMockPatchHttpClient200ReturnUser() {
    when(mockHttpClient.patch(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response(fixture('user.json'), 200));
  }

  void setUpMockPatchHttpClientFailure404() {
    when(mockHttpClient.patch(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('SomethingWentWrong', 404));
  }

  group(
    'User remote datasource:',
    () {
      final tName = "test";
      final tAge = 30;
      final tGender = "M";
      final tPositionString = "POINT (-46.67105 -23.618437)";
      final tItems = "Fiji Water:10;Campbell Soup:5";

      final tUserModel = UserModel.fromJson(json.decode(fixture('user.json')));

      test(
        'return a valid UserModel from a GetRequest on a URL with a string being the endpoint and with application/json header when the response code is 200',
        () async {
          // arrange
          setUpMockPostHttpClient201ReturnUser();
          // act
          final result = await datasource.createUser(
              tName, tAge, tGender, tPositionString, tItems);
          // assert
          expect(result, equals(tUserModel));
        },
      );

      test(
        'throw a ServerException from a GET request on a URL with a string being the endpoint and with application/json header when the resposne code isnt 200',
        () async {
          // arrange
          setUpMockPostHttpClientFailure404();
          // act
          final call = datasource.createUser;
          // assert
          expect(() => call(tName, tAge, tGender, tPositionString, tItems),
              throwsA(TypeMatcher<ServerException>()));
        },
      );

      group(
        'Update location -',
        () {
          final tIdentifier = 'test';
          final tLocation = 'test';
          test(
            'return a tUserModel if the request was successful',
            () async {
              // arrange
              setUpMockPatchHttpClient200ReturnUser();
              // act
              final result =
                  await datasource.updateUserLocation(tIdentifier, tLocation);
              // assert
              expect(result, equals(tUserModel));
            },
          );
          test(
            'throw a ServerException from a the request wasnt successful',
            () async {
              // arrange
              setUpMockPatchHttpClientFailure404();
              // act
              final call = datasource.updateUserLocation;
              // assert
              expect(() => call(tIdentifier, tLocation),
                  throwsA(TypeMatcher<ServerException>()));
            },
          );
        },
      );

      group(
        'Get user by id -',
        () {
          final tIdentifier = 'test';
          test(
            'return a tUserModel if the request was successful',
            () async {
              // arrange
              setUpMockGetHttpClient200ReturnUser();
              // act
              final result = await datasource.getUserEntityById(tIdentifier);
              // assert
              expect(result, equals(tUserModel));
            },
          );
          test(
            'throw a ServerException from a the request wasnt successful',
            () async {
              // arrange
              setUpMockGetHttpClientFailure404();
              // act
              final call = datasource.getUserEntityById;
              // assert
              expect(() => call(tIdentifier),
                  throwsA(TypeMatcher<ServerException>()));
            },
          );
        },
      );

      group(
        'Flag user as infected',
        () {
          final tIdentifier = "test";
          test(
            'return a bool if the request was successful',
            () async {
              // arrange
              when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
                  .thenAnswer(
                      (_) async => http.Response(fixture('user.json'), 204));
              // act
              final result = await datasource.flagUserAsInfected(tIdentifier);
              // assert
              expect(result, Confirmation());
            },
          );

          test(
            'throw a [ServerException] if the reques wasnt successful',
            () async {
              // arrange
              setUpMockPostHttpClientFailure404();
              // act
              final call = () => datasource.flagUserAsInfected(tIdentifier);
              // assert
              expect(() => call(),
                  throwsA(TypeMatcher<ServerException>()));
            },
          );
        },
      );
    },
  );
}
