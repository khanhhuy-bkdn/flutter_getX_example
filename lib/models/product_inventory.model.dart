import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProductInventoryModel {
  num? onHandQty;
  num? saleOrderQty;
  num? purchaseOrderQty;
  num? transitInQty;
  num? transitOutQty;
  num? allocationPlan;
  num? availableQty;

  ProductInventoryModel(
      {this.onHandQty,
      this.saleOrderQty,
      this.purchaseOrderQty,
      this.transitInQty,
      this.transitOutQty,
      this.allocationPlan,
      this.availableQty});

  factory ProductInventoryModel.fromJson(Map<String, dynamic> json) =>
      _$ProductInventoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductInventoryModelToJson(this);
}

ProductInventoryModel _$ProductInventoryModelFromJson(
    Map<String, dynamic> json) {
  return ProductInventoryModel(
      onHandQty: json['onHandQty'] as num,
      saleOrderQty: json['saleOrderQty'] as num,
      purchaseOrderQty: json['purchaseOrderQty'] as num,
      transitInQty: json['transitInQty'] as num,
      transitOutQty: json['transitOutQty'] as num,
      allocationPlan: json['allocationPlan'] as num,
      availableQty: json['availableQty'] as num);
}

Map<String, dynamic> _$ProductInventoryModelToJson(
        ProductInventoryModel instance) =>
    <String, dynamic>{
      'onHandQty': instance.onHandQty,
      'saleOrderQty': instance.saleOrderQty,
      'purchaseOrderQty': instance.purchaseOrderQty,
      'transitInQty': instance.transitInQty,
      'transitOutQty': instance.transitOutQty,
      'allocationPlan': instance.allocationPlan,
      'availableQty': instance.availableQty
    };
