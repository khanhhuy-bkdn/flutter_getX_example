import 'package:flutter/cupertino.dart';
import 'package:flutter_demo_getx/models/branch.model.dart';
import 'package:flutter_demo_getx/models/copyable.dart';
import 'package:flutter_demo_getx/models/dictionary_item.dart';
import 'package:flutter_demo_getx/models/employee/employee_model.dart';
import 'package:json_annotation/json_annotation.dart';
//part 'filter_proposal_model.g.dart';

@JsonSerializable()
class FilterProposalModel implements Copyable {
  DateTime? fromDate;
  DateTime? toDate;
  EmployeeModel? employee;
  DictionaryItem? type;
  DictionaryItem? commodityType;
  DictionaryItem? approvedStatus;
  BranchModel? branch;
  int page;
  int pageSize;
  String? searchKey;

  FilterProposalModel(
      {this.fromDate,
      this.toDate,
      this.employee,
      this.commodityType,
      this.type,
      this.approvedStatus,
      this.branch,
      this.searchKey,
      required this.page,
      required this.pageSize});

  factory FilterProposalModel.fromJson(Map<String, dynamic> json) =>
      _$FilterProposalModelFromJson(json);
  Map<String, dynamic> toJson() => _$FilterProposalModelToJson(this);

  @override
  FilterProposalModel copy() => FilterProposalModel(
      page: page,
      pageSize: pageSize,
      searchKey: searchKey ?? this.searchKey,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      employee: employee ?? this.employee,
      commodityType: commodityType ?? this.commodityType,
      type: type ?? this.type,
      approvedStatus: approvedStatus ?? this.approvedStatus,
      branch: branch ?? this.branch);

  @override
  FilterProposalModel copyWith(
          {DateTime? fromDate,
          DateTime? toDate,
          EmployeeModel? employee,
          DictionaryItem? type,
          DictionaryItem? commodityType,
          DictionaryItem? approvedStatus,
          BranchModel? branch,
          int? page,
          int? pageSize,
          String? searchKey}) =>
      FilterProposalModel(
          page: page ?? this.page,
          pageSize: pageSize ?? this.pageSize,
          searchKey: searchKey ?? this.searchKey,
          fromDate: fromDate ?? this.fromDate,
          toDate: toDate ?? this.toDate,
          employee: employee ?? this.employee,
          commodityType: commodityType ?? this.commodityType,
          type: type ?? this.type,
          approvedStatus: approvedStatus ?? this.approvedStatus,
          branch: branch ?? this.branch);
}

FilterProposalModel _$FilterProposalModelFromJson(Map<String, dynamic> json) {
  return FilterProposalModel(
    fromDate: json['fromDate'] == null
        ? null
        : DateTime.parse(json['fromDate'] as String),
    toDate: json['toDate'] == null
        ? null
        : DateTime.parse(json['toDate'] as String),
    employee: json['employee'] == null
        ? null
        : EmployeeModel.fromJson((json['employee'] as EmployeeModel).toJson()),
    commodityType: json['commodityType'] == null
        ? null
        : json['commodityType'] as DictionaryItem,
    type: json['type'] == null
        ? null
        : DictionaryItem.fromJson(json['type'] as Map<String, dynamic>),
    approvedStatus: json['approvedStatus'] == null
        ? null
        : DictionaryItem.fromJson(
            json['approvedStatus'] as Map<String, dynamic>),
    branch: json['branch'] == null
        ? null
        : BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
    page: json['page'] as int,
    pageSize: json['pageSize'] as int,
    searchKey: json['searchKey'] as String,
  );
}

Map<String, dynamic> _$FilterProposalModelToJson(
        FilterProposalModel instance) =>
    <String, dynamic>{
      'fromDate': instance.fromDate?.toIso8601String(),
      'toDate': instance.toDate?.toIso8601String(),
      'employee': instance.employee,
      'type': instance.type,
      'commodityType': instance.commodityType,
      'approvedStatus': instance.approvedStatus,
      'branch': instance.branch,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'searchKey': instance.searchKey
    };
