import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/get_all_contacts_usecase.dart';
import 'package:the_resident_zombie/features/user/presentation/contact_list/bloc/contact_list_bloc.dart';

import 'contact_list_bloc_test.mocks.dart';

@GenerateMocks([GetAllContactsUsecase])
void main() {
  late MockGetAllContactsUsecase getContact;

  late ContactListBloc bloc;

  setUp(() {
    getContact = MockGetAllContactsUsecase();
    bloc = ContactListBloc(getContacts: getContact);
  });

  group(
    'ContactListBloc:',
    () {
      List<UserEntity> tUsers = [
        UserEntity(name: "name", age: 0, gender: "gender", id: "id"),
        UserEntity(name: "name", age: 0, gender: "gender", id: "id"),
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
    },
  );
}