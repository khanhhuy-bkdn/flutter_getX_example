import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FilterEmployeeRequest {
  num page;
  int? pageSize;
  String? searchKey;
  bool? hasAccountLogin;

  FilterEmployeeRequest(
      {required this.page,
      this.pageSize,
      this.searchKey,
      this.hasAccountLogin});

  factory FilterEmployeeRequest.fromJson(Map<String, dynamic> json) =>
      _$FilterFromJson(json);
  Map<String, dynamic> toJson() => _$FilterToJson(this);
}

FilterEmployeeRequest _$FilterFromJson(Map<String, dynamic> json) {
  return FilterEmployeeRequest(
    page: json['page'] as int,
    pageSize: json['pageSize'] as int,
    searchKey: json['searchKey'] as String,
    hasAccountLogin: json['hasAccountLogin'] as bool,
  );
}

Map<String, dynamic> _$FilterToJson(FilterEmployeeRequest instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'searchKey': instance.searchKey,
      'hasAccountLogin': instance.hasAccountLogin,
    };
