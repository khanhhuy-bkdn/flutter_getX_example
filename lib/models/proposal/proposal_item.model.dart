import 'package:flutter_demo_getx/models/measure_unit.model.dart';
import 'package:flutter_demo_getx/models/product.model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProposalItemModel {
  int? id;
  DateTime? neededFromDate;
  DateTime? neededToDate;
  String? comment;
  double? quantity;
  double? factor;
  double? exchangeQty;
  ProductModel? product;
  MeasureUnitModel? measureUnit;

  ProposalItemModel(
      {this.id,
      this.neededFromDate,
      this.neededToDate,
      this.comment,
      this.quantity,
      this.factor,
      this.exchangeQty,
      this.product,
      this.measureUnit});

  factory ProposalItemModel.fromJson(Map<String, dynamic> json) =>
      _$ProposalItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProposalItemModelToJson(this);
}

ProposalItemModel _$ProposalItemModelFromJson(Map<String, dynamic> json) {
  return ProposalItemModel(
    id: json['id'] as int,
    neededFromDate: json['neededFromDate'] == null
        ? null
        : new DateTime.fromMillisecondsSinceEpoch(
            (json['neededFromDate'] as int) * 1000),
    neededToDate: json['neededToDate'] == null
        ? null
        : new DateTime.fromMillisecondsSinceEpoch(
            (json['neededToDate'] as int) * 1000),
    comment: json['comment'] as String,
    quantity: json['quantity'] as double,
    factor: json['factor'] as double,
    exchangeQty: json['exchangeQty'] as double,
    product: json['product'] == null
        ? null
        : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
    measureUnit: json['measureUnit'] == null
        ? null
        : MeasureUnitModel.fromJson(
            json['measureUnit'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProposalItemModelToJson(ProposalItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'neededFromDate': instance.neededFromDate?.toIso8601String(),
      'neededToDate': instance.neededToDate?.toIso8601String(),
      'comment': instance.comment,
      'quantity': instance.quantity,
      'factor': instance.factor,
      'exchangeQty': instance.exchangeQty,
      'product': instance.product,
      'measureUnit': instance.measureUnit,
    };
