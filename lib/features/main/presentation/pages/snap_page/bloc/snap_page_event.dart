part of 'snap_page_bloc.dart';

abstract class SnapPageEvent extends Equatable {
  const SnapPageEvent();

  @override
  List<Object> get props => [];
}

class SearchLocalUserEvent extends SnapPageEvent{}
