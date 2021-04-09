import 'package:flutter_demo_getx/models/branch.model.dart';
import 'package:flutter_demo_getx/models/department.model.dart';
import 'package:flutter_demo_getx/models/dictionary_item.dart';
import 'package:flutter_demo_getx/models/employee/employee_model.dart';
import 'package:flutter_demo_getx/models/proposal/proposal_item.model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProposalInfoModel {
  int? id;
  String? no;
  DateTime? date;
  DateTime? neededFromDate;
  DateTime? neededToDate;
  BranchModel? branch;
  EmployeeModel? createdEmployee;
  EmployeeModel? proposedEmployee;
  DictionaryItem? commodityType;
  DictionaryItem? type;
  DepartmentModel? department;
  DepartmentModel? departmentRoom;
  String? desc;
  DictionaryItem? status;
  DictionaryItem? approveStatus;
  List<ProposalItemModel>? proposalItems;
  bool? isShowApprovalDetail;

  ProposalInfoModel(
      {this.id,
      this.no,
      this.date,
      this.neededFromDate,
      this.neededToDate,
      this.branch,
      this.createdEmployee,
      this.proposedEmployee,
      this.commodityType,
      this.type,
      this.department,
      this.departmentRoom,
      this.desc,
      this.status,
      this.approveStatus,
      this.proposalItems,
      this.isShowApprovalDetail});

  factory ProposalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ProposalInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProposalInfoModelToJson(this);
}

ProposalInfoModel _$ProposalInfoModelFromJson(Map<String, dynamic> json) {
  return ProposalInfoModel(
      id: json['id'] as int,
      no: json['no'] as String,
      date: json['date'] == null
          ? null
          : new DateTime.fromMillisecondsSinceEpoch(
              (json['date'] as int) * 1000),
      neededFromDate: json['neededFromDate'] == null
          ? null
          : new DateTime.fromMillisecondsSinceEpoch(
              (json['neededFromDate'] as int) * 1000),
      neededToDate: json['neededToDate'] == null
          ? null
          : new DateTime.fromMillisecondsSinceEpoch(
              (json['neededToDate'] as int) * 1000),
      branch: json['branch'] == null
          ? null
          : BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
      createdEmployee: json['createdEmployee'] == null
          ? null
          : EmployeeModel.fromJson(
              json['createdEmployee'] as Map<String, dynamic>),
      proposedEmployee: json['proposedEmployee'] == null
          ? null
          : EmployeeModel.fromJson(
              json['proposedEmployee'] as Map<String, dynamic>),
      commodityType: json['commodityType'] == null
          ? null
          : DictionaryItem.fromJson(
              json['commodityType'] as Map<String, dynamic>),
      type: json['type'] == null
          ? null
          : DictionaryItem.fromJson(json['type'] as Map<String, dynamic>),
      department: json['department'] == null
          ? null
          : DepartmentModel.fromJson(
              json['department'] as Map<String, dynamic>),
      departmentRoom: json['departmentRoom'] == null ? null : DepartmentModel.fromJson(json['departmentRoom'] as Map<String, dynamic>),
      desc: json['desc'] as String,
      status: json['status'] == null ? null : DictionaryItem.fromJson(json['status'] as Map<String, dynamic>),
      approveStatus: json['approveStatus'] == null ? null : DictionaryItem.fromJson(json['approveStatus'] as Map<String, dynamic>),
      proposalItems: (json['proposalItems'] as List).map((e) => ProposalItemModel.fromJson(e as Map<String, dynamic>)).toList(),
      isShowApprovalDetail: json['isShowApprovalDetail'] as bool);
}

Map<String, dynamic> _$ProposalInfoModelToJson(ProposalInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'no': instance.no,
      'date': instance.date?.toIso8601String(),
      'neededFromDate': instance.neededFromDate?.toIso8601String(),
      'neededToDate': instance.neededToDate?.toIso8601String(),
      'branch': instance.branch,
      'createdEmployee': instance.createdEmployee,
      'proposedEmployee': instance.proposedEmployee,
      'commodityType': instance.commodityType,
      'type': instance.type,
      'department': instance.department,
      'departmentRoom': instance.departmentRoom,
      'desc': instance.desc,
      'status': instance.status,
      'approveStatus': instance.approveStatus,
      'proposalItems': instance.proposalItems,
      'isShowApprovalDetail': instance.isShowApprovalDetail
    };
