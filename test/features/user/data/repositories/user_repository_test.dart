import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/platform/network_info.dart';
import 'package:the_resident_zombie/features/user/data/datasources/user_cache_data_source.dart';
import 'package:the_resident_zombie/features/user/data/datasources/user_remote_data_source.dart';
import 'package:the_resident_zombie/features/user/data/repositories/user_repository.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([UserCacheDataSource])
@GenerateMocks([UserRemoteDataSource])
@GenerateMocks([NetworkInfo])
void main(){
  UserRepositoryImpl repository;
  MockUserCacheDataSource mockUserCacheDataSource;
  MockUserRemoteDataSource mockUserRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockUserCacheDataSource = MockUserCacheDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = UserRepositoryImpl(
      remoteDataSource: mockUserRemoteDataSource,
      cacheDataSource: mockUserCacheDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
}