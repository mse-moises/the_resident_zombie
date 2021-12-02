import 'package:flutter/material.dart';
import 'package:the_resident_zombie/core/utils/style.dart' as style;
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';

class ContactTile extends StatelessWidget {
  ContactTile({
    Key? key,
    required this.user,
    required this.functionOne,
    required this.functionTwo,
  }) : super(key: key);
  final UserEntity user;

  final Function() functionOne;
  final Function() functionTwo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: user.infected
          ? Text("infected",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: style.lighterRed))
          : Container(),
      trailing: PopupMenuButton(
        enabled: !user.infected,
        onSelected: (int result) {
          switch (result) {
            case 1:
              functionOne();
              break;
            case 2:
              functionTwo();
              break;
          }
        },
        icon: Icon(Icons.more_vert),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text("Flag as infected"),
            value: 1,
          ),
          PopupMenuItem(
            child: Text("Trade itens"),
            value: 2,
          ),
        ],
      ),
      /*trailing: user.infected
          ? PopupMenuButton(
              icon: Icon(Icons.more_horiz),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("Flag as infected"),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text("Trade itens"),
                  value: 2,
                ),
              ],
            )
          : Container(),*/
    );
  }
}
