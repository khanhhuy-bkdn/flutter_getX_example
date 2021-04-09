import 'package:flutter_demo_getx/models/employee/employee_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserModel {
  int? userId;
  String? userName;
  EmployeeModel? employee;

  UserModel({this.userId, this.userName, this.employee});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
      userId: json['userId'] as int?,
      userName: json['userName'] as String?,
      employee: json['employee'] == null
          ? null
          : EmployeeModel.fromJson(json['employee'] as Map<String, dynamic>));
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'employee': instance.employee?.toJson()
    };
