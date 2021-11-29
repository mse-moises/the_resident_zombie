import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';

class GetLocalUserUseCase implements UseCase<UserEntity, GetLocalUserNoParams> {
  final UserRepository repository;

  GetLocalUserUseCase({required this.repository});
  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    return await repository.getLocalUser();
  }
}

class GetLocalUserNoParams extends Equatable {
  @override
  List<Object> get props => [];
}
