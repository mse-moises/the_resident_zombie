import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';

class GetUserByIdUseCase extends UseCase<UserEntity, GetUserByIdParams> {
  final UserRepository repository;

  GetUserByIdUseCase({required this.repository});
  @override
  Future<Either<Failure, UserEntity>> call(GetUserByIdParams params) async {
    return await repository.getUserEntityById(params.identifier);
  }
}

class GetUserByIdParams extends Equatable {
  final String identifier;

  GetUserByIdParams({required this.identifier});
  @override
  List<Object> get props => [identifier];
}
