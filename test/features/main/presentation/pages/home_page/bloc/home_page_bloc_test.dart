import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:the_resident_zombie/core/params/confirmation.dart';
import 'package:the_resident_zombie/features/main/presentation/pages/home_page/bloc/home_page_bloc.dart';
import 'package:the_resident_zombie/features/user/domain/entities/user_entity.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/get_local_user_usecase.dart';
import 'package:the_resident_zombie/features/user/domain/usecases/update_user_location_usecase.dart';

import 'home_page_bloc_test.mocks.dart';

@GenerateMocks([UpdateUserLocationUsecase])
@GenerateMocks([GetLocalUserUseCase])
void main() {
  late MockGetLocalUserUseCase getLocalUserUsecase;
  late MockUpdateUserLocationUsecase updateLocationUseCase;
  late HomePageBloc bloc;

  setUp(() {
    getLocalUserUsecase = MockGetLocalUserUseCase();
    updateLocationUseCase = MockUpdateUserLocationUsecase();
    bloc = HomePageBloc(
        getUser: getLocalUserUsecase,
        updateUserLocation: updateLocationUseCase);
  });

  group('HomePageBloc:', () {
    final tUserEntity =
        UserEntity(age: 30, gender: 't', name: 'test', id: 'test', infected:false);
    test(
      'intial state is [HomePageInitial]',
      () async {
        // assert
        expect(bloc.state, equals(HomePageInitial()));
      },
    );

    blocTest<HomePageBloc, HomePageState>(
      'emit [HomeFailUpdateLocation] if the local user was not found',
      build: () {
        when(getLocalUserUsecase(any))
            .thenAnswer((_) async => Left(DeviceFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(HomeUpdateLocationEvent()),
      expect: () => [
        HomeFailUpdateLocation(),
      ],
    );

    blocTest<HomePageBloc, HomePageState>(
      'emit [HomeFailUpdateLocation] the request to update wasnt successful',
      build: () {
        when(getLocalUserUsecase(any))
            .thenAnswer((_) async => Right(tUserEntity));
        when(updateLocationUseCase(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(HomeUpdateLocationEvent()),
      expect: () => [
        HomeFailUpdateLocation(),
      ],
    );

    blocTest<HomePageBloc, HomePageState>(
      'emit [HomeSuccessUpdateLocation] the request to update was successful',
      build: () {
        when(getLocalUserUsecase(any))
            .thenAnswer((_) async => Right(tUserEntity));
        when(updateLocationUseCase(any))
            .thenAnswer((_) async => Right(tUserEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(HomeUpdateLocationEvent()),
      expect: () => [
        HomeSuccessUpdateLocation(),
      ],
    );
  });
}
