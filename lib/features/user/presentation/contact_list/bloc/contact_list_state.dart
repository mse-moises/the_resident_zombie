part of 'contact_list_bloc.dart';

abstract class ContactListState extends Equatable {
  const ContactListState();

  @override
  List<Object> get props => [];
}

class ContactListLoadingState extends ContactListState {}

class ContactListLoaded extends ContactListState {
  final List<UserEntity> users;

  ContactListLoaded(this.users);
}

class ContactListFail extends ContactListState {}
class ContactFlagSuccess extends ContactListLoaded {
  ContactFlagSuccess(List<UserEntity> users) : super(users);
}

class ContactFlagFail extends ContactListLoaded {
  ContactFlagFail(List<UserEntity> users) : super(users);
}
