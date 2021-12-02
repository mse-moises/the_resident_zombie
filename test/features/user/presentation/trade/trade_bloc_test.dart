import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_items_type_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/trade_with_user_usecase.dart';
import 'package:the_resident_zombie/features/user/presentation/trade/bloc/trade_bloc.dart';

//import '../create_user/bloc/create_user_bloc_test.mocks.dart';
import 'trade_bloc_test.mocks.dart';

@GenerateMocks([GetItemsTypeUseCase])
@GenerateMocks([TradeWithUserUseCase])
void main() {
  late MockTradeWithUserUseCase mockTrade;
  late MockGetItemsTypeUseCase mockGetItems;

  late TradeBloc bloc;

  setUp(() {
    mockTrade = MockTradeWithUserUseCase();
    mockGetItems = MockGetItemsTypeUseCase();

    bloc = TradeBloc(getItems: mockGetItems, trade: mockTrade);
  });

  group('ContactListBloc:', () {
    test(
      'inital state is [CreateUserLoadingState]',
      () async {
        // assert
        expect(bloc.state, TradeLoadingState());
      },
    );

    final tItems = [
      ItemEntity(name: "name", value: 0),
      ItemEntity(name: "name", value: 0),
      ItemEntity(name: "name", value: 0),
      ItemEntity(name: "name", value: 0),
    ];

    blocTest<TradeBloc, TradeState>(
      'emit [TradeLoadedState] when it find the items',
      build: () {
        when(mockGetItems(any)).thenAnswer((_) async => Right(tItems));
        return bloc;
      },
      act: (bloc) => bloc.add(TradeRequestItemsEvent()),
      expect: () => [
        TradeLoadedState(tItems),
      ],
    );

    blocTest<TradeBloc, TradeState>(
      'emit [TradeCriticalFail] when it cant find the items',
      build: () {
        when(mockGetItems(any)).thenAnswer((_) async => Left(DeviceFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(TradeRequestItemsEvent()),
      expect: () => [
        TradeCriticalFail(),
      ],
    );

    blocTest<TradeBloc, TradeState>(
      'emit [TradeLoadedState] when it find the items',
      build: () {
        when(mockGetItems(any)).thenAnswer((_) async => Right(tItems));
        return bloc;
      },
      act: (bloc) => bloc.add(TradeRequestItemsEvent()),
      expect: () => [
        TradeSuccessState(),
      ],
    );
  });
}
