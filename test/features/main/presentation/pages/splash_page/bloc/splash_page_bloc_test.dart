import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/features/main/presentation/pages/splash_page/bloc/splash_page_bloc.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/get_local_user_usecase.dart';

import 'splash_page_bloc_test.mocks.dart';

@GenerateMocks([GetLocalUserUseCase])
void main() {
  late MockGetLocalUserUseCase getLocalUserUsecase;
  late SplashPageBloc bloc;

  setUp(() {
    getLocalUserUsecase = MockGetLocalUserUseCase();
    bloc = SplashPageBloc(getLocalUser: getLocalUserUsecase);
  });

  group(
    'SplashPageBloc:',
    () {
      final tUserEntity = UserEntity(age: 30, gender: 't', name: 'test', id: 'test', infected:false);
      test(
        'intial state is [SplashPageInitial]',
        () async {
          // assert
          expect(bloc.state, equals(SplashPageInitial()));
        },
      );

      blocTest<SplashPageBloc,SplashPageState>(
        'emit [SplashPageUserFound] if found',
        build: () {
          when(getLocalUserUsecase(any))
              .thenAnswer((_) async => Right(tUserEntity));
          return bloc;
        },
        act: (bloc) => bloc.add(SearchLocalUserEvent()),
        expect: () => [
          SplashPageUserFound(),
        ],
      );

      blocTest<SplashPageBloc,SplashPageState>(
        'emit [SplashPageUserNotFound] if not found',
        build: () {
          when(getLocalUserUsecase(any))
              .thenAnswer((_) async => Left(DeviceFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(SearchLocalUserEvent()),
        expect: () => [
          SplashPageUserNotFound(),
        ],
      );
    },
  );
}
