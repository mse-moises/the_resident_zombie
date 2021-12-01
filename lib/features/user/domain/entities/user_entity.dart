import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final int age;
  final String gender;

  UserEntity({required this.name, required this.age, required this.gender, required this.id});

  @override
  List<Object> get props => [name, age, gender,id];
}
