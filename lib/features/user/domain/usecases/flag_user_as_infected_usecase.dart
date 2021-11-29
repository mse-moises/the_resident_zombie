import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';

class FlagUserAsInfectedUseCase extends UseCase<bool, FlagParams> {

  final UserRepository repository;

  FlagUserAsInfectedUseCase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(params) async {
    return await repository.flagUserAsInfected(params.identifier);
  }
}

class FlagParams extends Equatable {
  final String identifier;

  FlagParams({required this.identifier});

  @override
  List<Object> get props => [identifier];
}

