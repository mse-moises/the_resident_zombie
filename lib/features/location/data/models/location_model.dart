import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({required double latitude, required double longitude}) : super(latitude: latitude, longitude: longitude);

  factory LocationModel.fromJson(Map<String, dynamic> json) {

    
    return LocationModel.fromString(json['lonlat']);
  }
  factory LocationModel.fromString(String string) {
    List<String> stringSplited =  string.split(' ');
    stringSplited.removeAt(0);

    String auxString = "";
    for(String stringSplit in stringSplited) {
      stringSplit = stringSplit.replaceAll('(','');
      stringSplit = stringSplit.replaceAll(')','');

      auxString+='$stringSplit ';
    }

    var finalListString =  auxString.split(' ');


    return LocationModel(
      latitude: double.parse(finalListString[0]),
      longitude: double.parse(finalListString[1]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': latitude,
      'y': longitude,
    };
  }

  @override
  String toString(){
    return 'POINT ($latitude $longitude)';
  }
}
