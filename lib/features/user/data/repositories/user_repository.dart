import 'package:the_resident_zombie/core/error/exceptions.dart';
import 'package:the_resident_zombie/core/params/confirmation.dart';
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
    String items,
  ) async {
    if (!await networkInfo.isConnected) return Left(ServerFailure());

    try {
      final remoteAddress =
          await remoteDataSource.createUser(name, age, gender, location, items);

      cacheDataSource.cacheUser(remoteAddress);
      return Right(remoteAddress);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUserLocation(
      String id, String location) async {
    if (!await networkInfo.isConnected) return Left(ServerFailure());

    try {
      final result = await remoteDataSource.updateUserLocation(id, location);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserEntityById(String id) async {
    if (!await networkInfo.isConnected) return Left(ServerFailure());

    try {
      final result = await remoteDataSource.getUserEntityById(id);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> saveContact(String id) async {
    try {
      final result = await cacheDataSource.saveContact(id);

      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllContactsIds() async {
    try {
      final result = await cacheDataSource.getAllContactsIds();

      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Confirmation>> flagUserAsInfected(String id) async {
    try {
      final result = await remoteDataSource.flagUserAsInfected(id);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
