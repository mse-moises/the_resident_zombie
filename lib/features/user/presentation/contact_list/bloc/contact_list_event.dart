part of 'contact_list_bloc.dart';

abstract class ContactListEvent extends Equatable {
  const ContactListEvent();

  @override
  List<Object> get props => [];
}

class RequestContactsEvent extends ContactListEvent{}
class AddContactsEvent extends ContactListEvent{
  final String id;

  AddContactsEvent(this.id);
}
