import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/core/params/confirmation.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';

abstract class UserRepository{
  Future<Either<Failure,UserEntity>> createUser(String name, int age, String gender, String location, String items);

  Future<Either<Failure,UserEntity>> updateUserLocation(String id, String location);

  Future<Either<Failure,String>> saveContact(String id);

  Future<Either<Failure,UserEntity>> getUserEntityById(String id);

  Future<Either<Failure,List<String>>> getAllContactsIds();

  Future<Either<Failure,Confirmation>> flagUserAsInfected(String id);

  Future<Either<Failure,Confirmation>> tradeWithUser(String pick, String pay, String otherUserName);

  Future<Either<Failure,UserEntity>> getLocalUser();
}
