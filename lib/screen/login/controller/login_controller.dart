
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlydiem/config/api_state.dart';
import 'package:quanlydiem/model/acount.dart';
import 'package:quanlydiem/model/user.dart';
import 'package:quanlydiem/screen/navbar/navbar.dart';
import 'package:quanlydiem/services/api.dart';
import 'package:quanlydiem/util/preferences_util.dart';

class LoginController extends GetxController {
  var apiState = ApiState.success.obs;
  Rx<User> userData = User().obs;
  var accessToken = "";
  void checkLogin() {
    String? email = PreferencesUtil.getEmail();
    String? password = PreferencesUtil.getPassword();

    if (email != null && password != null) {}
  }

  void login(String email, String password, BuildContext context) async {
    apiState.value = ApiState.loading;
    try {
      await Future.delayed(1.seconds);
      final result =
          await ApiService().login(Account(email: email, password: password));
      print(result);
      userData.value = User.fromJson(result['data']);
      await PreferencesUtil.setEmail(email);
      await PreferencesUtil.setPassword(password);
      apiState.value = ApiState.success;
      Get.offAll(() => const Navbar());
    } catch (e) {
      apiState.value = ApiState.success;
      // Hiển thị lỗi mạng hoặc lỗi khác
      CherryToast.error(
        title: const Text("Lỗi đăng nhập"),
        description: Text(e.toString()),
      ).show(context);
    }
  }
}
