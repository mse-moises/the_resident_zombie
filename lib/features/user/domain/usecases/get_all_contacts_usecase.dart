import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';

import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/get_user_by_id_usecase.dart';

class GetAllContactsUsecase
    extends UseCase<List<UserEntity>, GetAllContactsParams> {
  final UserRepository repository;
  final GetUserByIdUseCase getUserByIdUseCase;

  GetAllContactsUsecase({required this.repository, required this.getUserByIdUseCase});
  @override
  Future<Either<Failure, List<UserEntity>>> call(
      GetAllContactsParams params) async {
    final allContactsInfo = await repository.getAllContactsIds();

    if (allContactsInfo.isLeft()) return Left(CacheFailure());

    final contactsIdList = allContactsInfo.toOption().toNullable()!;

    List<UserEntity> users = [];

    for(String contactId in contactsIdList){
      final userbyIdResponse = await getUserByIdUseCase(GetUserByIdParams(identifier: contactId));
      if(userbyIdResponse.isRight()){ 
        final user = userbyIdResponse.toOption().toNullable()!;
        users.add(user);
      }
    }

    return Right(users);
  }
}

class GetAllContactsParams extends Equatable {
  GetAllContactsParams();
  @override
  List<Object> get props => [];
}
