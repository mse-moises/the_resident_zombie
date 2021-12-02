part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class HomePageInfected extends HomePageState {}

class HomeFailUpdateLocation extends HomePageInitial {
  UserEntity? user;
  HomeFailUpdateLocation({
    this.user,
  });
}

class HomeSuccessUpdateLocation extends HomePageInitial {
  UserEntity user;
  HomeSuccessUpdateLocation(
    this.user,
  );
}
