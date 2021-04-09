import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class DepartmentModel {
  int id;
  String no;
  String name;

  DepartmentModel(
    this.id,
    this.no,
    this.name
  );

  factory DepartmentModel.fromJson(Map<String, dynamic> json) => _$DepartmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentModelToJson(this);
}

DepartmentModel _$DepartmentModelFromJson(Map<String, dynamic> json) {
  return DepartmentModel(
    json['id'] as int,
    json['no'] as String,
    json['name'] as String
  );
}

Map<String, dynamic> _$DepartmentModelToJson(DepartmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'no': instance.no,
      'name': instance.name
    };