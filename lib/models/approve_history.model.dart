import 'package:flutter_demo_getx/models/dictionary_item.dart';
import 'package:flutter_demo_getx/models/employee/employee_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ApproveHistoryModel {
  int? id;
  DictionaryItem? action;
  String? messages;
  EmployeeModel? employee;
  DateTime? approvalDate;

  ApproveHistoryModel(
      {this.id, this.action, this.messages, this.employee, this.approvalDate});

  factory ApproveHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$ApproveHistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApproveHistoryModelToJson(this);
}

ApproveHistoryModel _$ApproveHistoryModelFromJson(Map<String, dynamic> json) {
  return ApproveHistoryModel(
    id: json['id'] as int,
    action: json['action'] == null
        ? null
        : DictionaryItem.fromJson(json['action'] as Map<String, dynamic>),
    messages: json['messages'] as String,
    employee: json['employee'] == null
        ? null
        : EmployeeModel.fromJson(json['employee'] as Map<String, dynamic>),
    approvalDate: json['approvalDate'] == null
        ? null
        : new DateTime.fromMillisecondsSinceEpoch(
            (json['approvalDate'] as int) * 1000),
  );
}

Map<String, dynamic> _$ApproveHistoryModelToJson(
        ApproveHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': instance.action,
      'messages': instance.messages,
      'employee': instance.employee,
      'approvalDate': instance.approvalDate?.toIso8601String(),
    };
