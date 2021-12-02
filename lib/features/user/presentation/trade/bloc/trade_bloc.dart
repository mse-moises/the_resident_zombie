import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_items_type_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/trade_with_user_usecase.dart';

part 'trade_event.dart';
part 'trade_state.dart';

class TradeBloc extends Bloc<TradeEvent, TradeState> {
  final TradeWithUserUseCase trade;
  final GetItemsTypeUseCase getItems;
  TradeBloc({required this.getItems, required this.trade}) : super(TradeLoadingState()) {
    on<TradeEvent>((event, emit) async {
      if(event is TradeRequestItemsEvent){
        final result = await getItems(GetItemsTypeNoParams());
        result.fold((l) => emit(TradeCriticalFail()), (r) => emit(TradeLoadedState(r)));
      }

      if(event is TradeExecuteTradeEvent){
        emit(TradeLoadingState());
        final result = await trade(TradeParams(pick:event.pick,pay:event.pay,otherUserName:event.name));
        result.fold((l) => emit(TradeCriticalFail()), (r) => emit(TradeSuccessState()));
      }



    });
  }
}
