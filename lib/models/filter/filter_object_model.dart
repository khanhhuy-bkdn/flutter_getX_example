import 'package:json_annotation/json_annotation.dart';
//part 'filter_purchase_order_model.g.dart';

@JsonSerializable()
class FilterObjectModel {
  String? searchKey;
  String? moduleName;
  int page;
  int pageSize;

  FilterObjectModel(
      {this.searchKey,
      this.moduleName,
      required this.page,
      required this.pageSize});
}
