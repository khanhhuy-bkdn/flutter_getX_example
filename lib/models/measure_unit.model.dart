import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MeasureUnitModel {
  int? id;
  String? no;
  String? name;

  MeasureUnitModel({this.id, this.no, this.name});

  factory MeasureUnitModel.fromJson(Map<String, dynamic> json) =>
      _$MeasureUnitModelFromJson(json);

  Map<String, dynamic> toJson() => _$MeasureUnitModelToJson(this);
}

MeasureUnitModel _$MeasureUnitModelFromJson(Map<String, dynamic> json) {
  return MeasureUnitModel(
    id: json['id'] as int?,
    no: json['no'] as String?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$MeasureUnitModelToJson(MeasureUnitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'no': instance.no,
      'name': instance.name,
    };
