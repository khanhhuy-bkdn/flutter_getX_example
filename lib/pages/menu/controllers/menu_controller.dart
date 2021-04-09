import 'dart:convert';

import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/constants/module_name.dart';
import 'package:flutter_demo_getx/models/dictionary_item.dart';
import 'package:flutter_demo_getx/models/role/role.model.dart';
import 'package:flutter_demo_getx/models/user.model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

class MenuController extends GetxController {
  List<RoleModel> rolesResult = [];
  UserModel? userResult;
  List<String> listmenuExpand = [];
  List<DictionaryItem?> menuItemResult = menuItem;
  final box = GetStorage();

  List<RoleModel> rolePermissionModule = [];
  Future checkMenuActive() async {
    menuItemResult = menuItem;
    // ignore: unnecessary_null_comparison
    if (rolesResult != null) {
      rolesResult.clear();
    } else {
      rolesResult = [];
    }
    userResult = UserModel.fromJson(box.read('user'));
    print(box.read('permission'));
    for (var val in jsonDecode(box.read('permission'))) {
      RoleModel role = RoleModel(
          moduleName: val, roleItems: jsonDecode(box.read('permission')));
      rolesResult.add(role);
      rolesResult.add(RoleModel(moduleName: ModuleName.profitInformation));
    }

    for (var val in jsonDecode(box.read('role')).keys) {
      RoleModel role = RoleModel(
          moduleName: val, roleItems: jsonDecode(box.read('role'))[val]);
      rolePermissionModule.add(role);
    }
    rolesResult.add(RoleModel(moduleName: ModuleName.profitInformation));
    update();
  }

  Future setMenuExpand(List<String> items) async {
    listmenuExpand = items;
    update(['setMenu']);
  }
}
