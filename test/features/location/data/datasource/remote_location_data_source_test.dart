import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/features/location/data/datasources/remote_location_data_source.dart';
import 'package:the_resident_zombie/features/location/data/models/location_model.dart';

import '../../../../fixture/fixture_reader.dart';
import '../../../user/data/datasources/user_remote_data_source_test.mocks.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
void main() {
  late MockClient mockHttpClient;
  late RemoteLocationDataSourceImpl remoteDataSource;

  setUp(() {
    mockHttpClient = MockClient();
    remoteDataSource = RemoteLocationDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockGetHttpClient200ReturnUser() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('user.json'), 200));
  }

  void setUpMockGetHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('SomethingWentWrong', 404));
  }

  group(
    'RemoteDataSource:',
    () {
      final tId = "test";

      group(
        'Get location by id -',
        () {
          test(
            'return a LocationModel',
            () async {
              // arrange
              setUpMockGetHttpClient200ReturnUser();
              // act

              final result = await remoteDataSource.getLocationFromId(tId);

              // assert
              expect(result, isA<LocationModel>());
            },
          );

          test(
            'throw a ServerException',
            () async {
              // arrange
              setUpMockGetHttpClientFailure404();
              // act
              final call = () => remoteDataSource.getLocationFromId(tId);
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
