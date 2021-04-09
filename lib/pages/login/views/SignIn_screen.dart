import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/models/dictionary_item.dart';
import 'package:flutter_demo_getx/models/login.model.dart';
import 'package:flutter_demo_getx/models/role/role.model.dart';
import 'package:flutter_demo_getx/pages/login/controllers/login_controller.dart';
import 'package:flutter_demo_getx/pages/menu/controllers/menu_controller.dart';
import 'package:flutter_demo_getx/shared/theme/custom_theme.dart';
import 'package:flutter_demo_getx/utils/hex_color.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method
import 'package:collection/collection.dart';

class SignInScreen extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<SignInScreen> {
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _branchFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final mq = MediaQueryData.fromWindow(window);
  bool isSaveAcc = true;
  bool showPass = false;
  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  LoginModel loginModel = new LoginModel(null, null, null);

  List<RoleModel> roles = [];
  DictionaryItem? menuActive;

  bool _loading = false;

  void checkMenu() {
    Get.find<MenuController>().checkMenuActive();
    roles = Get.find<MenuController>().rolesResult;
    // ignore: unnecessary_null_comparison
    if (roles != null && roles.length > 0) {
      menuActive = menuItem
          .firstWhereOrNull((o) => roles.any((x) => x.moduleName == o!.key));
    }
  }

  @override
  void initState() {
    super.initState();
    // getBranch();
  }

  String encodePassword(String input) {
    var byte = AsciiCodec().encode(input);
    return base64.encode((sha1.convert(byte)).bytes);
  }

  void clearLogin(BuildContext context) {
    showMyDialog(context);
    GetStorage().erase();
  }

  Future<void> signin() async {
    setState(() {
      _loading = true;
    });
    if (_formKey.currentState!.validate()) {
      loginModel.userName = userNameEditingController.value.text;
      loginModel.password =
          encodePassword(passwordEditingController.value.text);
      bool login = await Get.find<LoginController>().login(loginModel);
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _loading = false;
      });
      if (login) {
        await Get.find<LoginController>().getUserInfo();
        checkMenu();
        if (menuActive != null) {
          Get.offNamed(menuActive!.code!);
        } else {
          clearLogin(context);
        }
      }
    }
    setState(() {
      _loading = false;
    });
  }

  void showMyDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              //height: 118,
              child: Column(
                children: <Widget>[
                  Text(
                    'Thông báo',
                    style: CustomTheme.headline5(context),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Bạn không được phép truy cập vào chi nhánh này!',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: CustomTheme.bodyText1(context).fontSize),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: defaultPadding / 2),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Colors.black.withOpacity(0.5),
                        textColor: Colors.white,
                        // padding: EdgeInsets.symmetric(
                        //     vertical: defaultPadding / 2,
                        //     horizontal: defaultPadding),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          Opacity(
            opacity: _loading ? 0.7 : 1.0,
            child: AbsorbPointer(
              absorbing: _loading ? true : false,
              child: Scaffold(
                  // resizeToAvoidBottomInset: false,
                  // resizeToAvoidBottomPadding: false,
                  body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    height: mq.size.height,
                  ),
                  child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/bg.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Image(
                                  image: AssetImage(
                                      'assets/images/logo-achau.png')),
                            ),
                            Container(
                              margin: EdgeInsets.all(defaultPadding * 2),
                              padding: EdgeInsets.all(defaultPadding),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(defaultPadding))),
                              child: Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                  child: Column(children: <Widget>[
                                    Text(
                                      'Asia Packing Corp',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          color: HexColor('#3498B7'),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: defaultPadding,
                                            top: defaultPadding,
                                            right: defaultPadding),
                                        child: TextFormField(
                                          controller: userNameEditingController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Trường này là bắt buộc';
                                            }
                                            return null;
                                          },
                                          decoration: new InputDecoration(
                                              prefixIcon: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 6),
                                                  child: Icon(Icons.person,
                                                      size: 14)),
                                              hintText: 'Tài khoản',
                                              fillColor: Colors.white,
                                              filled: true),
                                          textInputAction: TextInputAction.next,
                                          // autofocus: true,
                                          onFieldSubmitted: (String data) {
                                            FocusScope.of(context)
                                                .requestFocus(_passwordFocus);
                                          },
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: defaultPadding,
                                            top: defaultPadding,
                                            right: defaultPadding),
                                        child: TextFormField(
                                          controller: passwordEditingController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Trường này là bắt buộc';
                                            }
                                            return null;
                                          },
                                          obscureText: !this.showPass,
                                          focusNode: _passwordFocus,
                                          decoration: new InputDecoration(
                                            prefixIcon: Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 6),
                                                child:
                                                    Icon(Icons.lock, size: 14)),
                                            hintText: 'Mật khẩu',
                                            fillColor: Colors.white,
                                            filled: true,
                                            suffixIcon: Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 6),
                                                child: InkWell(
                                                    onTap: () => setState(() {
                                                          this.showPass =
                                                              !this.showPass;
                                                        }),
                                                    child: this.showPass
                                                        ? Icon(
                                                            Icons
                                                                .remove_red_eye_outlined,
                                                            size: 20)
                                                        : Icon(
                                                            Icons
                                                                .remove_red_eye_rounded,
                                                            size: 20))),
                                          ),
                                          textInputAction: TextInputAction.send,
                                          onFieldSubmitted: (String data) {
                                            signin();
                                          },
                                        )),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding * 2),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: RaisedButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () => signin(),
                                        textColor: Colors.white,
                                        child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: <Color>[
                                                  HexColor('#3498B7'),
                                                  HexColor('#3498B7')
                                                ],
                                              ),
                                            ),
                                            padding:
                                                EdgeInsets.all(defaultPadding),
                                            child: SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  'Đăng nhập',
                                                  textAlign: TextAlign.center,
                                                )))))),
                          ])),
                ),
              )),
            ),
          ),
          _loading
              ? Center(
                  child: CircularProgressIndicator(
                      //valueColor: AlwaysStoppedAnimation<Color>(Colors.amberAccent),
                      ))
              : Container(),
        ],
      ),
    );
  }
}
