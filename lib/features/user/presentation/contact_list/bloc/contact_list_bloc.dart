import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/get_all_contacts_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/save_contact_usecase.dart';
import 'package:the_resident_zombie/features/user/presentation/contact_list/pages/contact_list_page.dart';

part 'contact_list_event.dart';
part 'contact_list_state.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  final GetAllContactsUsecase getContacts;
  final SaveContactUsecase saveContact;

  ContactListBloc({required this.getContacts, required this.saveContact}) : super(ContactListLoadingState()) {
    on<ContactListEvent>((event, emit) async {
      if(event is RequestContactsEvent){
        final result = await getContacts(GetAllContactsParams());
        result.fold((l) => emit(ContactListFail()), (r) => emit(ContactListLoaded(r)));
      }
      if(event is AddContactsEvent){
        emit(ContactListLoadingState());
        final result = await saveContact(ParamsSaveContact(identifier: event.id));
        result.fold((l) => emit(ContactListFail()), (r) => null);
        if(result.isLeft()) return;
        add(RequestContactsEvent());
      }
    });
  }
}
