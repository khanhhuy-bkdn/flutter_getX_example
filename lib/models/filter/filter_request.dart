import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FilterRequest {
  int? page;
  int? pageSize;
  String? searchKey;

  FilterRequest({this.page, this.pageSize, this.searchKey});

  factory FilterRequest.fromJson(Map<String, dynamic> json) =>
      _$FilterFromJson(json);
  Map<String, dynamic> toJson() => _$FilterToJson(this);
}

FilterRequest _$FilterFromJson(Map<String, dynamic> json) {
  return FilterRequest(
    page: json['page'] as int,
    pageSize: json['pageSize'] as int,
    searchKey: json['searchKey'] as String,
  );
}

Map<String, dynamic> _$FilterToJson(FilterRequest instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'searchKey': instance.searchKey,
    };
