part of 'create_user_bloc.dart';

abstract class CreateUserEvent extends Equatable {
  const CreateUserEvent();

  @override
  List<Object> get props => [];
}

class CreateUserRequestItemsEvent extends CreateUserEvent {}

class CreateUserSubmitEvent extends CreateUserEvent {
  final String name;
  final String gender;
  final int age;
  final List<int> items;

  CreateUserSubmitEvent({
    required this.name,
    required this.gender,
    required this.age,
    required this.items,
  });
}
