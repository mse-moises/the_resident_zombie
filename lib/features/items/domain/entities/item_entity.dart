import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable{
  final String name;
  final int value;

  ItemEntity({required this.name, required this.value});

  @override
  List<Object> get props => [name,value];

  ItemEntity clone(){
    return ItemEntity(name:name, value:value);
  }
}