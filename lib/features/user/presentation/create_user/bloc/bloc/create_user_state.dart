part of 'create_user_bloc.dart';

abstract class CreateUserState extends Equatable {
  const CreateUserState();

  @override
  List<Object> get props => [];
}

class CreateUserLoadingState extends CreateUserState {} //initial state

class CreateUserEditState extends CreateUserState {
  List<ItemEntity> items;
  CreateUserEditState(this.items);
}

class CreateUserFailState extends CreateUserEditState {
  CreateUserFailState(List<ItemEntity> items) : super(items);
} // is a EditState too


class CreateCriticalFailState extends CreateUserState {}

class CreateUserSuccessState extends CreateUserLoadingState {}
