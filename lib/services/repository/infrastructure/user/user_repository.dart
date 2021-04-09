import 'package:flutter_demo_getx/constants/status_message.dart';
import 'package:flutter_demo_getx/models/login.model.dart';
import 'package:flutter_demo_getx/models/user.model.dart';
import 'package:flutter_demo_getx/services/provider/i_api_provider.dart';
import 'package:flutter_demo_getx/services/repository/interfaces/user/i_user_repository.dart';
import 'package:flutter_demo_getx/utils/cast_object.dart';
import 'package:flutter_demo_getx/utils/function_helper.dart';
import 'package:get_storage/get_storage.dart';

class UserRepository implements IUserRepository {
  UserRepository({required this.apiProvider});
  final IApiProvider apiProvider;
  final GetStorage box = GetStorage();

  Future<bool> login(LoginModel model) async {
    try {
      final response = await apiProvider.post(
        'user/login',
        model.toJson(),
      );
      if (response != null) {
        await box.write('token', response['accessToken'].toString());
        await box.write('userId', cast<int>(response['userId']));
        await box.write('permission', response['permission'].toString());
        await box.write('role', response['role'].toString());
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      FunctionHelper.showSnackbar(
          'Thông báo',
          'Đã có lỗi xảy ra. Vui lòng thử lại!',
          StatusMessage.error,
          'Error occurred $error\n Stacktrace: $stacktrace}');
      return false;
    }
  }

  Future getUserInfo() async {
    UserModel user = await getUser(box.read<int>('userId'));
    await box.write('user', user.toJson());
  }

  Future<UserModel> getUser(int? userId) async {
    final response = await apiProvider.get('user/${userId}');
    if (response != null) {
      return UserModel.fromJson(response as Map<String, dynamic>);
    }
    return UserModel();
  }
}
