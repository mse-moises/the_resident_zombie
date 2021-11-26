import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final double x;
  final double y;

  Location({required this.x, required this.y});
  
  @override
  List<Object> get props => [x,y];
}