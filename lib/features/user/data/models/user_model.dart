import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required String name, required int age, required String gender, required String id})
      : super(name:name, age:age, gender:gender, id: id);

  factory UserModel.fromJson(Map<String,dynamic> json){
    final name = json['name'];
    final age = json['age'];
    final gender = json['gender'];
    final id = json['id'];
    return UserModel(
      id:id,
      name:name,
      age:age,
      gender:gender,
    );
  }

  Map<String,dynamic> toJson(){
    return{
      "name":"$name",
      "age":age,
      "gender":"$gender"
    };
  }


}
