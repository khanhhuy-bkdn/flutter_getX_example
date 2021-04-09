import 'package:json_annotation/json_annotation.dart';
//part 'role.model.g.dart';

@JsonSerializable()
class RoleModel {
  String? moduleName;
  List? roleItems;
  int? branchId;

  RoleModel({this.moduleName, this.roleItems, this.branchId});

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoleModelToJson(this);
}

RoleModel _$RoleModelFromJson(Map<String, dynamic> json) {
  return RoleModel(
    moduleName: json['moduleName'] as String,
    roleItems: json['roleItems'] as List,
    branchId: json['branchId'] as int,
  );
}

Map<String, dynamic> _$RoleModelToJson(RoleModel instance) => <String, dynamic>{
      'moduleName': instance.moduleName,
      'roleItems': instance.roleItems,
      'branchId': instance.branchId,
    };
