import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/core/platform/network_info.dart';
import 'package:the_resident_zombie/features/user/data/datasources/user_cache_data_source.dart';
import 'package:the_resident_zombie/features/user/data/datasources/user_remote_data_source.dart';
import 'package:the_resident_zombie/features/user/data/repositories/user_repository.dart';
import 'package:the_resident_zombie/features/user/data/models/user_model.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([UserCacheDataSource])
@GenerateMocks([UserRemoteDataSource])
@GenerateMocks([NetworkInfo])
void main() {
  late UserRepositoryImpl repository;
  late MockUserCacheDataSource mockUserCacheDataSource;
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockUserCacheDataSource = MockUserCacheDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = UserRepositoryImpl(
      remoteDataSource: mockUserRemoteDataSource,
      cacheDataSource: mockUserCacheDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('User repository test:', () {
    final tName = "teste";
    final int tAge = 1;
    final tGender = "teste";
    final tPositionString = "POINT (-46.67105 -23.618437)";
    final tItems = "Fiji Water:10;Campbell Soup:5";

    final tUserModel = UserModel(name: tName, age: tAge, gender: tGender);

    final tUserEntity = tUserModel;

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('check if the device is online', () async {
        // arrange
        when(mockUserRemoteDataSource.createUser(any, any, any, any, any))
            .thenAnswer((_) async => tUserModel);
        // act
        await repository.createUser(
            tName, tAge, tGender, tPositionString, tItems);
        // assert
        verify(mockNetworkInfo.isConnected);
      });

      test(
          'return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockUserRemoteDataSource.createUser(any, any, any, any, any))
            .thenAnswer((_) async => tUserModel);
        // act
        final result = await repository.createUser(
            tName, tAge, tGender, tPositionString, tItems);
        // assert

        verify(mockUserRemoteDataSource.createUser(
            tName, tAge, tGender, tPositionString, tItems));
        expect(result, equals(Right(tUserEntity)));
      });

      test(
          'cache the data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockUserRemoteDataSource.createUser(any, any, any, any, any))
            .thenAnswer((_) async => tUserModel);
        // act
        await repository.createUser(
            tName, tAge, tGender, tPositionString, tItems);
        // assert

        verify(mockUserRemoteDataSource.createUser(
            tName, tAge, tGender, tPositionString, tItems));
        verify(mockUserCacheDataSource.cacheUser(tUserModel));
      });

      test(
          'return [ServerFailure] when the call to remote data source is unsucessful',
          () async {
        // arrange

        when(mockUserRemoteDataSource.createUser(any, any, any, any, any))
            .thenThrow(ServerException());

        // act
        final result = await repository.createUser(
            tName, tAge, tGender, tPositionString, tItems);
        // assert

        verify(mockUserRemoteDataSource.createUser(
            tName, tAge, tGender, tPositionString, tItems));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    test('return [ServerFailure] when the call the device is offline',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // act
      final result = await repository.createUser(
          tName, tAge, tGender, tPositionString, tItems);

      // assert
      expect(result, equals(Left(ServerFailure())));
      verifyZeroInteractions(mockUserRemoteDataSource);
    });

    group(
      'Update location -',
      () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });
        final tIdentifier = "test";
        final tPosition = "test";
        test(
          'return UserModel if the resquest is successful',
          () async {
            // arrange
            when(mockUserRemoteDataSource.updateUserLocation(any, any))
                .thenAnswer((realInvocation) async => tUserModel);
            // act
            final result =
                await repository.updateUserLocation(tIdentifier, tPosition);
            // assert
            expect(result, equals(Right(tUserModel)));
          },
        );
        test(
          'return [ServerFailure] if the resquest is unsuccessful',
          () async {
            // arrange
            when(mockUserRemoteDataSource.updateUserLocation(any, any))
                .thenThrow(ServerException());
            // act
            final result =
                await repository.updateUserLocation(tIdentifier, tPosition);
            // assert
            expect(result, equals(Left(ServerFailure())));
          },
        );
      },
    );
  });
}
