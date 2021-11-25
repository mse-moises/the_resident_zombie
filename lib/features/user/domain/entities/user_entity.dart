import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final int age;
  final String gender;

  UserEntity({required this.name, required this.age, required this.gender});

  @override
  List<Object> get props => [name, age, gender];
}
