import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/shared/theme/custom_theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/constants/module_name.dart';
import 'package:flutter_demo_getx/constants/sort_type.dart';
import 'package:flutter_demo_getx/constants/status_message.dart';
import 'package:flutter_demo_getx/models/role/role.model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FunctionHelper {
  static double fontSizeIcon = 13;
  static String formatCurrencyNumber(num number, {int? decimalDigits}) {
    int nguyen = number.toInt();
    num thapphan = number - nguyen;
    NumberFormat currencyFormat = new NumberFormat.currency(
        locale: "en_US",
        symbol: "",
        decimalDigits:
            (decimalDigits ?? 0) > 0 ? (thapphan > 0 ? decimalDigits : 0) : 0);
    return currencyFormat.format(number);
  }

  static List<String> getListPermission(String moduleName, {int? branchId}) {
    List<RoleModel> rolePermissionModule = [];
    Set<String> rolePermissionResult = Set<String>();

    for (String val in jsonDecode(GetStorage().read('role')).keys) {
      String name = val;
      int branch = 0;
      if (val.contains(';')) {
        List<String> nameSplit = val.split(';');
        if (nameSplit != null && nameSplit.length > 0) {
          name = nameSplit[1];
          branch = int.tryParse(nameSplit[0])!;
        }
      }

      RoleModel role = RoleModel(
          moduleName: name,
          branchId: branch,
          roleItems: jsonDecode(GetStorage().read('role'))[val]);
      rolePermissionModule.add(role);
    }

    if (rolePermissionModule != null && rolePermissionModule.length > 0) {
      var models = rolePermissionModule
          .where((o) =>
              o.moduleName!.contains(ModuleName.businessInformation) &&
              ((branchId != null && o.branchId == branchId) ||
                  branchId == null))
          .toList();
      if (models != null && models.length > 0) {
        models.forEach((o) {
          if (o.roleItems != null && o.roleItems!.length > 0) {
            var items = List<String>.from(o.roleItems!);
            if (items != null && items.length > 0) {
              rolePermissionResult.addAll(items);
            }
          }
        });
      }
    }
    return rolePermissionResult.toList();
  }

  static void showSnackbar(String title, String message, String type,
      [String? messageError]) {
    if (type == StatusMessage.success) {
      Get.snackbar(title, message,
          titleText: Text(
            title,
            style:
                TextStyle(color: Colors.green, fontSize: defaultFontSize + 2),
          ),
          messageText: Text(message),
          colorText: Colors.black,
          icon: Icon(Icons.check_rounded, color: Colors.green),
          backgroundColor: Colors.white);
    } else {
      Get.snackbar(title, message,
          titleText: Text(
            title,
            style: TextStyle(color: Colors.red, fontSize: defaultFontSize + 2),
          ),
          messageText: Text(message),
          colorText: Colors.red,
          icon: Icon(
            Icons.error_sharp,
            color: Colors.red,
          ),
          backgroundColor: Colors.white);
      print(messageError);
    }
  }

  static Icon checkIconSort(String _sortVar, String sortVar, String sortType) {
    if (_sortVar == sortVar) {
      switch (sortType) {
        case ESortType.asc:
          {
            return Icon(
              Icons.keyboard_arrow_down,
              size: fontSizeIcon,
              color: Colors.white,
            );
          }
        case ESortType.desc:
          {
            return Icon(
              Icons.keyboard_arrow_up,
              size: fontSizeIcon,
              color: Colors.white,
            );
          }

        default:
          {
            return Icon(
              Icons.unfold_more,
              size: fontSizeIcon,
              color: Colors.white,
            );
          }
      }
    }
    return Icon(
      Icons.unfold_more,
      size: fontSizeIcon,
      color: Colors.white,
    );
  }

  static sortData(String _sortVar, String sortVar, String sortType,
      List<dynamic> listData) {
    if (_sortVar == sortVar) {
      switch (sortType) {
        case ESortType.asc:
          {
            sortType = ESortType.desc;
            listData[0].getProp(_sortVar) is num
                ? listData.sort((a, b) {
                    return b.getProp(_sortVar) > a.getProp(_sortVar) ? 1 : -1;
                  })
                : listData.sort((a, b) {
                    return b
                        .getProp(_sortVar)
                        .toLowerCase()
                        .compareTo(a.getProp(_sortVar).toLowerCase());
                  });
            break;
          }
        case ESortType.desc:
          {
            sortType = '';
            listData.sort((a, b) {
              return b.amount > a.amount ? 1 : -1;
            });
            break;
          }
        default:
          {
            sortType = ESortType.asc;
            listData[0].getProp(_sortVar) is num
                ? listData.sort((a, b) {
                    return a.getProp(_sortVar) > b.getProp(_sortVar) ? 1 : -1;
                  })
                : listData.sort((a, b) {
                    return a
                        .getProp(_sortVar)
                        .toLowerCase()
                        .compareTo(b.getProp(_sortVar).toLowerCase());
                  });
          }
      }
    }
    if (_sortVar != sortVar) {
      sortType = ESortType.asc;
      listData[0].getProp(_sortVar) is num
          ? listData.sort((a, b) {
              return a.getProp(_sortVar) > b.getProp(_sortVar) ? 1 : -1;
            })
          : listData.sort((a, b) {
              return a
                  .getProp(_sortVar)
                  .toLowerCase()
                  .compareTo(b.getProp(_sortVar).toLowerCase());
            });
    }
    sortVar = _sortVar;
    return {
      'sortVar': sortVar,
      'sortType': sortType,
      'listData': listData,
    };
  }

  static comingSoon(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    'Chức năng này sẽ sớm cập nhật',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: CustomTheme.bodyText2(context).fontSize),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: defaultPadding / 2),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Colors.black.withOpacity(0.5),
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Đóng"),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
