import 'package:flutter/material.dart';

class ItemCounter extends StatelessWidget {
  const ItemCounter(
      {Key? key,
      required this.name,
      required this.count,
      required this.add,
      required this.remove})
      : super(key: key);

  final String name;
  final int count;
  final Function() add;
  final Function() remove;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
              child:
                  Text("$count", style: Theme.of(context).textTheme.headline6)),
          Spacer(),
          Container(
              child: Text(name, style: Theme.of(context).textTheme.headline6)),
          Spacer(),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: add,
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  onPressed: remove,
                  icon: Icon(Icons.remove),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
