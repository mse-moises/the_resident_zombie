import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/params/confirmation.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/items/domain/entities/back_pack_entity.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/compare_backpack_usecase.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_backpack_from_numbers_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/repositories/user_repository.dart';

class TradeWithUserUseCase implements UseCase<Confirmation, TradeParams> {
  final UserRepository repository;
  final GetBackpackFromNumbersUsecase getBackpackUsecase;
  final CompareBackpackUsecase compareUsecase;

  TradeWithUserUseCase(
      {required this.repository,
      required this.getBackpackUsecase,
      required this.compareUsecase});

  @override
  Future<Either<Failure, Confirmation>> call(params) async {
    //pick backpack
    final pickBackPackResult =
        await getBackpackUsecase(BackPackParams(params.pick));

    late BackPackEntity backPackPick;
    late Failure pickFailure;
    pickBackPackResult.fold((l) => pickFailure = l, (r) => backPackPick = r);
    if (pickBackPackResult.isLeft()) return Left(pickFailure);

    //pay backpack
    final payBackPackResult =
        await getBackpackUsecase(BackPackParams(params.pay));

    late BackPackEntity backPackPay;
    late Failure payFailure;
    payBackPackResult.fold((l) => payFailure = l, (r) => backPackPay = r);
    if (payBackPackResult.isLeft()) return Left(payFailure);

    final pickComparation =
        await compareUsecase(CompareBackPackParams(backPackPick, backPackPay));

    //comparate if they are the same value
    late Failure comparationFailure;
    final resultComparation =
        pickComparation.fold((l) => comparationFailure = l, (r) => Right(r));
    if (pickComparation.isLeft()) return Left(comparationFailure);

    final pickString = backPackPick.inventoryToString();
    final payString = backPackPay.inventoryToString();

    //send trade request to UserRepository
    return await repository.tradeWithUser(
        pickString, payString, params.otherUserName);
  }
}

class TradeParams extends Equatable {
  final List<int> pick;
  final List<int> pay;
  final String otherUserName;

  TradeParams(
      {required this.pick, required this.pay, required this.otherUserName});
  @override
  List<Object> get props => [pick, pay, otherUserName];
}
