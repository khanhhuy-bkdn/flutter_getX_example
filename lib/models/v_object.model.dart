import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class VObjectModel {
  int? objectId;
  String? objectType;
  String? objectAccessKey;
  String? objectNo;
  String? objectName;
  String? contactPhone;
  String? contactAddress;

  VObjectModel(
      {this.objectId,
      this.objectType,
      this.objectAccessKey,
      this.objectNo,
      this.objectName,
      this.contactPhone,
      this.contactAddress});

  factory VObjectModel.fromJson(Map<String, dynamic> json) =>
      _$VObjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$VObjectModelToJson(this);

  @override
  String toString() => objectName!;
}

VObjectModel _$VObjectModelFromJson(Map<String, dynamic> json) {
  return VObjectModel(
    objectId: json['objectId'] as int,
    objectType: json['objectType'] as String,
    objectAccessKey: json['objectAccessKey'] as String,
    objectNo: json['objectNo'] as String,
    objectName: json['objectName'] as String,
    contactPhone: json['contactPhone'] as String,
    contactAddress: json['contactAddress'] as String,
  );
}

Map<String, dynamic> _$VObjectModelToJson(VObjectModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'objectType': instance.objectType,
      'objectAccessKey': instance.objectAccessKey,
      'objectNo': instance.objectNo,
      'objectName': instance.objectName,
      'contactPhone': instance.contactPhone,
      'contactAddress': instance.contactAddress
    };
