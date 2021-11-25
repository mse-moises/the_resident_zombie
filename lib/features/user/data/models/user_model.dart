import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required String name, required int age, required String gender})
      : super(name:name, age:age, gender:gender);
}
