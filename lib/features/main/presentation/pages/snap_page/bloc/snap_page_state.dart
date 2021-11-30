part of 'snap_page_bloc.dart';

abstract class SnapPageState extends Equatable {
  const SnapPageState();
  
  @override
  List<Object> get props => [];
}

class SnapPageInitial extends SnapPageState {}
class SnapPageUserFound extends SnapPageInitial {}
class SnapPageUserNotFound extends SnapPageInitial {}
