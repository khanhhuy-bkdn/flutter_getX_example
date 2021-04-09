// ignore: one_member_abstracts
import 'package:flutter_demo_getx/models/branch.model.dart';
import 'package:flutter_demo_getx/models/dictionary_item.dart';
import 'package:flutter_demo_getx/models/employee/employee_model.dart';
import 'package:flutter_demo_getx/models/employee/filter_employee_request.dart';
import 'package:flutter_demo_getx/models/filter/filter_object_model.dart';
import 'package:flutter_demo_getx/models/filter/filter_request.dart';
import 'package:flutter_demo_getx/models/v_object.model.dart';

abstract class IMasterDataRepository {
  Future<List<DictionaryItem>> getByConfigGroup(String configKeyGroup);
  Future<List<BranchModel>> getListBranch(FilterRequest filter);
  Future<List<EmployeeModel>> getListEmployee(FilterEmployeeRequest filter);
  Future<List<VObjectModel>> getListObject(FilterObjectModel filterItems);
  Future<List<BranchModel>> getBranchs();
}
