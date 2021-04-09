import 'package:flutter_demo_getx/models/measure_unit.model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProductModel {
  int? id;
  String? no;
  String? name;
  String? desc;
  MeasureUnitModel? measureUnit;

  ProductModel(this.id, this.no, this.name, this.desc, this.measureUnit);

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    json['id'] as int,
    json['no'] as String,
    json['name'] as String,
    json['desc'] as String,
    json['measureUnit'] == null
        ? null
        : MeasureUnitModel.fromJson(
            json['measureUnit'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'no': instance.no,
      'name': instance.name,
      'desc': instance.desc,
      'measureUnit': instance.measureUnit,
    };
