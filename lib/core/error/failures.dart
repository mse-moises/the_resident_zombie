import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
    
    @override
    List<Object> get props => [];
}


//General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class DeviceFailure extends Failure {}

class BackPackComparationFailure extends Failure {
  final int difference;

  BackPackComparationFailure(this.difference);
}