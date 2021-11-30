part of 'splash_page_bloc.dart';

abstract class SplashPageEvent extends Equatable {
  const SplashPageEvent();

  @override
  List<Object> get props => [];
}

class SearchLocalUserEvent extends SplashPageEvent{}
