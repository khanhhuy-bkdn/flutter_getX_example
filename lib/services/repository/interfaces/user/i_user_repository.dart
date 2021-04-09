import 'package:flutter_demo_getx/models/login.model.dart';
import 'package:flutter_demo_getx/models/user.model.dart';

abstract class IUserRepository {
  Future<bool> login(LoginModel model);
  Future getUserInfo();
  Future<UserModel> getUser(int userId);
}
