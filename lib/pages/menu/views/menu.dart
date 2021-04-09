import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/routes/app_pages.dart';
import 'package:flutter_demo_getx/models/role/role.model.dart';
import 'package:flutter_demo_getx/models/user.model.dart';
import 'package:flutter_demo_getx/pages/menu/controllers/menu_controller.dart';
import 'package:flutter_demo_getx/utils/hex_color.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:collection/collection.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  UserModel? user;
  List<RoleModel?>? roles = [];

  void initState() {
    super.initState();
    Get.find<MenuController>().checkMenuActive();
    roles = Get.find<MenuController>().rolesResult;
    user = Get.find<MenuController>().userResult;
  }

  String? getCurrentRouteName(context) {
    String? currentRouteName;

    Navigator.popUntil(context, (route) {
      currentRouteName = route.settings.name!;
      return true;
    });
    return currentRouteName;
  }

  Color _color = defaultBgColor;

  @override
  Widget build(BuildContext context) {
    String? currentRoute = getCurrentRouteName(context);
    return Drawer(
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [_color, _color.withOpacity(0.6)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  color: _color),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.blue,
                      backgroundImage: AssetImage(
                        'assets/images/avata-default-blank.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      user?.userName?.toUpperCase() ?? '',
                      style: TextStyle(
                          fontSize: defaultFontSize + 5, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 220,
                    child: GetBuilder<MenuController>(
                      key: Key('setMenu'),
                      //init: MenuController(),
                      builder: (item) {
                        print(item.menuItemResult);
                        return ListView(
                            padding: EdgeInsets.zero,
                            children: item.menuItemResult.map<Widget>((o) {
                              bool checkExpand = item.menuItemResult
                                          .where((element) =>
                                              int.tryParse(
                                                  element!.typeGroup!) ==
                                              int.tryParse(o!.value!))
                                          .toList()
                                          .length >
                                      0
                                  ? true
                                  : false;
                              bool _isNotEmpty = checkExpand &&
                                  (roles != null &&
                                      roles?.firstWhereOrNull((x) =>
                                              item.menuItemResult.any((y) =>
                                                  x!.moduleName == y!.key &&
                                                  y.typeGroup == o!.value)) !=
                                          null);
                              if (int.tryParse(o!.typeGroup!) == 0) {
                                return Container(
                                  height: (((roles != null &&
                                                  roles?.firstWhereOrNull((x) =>
                                                          x!.moduleName ==
                                                          o.key) !=
                                                      null) &&
                                              !checkExpand) ||
                                          _isNotEmpty)
                                      ? 40
                                      : 0,
                                  color: currentRoute == o.code
                                      ? HexColor('#60a3bc')
                                      : null,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (checkExpand) {
                                        if (item.listmenuExpand
                                            .any((x) => x == o.value)) {
                                          item.listmenuExpand.remove(o.value);
                                        } else {
                                          item.listmenuExpand.add(o.value!);
                                        }
                                        Get.find<MenuController>()
                                            .setMenuExpand(item.listmenuExpand);
                                        setState(() {});
                                      } else {
                                        Navigator.of(context).pop();
                                        if (o.code != currentRoute)
                                          Get.offAllNamed(o.code!);
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 20, right: 10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      )),
                                      child: Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              o.displayText!,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: currentRoute == o.code
                                                      ? HexColor('#00FFFF')
                                                      : Colors.white,
                                                  fontSize: defaultFontSize + 3,
                                                  fontWeight:
                                                      currentRoute == o.code
                                                          ? FontWeight.bold
                                                          : null),
                                            ),
                                          ),
                                          Expanded(
                                            child: _isNotEmpty
                                                ? Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: !item.listmenuExpand
                                                            .any((x) =>
                                                                x == o.value)
                                                        ? Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: Colors.white,
                                                          )
                                                        : Icon(
                                                            Icons.arrow_right,
                                                            color: Colors.white,
                                                          ))
                                                : Container(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    height: !item.listmenuExpand
                                                .any((x) => x == o.typeGroup) &&
                                            (roles != null &&
                                                roles?.firstWhereOrNull((x) =>
                                                        x!.moduleName ==
                                                        o.key) !=
                                                    null)
                                        ? 40
                                        : 0,
                                    child: SingleChildScrollView(
                                        child: Column(children: [
                                      (roles != null &&
                                              roles?.firstWhereOrNull((x) =>
                                                      x!.moduleName == o.key) !=
                                                  null)
                                          ? Container(
                                              color: currentRoute == o.code
                                                  ? HexColor('#60a3bc')
                                                  : null,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  Get.offAllNamed(o.code!);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  padding:
                                                      EdgeInsets.only(left: 50),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                    bottom: BorderSide(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                  )),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(o.displayText!,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: currentRoute ==
                                                                    o.code
                                                                ? HexColor(
                                                                    '#00FFFF')
                                                                : Colors.white,
                                                            fontSize:
                                                                defaultFontSize +
                                                                    3,
                                                            fontWeight:
                                                                currentRoute ==
                                                                        o.code
                                                                    ? FontWeight
                                                                        .bold
                                                                    : null)),
                                                  ),
                                                ),
                                              ))
                                          : Container(),
                                    ])));
                              }
                            }).toList());
                      },
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () {
                          GetStorage().erase();
                          Get.offAllNamed(Routes.login);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: defaultFontSize + 5,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Đăng xuất',
                              style: TextStyle(
                                  fontSize: defaultFontSize + 3,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
