import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_items_type_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/create_user_usecase.dart';
import 'package:the_resident_zombie/features/user/presentation/create_user/bloc/bloc/create_user_bloc.dart';

import 'create_user_bloc_test.mocks.dart';

@GenerateMocks([GetItemsTypeUseCase])
@GenerateMocks([CreateUserUsecase])
void main() {
  late MockGetItemsTypeUseCase getItems;
  late MockCreateUserUsecase createUser;
  late CreateUserBloc bloc;

  setUp(() {
    getItems = MockGetItemsTypeUseCase();
    createUser = MockCreateUserUsecase();
    bloc = CreateUserBloc(createUser: createUser, getItems: getItems);
  });

  group(
    'CreateUserBloc:',
    () {
      test(
        'inital state is [CreateUserLoadingState]',
        () async {
          // assert
          expect(bloc.state, CreateUserLoadingState());
        },
      );

      final tItems = [
        ItemEntity(name: 'test', value: 0),
        ItemEntity(name: 'test', value: 0)
      ];

      blocTest<CreateUserBloc, CreateUserState>(
        'emit [CreateUserEditState] when items is requested',
        build: () {
          when(getItems(any)).thenAnswer((_) async => Right(tItems));
          return bloc;
        },
        act: (bloc) => bloc.add(CreateUserRequestItemsEvent()),
        expect: () => [
          CreateUserEditState(tItems),
        ],
      );

      blocTest<CreateUserBloc, CreateUserState>(
        'emit [CreateCriticalFailState] when the items is requested failed',
        build: () {
          when(getItems(any)).thenAnswer((_) async => Left(CacheFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(CreateUserRequestItemsEvent()),
        expect: () => [
          CreateCriticalFailState(),
        ],
      );

      final tName = "test";
      final tGender = "t";
      final tAge = 30;
      final tItemsQuantity = <int>[0, 0, 0];

      blocTest<CreateUserBloc, CreateUserState>(
        'emit [CreateUserFailState] when submit failed',
        build: () {
          when(getItems(any)).thenAnswer((_) async => Right(tItems));
          when(createUser(any)).thenAnswer((_) async => Left(ServerFailure()));
          return bloc;
        },
        act: (bloc) {
          bloc.add(CreateUserRequestItemsEvent());
          bloc.add(CreateUserSubmitEvent(
              age: tAge, gender: tGender, items: tItemsQuantity, name: tName));
        },
        expect: () => [
          CreateUserEditState(tItems),
          CreateUserLoadingState(),
          CreateUserFailState(tItems),
        ],
      );

      final tUser = UserEntity(id:'test',name: tName, age: tAge, gender: tGender, infected:false);

      blocTest<CreateUserBloc, CreateUserState>(
        'emit [CreateUserSuccessState] when submit was successful',
        build: () {
          when(getItems(any)).thenAnswer((_) async => Right(tItems));
          when(createUser(any)).thenAnswer((_) async => Right(tUser));
          return bloc;
        },
        act: (bloc) {
          bloc.add(CreateUserRequestItemsEvent());
          bloc.add(CreateUserSubmitEvent(
              age: tAge, gender: tGender, items: tItemsQuantity, name: tName));
        },
        expect: () => [
          CreateUserEditState(tItems),
          CreateUserLoadingState(),
          CreateUserSuccessState(),
        ],
      );
    },
  );
}
