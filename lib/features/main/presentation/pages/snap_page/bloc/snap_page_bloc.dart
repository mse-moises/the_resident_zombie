import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/get_local_user_usecase.dart';

part 'snap_page_event.dart';
part 'snap_page_state.dart';

class SnapPageBloc extends Bloc<SnapPageEvent, SnapPageState> {
  final GetLocalUserUseCase getLocalUser;
  SnapPageBloc({required this.getLocalUser}) : super(SnapPageInitial()) {
    on<SnapPageEvent>(
      (event, emit) async {
        if (event is SearchLocalUserEvent) {
          final result = await getLocalUser(GetLocalUserNoParams());
          result.fold(
            (l) => emit(SnapPageUserNotFound()),
            (r) => emit(SnapPageUserFound()),
          );
        }
      },
    );
  }
}
