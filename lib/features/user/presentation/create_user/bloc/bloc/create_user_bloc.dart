import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/features/items/domain/entities/item_entity.dart';
import 'package:the_resident_zombie/features/items/domain/usecase/get_items_type_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/create_user_usecase.dart';

part 'create_user_event.dart';
part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  final GetItemsTypeUseCase getItems;
  final CreateUserUsecase createUser;

  late List<ItemEntity> loadedItems;

  CreateUserBloc({required this.getItems, required this.createUser})
      : super(CreateUserLoadingState()) {
    on<CreateUserEvent>((event, emit) async {
      if (event is CreateUserRequestItemsEvent) {
        final result = await getItems(GetItemsTypeNoParams());
        result.fold(
          (l) => emit(CreateCriticalFailState()),
          (r) {
            loadedItems = r;
            emit(CreateUserEditState(r));
          },
        );
      }

      if (event is CreateUserSubmitEvent) {
        emit(CreateUserLoadingState());
        final params = CreateUserParams(
            age: event.age,
            gender: event.gender,
            itemQuantity: event.items,
            name: event.name);
        final result = await createUser(params);
        result.fold(
          (l) => emit(CreateUserFailState(loadedItems)),
          (r) => emit(CreateUserSuccessState()),
        );
      }
    });
  }
}
