import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class EmployeeModel {
  int? id;
  String? name;
  bool? isSeller;

  EmployeeModel({this.id, this.name, this.isSeller});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeToJson(this);

  @override
  String toString() => name!;
}

EmployeeModel _$EmployeeFromJson(Map<String, dynamic> json) {
  return EmployeeModel(
    id: json['id'] as int,
    name: json['name'] as String,
    isSeller: json['isSeller'] as bool,
  );
}

Map<String, dynamic> _$EmployeeToJson(EmployeeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isSeller': instance.isSeller,
    };
