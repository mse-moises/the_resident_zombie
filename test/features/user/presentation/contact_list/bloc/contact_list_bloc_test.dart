import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/get_all_contacts_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/save_contact_usecase.dart';
import 'package:the_resident_zombie/features/user/presentation/contact_list/bloc/contact_list_bloc.dart';

import 'contact_list_bloc_test.mocks.dart';

@GenerateMocks([SaveContactUsecase])
@GenerateMocks([GetAllContactsUsecase])
void main() {
  late MockGetAllContactsUsecase getContact;
  late MockSaveContactUsecase saveContact;

  late ContactListBloc bloc;

  setUp(() {
    getContact = MockGetAllContactsUsecase();
    saveContact = MockSaveContactUsecase();
    bloc = ContactListBloc(getContacts: getContact, saveContact: saveContact);
  });

  group(
    'ContactListBloc:',
    () {
      List<UserEntity> tUsers = [
        UserEntity(name: "name", age: 0, gender: "gender", id: "id", infected:false),
        UserEntity(name: "name", age: 0, gender: "gender", id: "id", infected:false),
      ];
      test(
        'inital state is [CreateUserLoadingState]',
        () async {
          // assert
          expect(bloc.state, ContactListLoadingState());
        },
      );

      blocTest<ContactListBloc, ContactListState>(
        'emit [ContactListLoaded] when the contacts are loaded',
        build: () {
          when(getContact(any)).thenAnswer((_) async => Right(tUsers));
          return bloc;
        },
        act: (bloc) => bloc.add(RequestContactsEvent()),
        expect: () => [
          ContactListLoaded(tUsers),
        ],
      );

      blocTest<ContactListBloc, ContactListState>(
        'emit [ContactListLoaded] when the contacts local request for ids failed',
        build: () {
          when(getContact(any)).thenAnswer((_) async => Left(DeviceFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(RequestContactsEvent()),
        expect: () => [
          ContactListFail(),
        ],
      );

      blocTest<ContactListBloc, ContactListState>(
        'emit [ContactListLoaded] when the contacts local remote requets for users failed',
        build: () {
          when(getContact(any)).thenAnswer((_) async => Left(ServerFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(RequestContactsEvent()),
        expect: () => [
          ContactListFail(),
        ],
      );

      blocTest<ContactListBloc, ContactListState>(
        'emit [ContactListFail] when add contacts failed at save',
        build: () {
          when(saveContact(any)).thenAnswer((_) async => Left(CacheFailure()));
          when(saveContact(any)).thenAnswer((_) async => Left(CacheFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(AddContactsEvent('test')),
        expect: () => [
          ContactListLoadingState(),
          ContactListFail(),
        ],
      );

      blocTest<ContactListBloc, ContactListState>(
        'emit [ContactListFail] when add contacts was successful but the request to the server failed',
        build: () {
          when(getContact(any)).thenAnswer((_) async => Left(ServerFailure()));
          when(saveContact(any)).thenAnswer(
              (_) async => Right("21cb70ac-4783-4bdf-8a03-575661d06bfd"));
          return bloc;
        },
        act: (bloc) => bloc.add(AddContactsEvent('test')),
        expect: () => [
          ContactListLoadingState(),
          ContactListFail(),
        ],
      );

      blocTest<ContactListBloc, ContactListState>(
        'emit [ContactListLoaded] when add contacts was successful but the request to the server failed',
        build: () {
          when(getContact(any)).thenAnswer((_) async => Right(tUsers));
          when(saveContact(any)).thenAnswer(
              (_) async => Right("21cb70ac-4783-4bdf-8a03-575661d06bfd"));
          return bloc;
        },
        act: (bloc) => bloc.add(AddContactsEvent('test')),
        expect: () => [
          ContactListLoadingState(),
          ContactListLoaded(tUsers),
        ],
      );
    },
  );
}
