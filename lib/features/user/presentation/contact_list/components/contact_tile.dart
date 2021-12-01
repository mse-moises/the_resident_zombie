import 'package:flutter/material.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';

class ContactTile extends StatelessWidget {
  ContactTile({Key? key, required this.user}) : super(key: key);
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
