import 'package:flutter_demo_getx/models/branch.model.dart';
import 'package:flutter_demo_getx/models/dictionary_item.dart';
import 'package:flutter_demo_getx/models/employee/employee_model.dart';
import 'package:flutter_demo_getx/models/employee/filter_employee_request.dart';
import 'package:flutter_demo_getx/models/filter/filter_object_model.dart';
import 'package:flutter_demo_getx/models/filter/filter_request.dart';
import 'package:flutter_demo_getx/models/v_object.model.dart';
import 'package:flutter_demo_getx/services/provider/i_api_provider.dart';
import 'package:flutter_demo_getx/services/repository/interfaces/master_data/i_masterdata_repository.dart';

class MasterDataRepository implements IMasterDataRepository {
  MasterDataRepository({required this.apiProvider});
  final IApiProvider apiProvider;

  @override
  Future<List<DictionaryItem>> getByConfigGroup(String configKeyGroup) async {
    try {
      final response =
          await apiProvider.get('masterdata/config-value/${configKeyGroup}');
      if (response != null) {
        var data = response;
        final list = data.map<DictionaryItem>((o) {
          return DictionaryItem.fromJson(o as Map<String, dynamic>);
        }).toList();
        return list;
      } else {
        return [];
      }
    } catch (error, stacktrace) {
      print('Error occurred $error\n Stacktrace: $stacktrace}');
      return [];
    }
  }

  @override
  Future<List<BranchModel>> getListBranch(FilterRequest filter) async {
    try {
      final params = {
        'searchKey': filter.searchKey,
      };
      final response = await apiProvider.get(
          'masterdata/branch/filterbranch/${filter.page}/${filter.pageSize}',
          params: params
            ..removeWhere((key, value) => key == null || value == null));

      if (response != null) {
        var data = response['items'];
        final list = data.map<BranchModel>((o) {
          return BranchModel.fromJson(o as Map<String, dynamic>);
        }).toList();
        return list;
      } else {
        return [];
      }
    } catch (error, stacktrace) {
      print('Error occurred $error\n Stacktrace: $stacktrace}');
      return [];
    }
  }

  @override
  Future<List<EmployeeModel>> getListEmployee(
      FilterEmployeeRequest filter) async {
    try {
      final params = {
        'searchKey': filter.searchKey,
        'hasAccountLogin': filter.hasAccountLogin ?? null
      };
      final response = await apiProvider.get(
          'masterdata/employee/filter-employee/${filter.page}/${filter.pageSize}',
          params: params
            ..removeWhere((key, value) => key == null || value == null));

      if (response != null) {
        var data = response['items'];
        final list = data.map<EmployeeModel>((o) {
          return EmployeeModel.fromJson(o as Map<String, dynamic>);
        }).toList();
        return list;
      } else {
        return [];
      }
    } catch (error, stacktrace) {
      print('Error occurred $error\n Stacktrace: $stacktrace}');
      return [];
    }
  }

  @override
  Future<List<VObjectModel>> getListObject(
      FilterObjectModel filterItems) async {
    final params = {
      'searchKey': filterItems.searchKey,
      'moduleName': filterItems.moduleName,
    };
    try {
      final response = await apiProvider.get(
          'masterdata/vobject/filter-object/${filterItems.page}/${filterItems.pageSize}',
          params: params);

      if (response != null) {
        var data = response['items'];
        final list = data.map<VObjectModel>((o) {
          return VObjectModel.fromJson(o as Map<String, dynamic>);
        }).toList();
        return list;
      } else {
        return [];
      }
    } catch (error, stacktrace) {
      print('Error occurred $error\n Stacktrace: $stacktrace}');
      return [];
    }
  }

  @override
  Future<List<BranchModel>> getBranchs() async {
    final json = await apiProvider.get('masterData/branch/filterbranch/0/50');
    final result = json['items'].map<BranchModel>((o) {
      return BranchModel.fromJson(o as Map<String, dynamic>);
    }).toList();
    return result;
  }
}
