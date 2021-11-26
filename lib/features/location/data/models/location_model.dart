import 'package:the_resident_zombie/features/location/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({required double x, required double y}) : super(x: x, y: y);

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
      x: double.parse(finalListString[0]),
      y: double.parse(finalListString[1]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }

  @override
  String toString(){
    return 'POINT ($x $y)';
  }
}
