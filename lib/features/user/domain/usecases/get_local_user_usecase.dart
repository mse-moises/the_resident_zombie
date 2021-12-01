import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/get_user_by_id_usecase.dart';

class GetLocalUserUseCase implements UseCase<UserEntity, GetLocalUserNoParams> {
  final UserRepository repository;

  final GetUserByIdUseCase getUserById;

  GetLocalUserUseCase({required this.repository, required this.getUserById});
  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    final result = await repository.getLocalUser();
    if (result.isLeft()) return result;

    late UserEntity user;
    result.fold((l) => null, (r) => user = r);

    return await getUserById(GetUserByIdParams(identifier: user.id));
  }
}

class GetLocalUserNoParams extends Equatable {
  @override
  List<Object> get props => [];
}
