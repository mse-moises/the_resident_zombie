import 'package:equatable/equatable.dart';
import 'package:the_resident_zombie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:the_resident_zombie/core/params/confirmation.dart';
import 'package:the_resident_zombie/core/usecases/usecase.dart';
import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';

const double LOCATION_TOLERANCE_TRADE = 0.005; //~500 meters

class CompareLocationUseCase
    implements UseCase<Confirmation, CompareLocationsParams> {
  @override
  Future<Either<Failure, Confirmation>> call(params) async {
    final latitudeDiference = ((params.firstLocation.latitude - params.secondLocation.latitude) as num).abs();
    final longitudeDiference = ((params.firstLocation.longitude - params.secondLocation.longitude) as num).abs();

    
    if(latitudeDiference <= LOCATION_TOLERANCE_TRADE && longitudeDiference <= LOCATION_TOLERANCE_TRADE){
      return Right(Confirmation());
    }

    return Left(LocationTradeFailure());

  }
}

class CompareLocationsParams extends Equatable {
  final LocationEntity firstLocation;
  final LocationEntity secondLocation;
  CompareLocationsParams(this.firstLocation, this.secondLocation);
  @override
  List<Object> get props => [firstLocation, secondLocation];
}
