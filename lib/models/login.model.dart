import 'package:flutter_demo_getx/models/branch.model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginModel {
  String? userName;
  String? password;
  BranchModel? branch;

  LoginModel(this.userName, this.password, this.branch);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      json['userName'] as String,
      json['password'] as String,
      json['branch'] == null
          ? null
          : BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'userName': this.userName,
        'password': this.password,
        'branchId': this.branch?.id,
      };
}
