import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProposalApproveRequest {
  int id;
  String action;
  String messages;

  ProposalApproveRequest(this.id, this.action, this.messages);

  factory ProposalApproveRequest.fromJson(Map<String, dynamic> json) =>
      _$ProposalApproveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProposalApproveRequestToJson(this);
}

ProposalApproveRequest _$ProposalApproveRequestFromJson(
    Map<String, dynamic> json) {
  return ProposalApproveRequest(
      json['id'] as int, json['action'] as String, json['messages'] as String);
}

Map<String, dynamic> _$ProposalApproveRequestToJson(
        ProposalApproveRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': instance.action,
      'messages': instance.messages
    };
