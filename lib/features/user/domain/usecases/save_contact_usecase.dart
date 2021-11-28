import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';

class SaveContactUsecase implements UseCase<String, ParamsSaveContact> {
  final UserRepository repository;

  SaveContactUsecase({required this.repository});

  @override
  Future<Either<Failure, String>> call(ParamsSaveContact params) async {
    return await repository.saveContact(params.identifier);
  }
}

class ParamsSaveContact extends Equatable {
  final String identifier;

  ParamsSaveContact({required this.identifier});
  @override
  List<Object> get props => [identifier];
}
