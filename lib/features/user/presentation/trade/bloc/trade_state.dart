part of 'trade_bloc.dart';

abstract class TradeState extends Equatable {
  const TradeState();

  @override
  List<Object> get props => [];
}

class TradeLoadingState extends TradeState {}

class TradeLoadedState extends TradeState {
  final List<ItemEntity> items;

  TradeLoadedState(this.items);
}

class TradeCriticalFail extends TradeState {}

class TradeSuccessState extends TradeState {}