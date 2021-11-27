import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/features/user/data/datasources/user_remote_data_source.dart';
import 'package:the_resident_zombie/features/user/data/models/user_model.dart';

import '../../../../fixture/fixture_reader.dart';

import 'user_local_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late UserRemoteDataSource datasource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    datasource = UserRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClient200() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response(fixture('user.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('SomethingWentWrong', 404));
  }

  group(
    'create user',
    () {
      final tName = "test";
      final tAge = 30;
      final tGender = "M";
      final tPositionString = "POINT (-46.67105 -23.618437)";

      final tUserModel = UserModel.fromJson(json.decode(fixture('user.json')));

      test(
        'return a valid UserModel from a GetRequest on a URL with a string being the endpoint and with application/json header when the response code is 200',
        () async {
          // arrange
          setUpMockHttpClient200();
          // act
          final result = await datasource.createUser(tName, tAge, tGender, tPositionString);
          // assert
          expect(result, equals(tUserModel));
        },
      );

      test(
        'throw a ServerException from a GET request on a URL with a string being the endpoint and with application/json header when the resposne code isnt 200',
        () async {
          // arrange
          setUpMockHttpClientFailure404();
          // act
          final call = datasource.createUser;
          // assert
          expect(()=> call(tName, tAge, tGender, tPositionString), throwsA(TypeMatcher<ServerException>()));
        },
      );
    },
  );
}
