import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BranchModel {
  int? id;
  String? no;
  String? name;

  BranchModel(this.id, this.no, this.name);

  @override
  String toString() => name ?? '';

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      json['id'] as int,
      json['no'] as String,
      json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'no': this.no,
        'name': this.name,
      };
}
