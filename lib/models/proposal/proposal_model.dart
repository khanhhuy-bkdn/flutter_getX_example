import 'package:flutter_demo_getx/models/dictionary_item.dart';
import 'package:flutter_demo_getx/models/employee/employee_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProposalModel {
  int? id;
  String? no;
  String? name;
  DateTime? date;
  DictionaryItem? type;
  DictionaryItem? commodityType;
  DictionaryItem? status;
  EmployeeModel? createdEmployee;
  DictionaryItem? approveStatus;

  ProposalModel(
      {this.id,
      this.no,
      this.name,
      this.date,
      this.type,
      this.commodityType,
      this.status,
      this.createdEmployee,
      this.approveStatus});

  factory ProposalModel.fromJson(Map<String, dynamic> json) =>
      _$ProposalFromJson(json);
  Map<String, dynamic> toJson() => _$ProposalToJson(this);
}

ProposalModel _$ProposalFromJson(Map<String, dynamic> json) {
  return ProposalModel(
    id: json['id'] as int?,
    no: json['no'] as String?,
    name: json['name'] as String?,
    date: json['date'] == null
        ? null
        : new DateTime.fromMillisecondsSinceEpoch((json['date'] as int) * 1000),
    type: json['type'] == null
        ? null
        : DictionaryItem.fromJson(json['type'] as Map<String, dynamic>),
    commodityType: json['commodityType'] == null
        ? null
        : DictionaryItem.fromJson(
            json['commodityType'] as Map<String, dynamic>),
    status: json['status'] == null
        ? null
        : DictionaryItem.fromJson(json['status'] as Map<String, dynamic>),
    createdEmployee: json['createdEmployee'] == null
        ? null
        : EmployeeModel.fromJson(
            json['createdEmployee'] as Map<String, dynamic>),
    approveStatus: json['approveStatus'] == null
        ? null
        : DictionaryItem.fromJson(
            json['approveStatus'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProposalToJson(ProposalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'no': instance.no,
      'name': instance.name,
      'date': instance.date?.toIso8601String(),
      'type': instance.type,
      'commodityType': instance.commodityType,
      'status': instance.status,
      'createdEmployee': instance.createdEmployee,
      'approveStatus': instance.approveStatus,
    };
