import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/core/platform/network_info.dart';
import 'package:the_resident_zombie/features/user/data/datasources/user_cache_data_source.dart';
import 'package:the_resident_zombie/features/user/data/datasources/user_remote_data_source.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserCacheDataSource cacheDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.cacheDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> createUser(
    String name,
    int age,
    String gender,
    String location,
  ) async {
    if (!await networkInfo.isConnected) return Left(ServerFailure());

    try {
      final remoteAddress =
          await remoteDataSource.createUser(name, age, gender,location);

      cacheDataSource.cacheUser(remoteAddress);
      return Right(remoteAddress);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
