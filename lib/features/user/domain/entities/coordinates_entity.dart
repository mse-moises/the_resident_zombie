import 'package:equatable/equatable.dart';

class Cordinated extends Equatable {
  final double x;
  final double y;

  Cordinated({required this.x, required this.y});
  
  @override
  List<Object> get props => [x,y];
}