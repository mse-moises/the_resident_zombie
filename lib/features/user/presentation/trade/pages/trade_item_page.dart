import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_resident_zombie/core/global_components/fail_screen.dart';
import 'package:the_resident_zombie/core/global_components/loading_screen.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/presentation/create_user/components/item_counter_widget.dart';
import 'package:the_resident_zombie/features/user/presentation/trade/bloc/trade_bloc.dart';
import 'package:the_resident_zombie/injection_container.dart';
import 'package:the_resident_zombie/core/utils/style.dart' as style;

class TradeItemsPage extends StatefulWidget {
  static const String route = '/trade';

  var arguments;

  TradeItemsPage(this.arguments);

  @override
  _TradeItemsPageState createState() => _TradeItemsPageState();
}

class _TradeItemsPageState extends State<TradeItemsPage> {
  late UserEntity other;
  final bloc = sl.get<TradeBloc>();
  late List<int> itemsQuantityWant;
  late List<int> itemsQuantityPay;

  void submit() {
    bloc.add(TradeExecuteTradeEvent(
        itemsQuantityWant, itemsQuantityPay, other.name));
  }

  void _increaseItemAtIndexWant(int index) {
    setState(() {
      itemsQuantityWant[index]++;
    });
  }

  void _decreaseItemAtIndexWant(int index) {
    if (itemsQuantityWant[index] <= 0) return;
    setState(() {
      itemsQuantityWant[index]--;
    });
  }

  void _increaseItemAtIndexPay(int index) {
    setState(() {
      itemsQuantityPay[index]++;
    });
  }

  void _decreaseItemAtIndexPay(int index) {
    if (itemsQuantityPay[index] <= 0) return;
    setState(() {
      itemsQuantityPay[index]--;
    });
  }

  void _setItemsQuantityStorage(int quantity) {
    itemsQuantityWant = [];
    for (int i = 0; i < quantity; i++) {
      itemsQuantityWant.add(0);
    }

    itemsQuantityPay = [];
    for (int i = 0; i < quantity; i++) {
      itemsQuantityPay.add(0);
    }
  }

  Widget _getBodyTrade(List<ItemEntity> items) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Trade with ${other.name}",
              style: Theme.of(context).textTheme.headline5,
            ),
            Divider(),
            Text(
              "What do you want",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: ItemCounter(
                    name: items[index].name,
                    add: () => _increaseItemAtIndexWant(index),
                    remove: () => _decreaseItemAtIndexWant(index),
                    count: itemsQuantityWant[index],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
            Text(
              "What you will pay for",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: ItemCounter(
                    name: items[index].name,
                    add: () => _increaseItemAtIndexPay(index),
                    remove: () => _decreaseItemAtIndexPay(index),
                    count: itemsQuantityWant[index],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
            Center(
              child: Container(
                height: 50,
                width: double.infinity,
                child: TextButton(
                  onPressed: submit,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        side: BorderSide(color: style.darkGrey!, width: 2),
                      ),
                    ),
                  ),
                  child: Text("Confirm",
                      style: Theme.of(context).textTheme.headline6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBody() {
    return BlocConsumer<TradeBloc, TradeState>(
      listener: (context, state) {
        if (state is TradeLoadedState)
          _setItemsQuantityStorage(state.items.length);
      },
      builder: (context, state) {
        if (state is TradeCriticalFail) return FailScreen();
        if (state is TradeLoadedState) return _getBodyTrade(state.items);
        return LoadingScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: _getBody(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    other = widget.arguments.user;
    bloc.add(TradeRequestItemsEvent());
  }
}

class ParamsTradeItemPage {
  final UserEntity user;

  ParamsTradeItemPage(this.user);
}
