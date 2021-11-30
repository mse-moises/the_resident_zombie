import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/get_local_user_usecase.dart';

part 'splash_page_event.dart';
part 'splash_page_state.dart';

class SplashPageBloc extends Bloc<SplashPageEvent, SplashPageState> {
  final GetLocalUserUseCase getLocalUser;
  SplashPageBloc({required this.getLocalUser}) : super(SplashPageInitial()) {
    on<SplashPageEvent>(
      (event, emit) async {
        if (event is SearchLocalUserEvent) {
          final result = await getLocalUser(GetLocalUserNoParams());
          result.fold(
            (l) => emit(SplashPageUserNotFound()),
            (r) => emit(SplashPageUserFound()),
          );
        }
      },
    );
  }
}
