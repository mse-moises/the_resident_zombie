import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';

class CreateUserUsecase{
  final UserRepository repository;

  CreateUserUsecase(this.repository);

  Future<Either<Failure,UserEntity>> call({required String name, required int age, required String gender}) async {
    return await repository.createUser(name, age, gender);
  }
}