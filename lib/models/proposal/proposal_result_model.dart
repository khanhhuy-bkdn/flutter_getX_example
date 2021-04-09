import 'package:flutter_demo_getx/models/proposal/proposal_model.dart';
import 'package:json_annotation/json_annotation.dart';
//part 'proposal_result_model.g.dart';

@JsonSerializable()
class ProposalResultModel {
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  int? requiredQty;
  int? recheckQty;
  int? rejectionQty;
  int? approvedQty;
  List<ProposalModel?>? items;

  ProposalResultModel(
      {this.approvedQty,
      this.items,
      this.recheckQty,
      this.rejectionQty,
      this.requiredQty,
      this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages});

  factory ProposalResultModel.fromJson(Map<String, dynamic> json) =>
      _$ProposalResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProposalResultModelToJson(this);
}

ProposalResultModel _$ProposalResultModelFromJson(Map<String, dynamic> json) {
  return ProposalResultModel(
    approvedQty: json['extraData']['approvedQty'] as int,
    items: (json['items'] as List)
        .map((e) => e == null
            ? null
            : ProposalModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    recheckQty: json['extraData']['recheckQty'] as int,
    rejectionQty: json['extraData']['rejectionQty'] as int,
    requiredQty: json['extraData']['requiredQty'] as int,
    pageIndex: json['pageIndex'] as int,
    pageSize: json['pageSize'] as int,
    totalCount: json['totalCount'] as int,
    totalPages: json['totalPages'] as int,
  );
}

Map<String, dynamic> _$ProposalResultModelToJson(
        ProposalResultModel instance) =>
    <String, dynamic>{
      'requiredQty': instance.requiredQty,
      'recheckQty': instance.recheckQty,
      'rejectionQty': instance.rejectionQty,
      'approvedQty': instance.approvedQty,
      'items': instance.items,
    };
