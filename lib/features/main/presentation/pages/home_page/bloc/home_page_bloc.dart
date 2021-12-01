import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';

import 'package:the_resident_zombie/features/user/domain/usecases/get_local_user_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/update_user_location_usecase.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GetLocalUserUseCase getUser;
  final UpdateUserLocationUsecase updateUserLocation;
  HomePageBloc({required this.updateUserLocation, required this.getUser})
      : super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) async {
      if (event is HomeUpdateLocationEvent) {
        final resultUser = await getUser(GetLocalUserNoParams());

        late UserEntity user;

        resultUser.fold(
          (l) => () {},
          (r) => user = r,
        );
        if (resultUser.isLeft()) {
          emit(HomeFailUpdateLocation());
          return;
        }

        final result =
            await updateUserLocation(ParamsUpdateLocation(identifier: user.id));

        result.fold(
          (l) => emit(HomeFailUpdateLocation()),
          (r) => emit(HomeSuccessUpdateLocation()),
        );
      }
    });
  }
}
