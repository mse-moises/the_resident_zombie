import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required String name, required int age, required String gender})
      : super(name:name, age:age, gender:gender);

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      name:json['name'],
      age:json['age'],
      gender:json['gender'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'name':name,
      'age':age,
      'gender':gender
    };
  }


}
