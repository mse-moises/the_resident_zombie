part of 'trade_bloc.dart';

abstract class TradeEvent extends Equatable {
  const TradeEvent();

  @override
  List<Object> get props => [];
}

class TradeRequestItemsEvent extends TradeEvent{}

class TradeExecuteTradeEvent extends TradeEvent{
  final List<int> pick;
  final List<int> pay;
  final String name;

  TradeExecuteTradeEvent(this.pick, this.pay, this.name);
}