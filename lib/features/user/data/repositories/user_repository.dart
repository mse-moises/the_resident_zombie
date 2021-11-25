import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository{
  @override
  Future<Either<Failure, UserEntity>> createUser(String name, int age, String gender) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

}