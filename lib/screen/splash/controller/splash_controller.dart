import 'package:get/get.dart';
import 'package:quanlydiem/config/api_state.dart';
import 'package:quanlydiem/model/acount.dart';
import 'package:quanlydiem/model/user.dart';
import 'package:quanlydiem/screen/home/home_screen.dart';
import 'package:quanlydiem/screen/login/controller/login_controller.dart';
import 'package:quanlydiem/screen/login/login_screen.dart';
import 'package:quanlydiem/screen/navbar/navbar.dart';
import 'package:quanlydiem/screen/oboarding/onboarding.dart';
import 'package:quanlydiem/services/api.dart';
import 'package:quanlydiem/util/preferences_util.dart';

class SplashController extends GetxController {
  var apiState = ApiState.success.obs;

  void handleNavigate() async {
    String? email = PreferencesUtil.getEmail();
    String? password = PreferencesUtil.getPassword();
    PreferencesUtil.getFirstTime();
    await Future.delayed(
      1.seconds,
    );
    if (PreferencesUtil.getFirstTime()) {
      Future.delayed(
        1.seconds,
        () => Get.offAll(() => const OnboardingScreen()),
      );
    } else {
      if (email != null && password != null) {
        apiState.value = ApiState.loading;
        try {
          await Future.delayed(1.seconds);
          final result = await ApiService()
              .login(Account(email: email, password: password));
          Get.find<LoginController>().userData.value =
              User.fromJson(result['data']);
          Get.find<LoginController>().accessToken = result['token'];
          apiState.value = ApiState.success;
          Get.offAll(() => const Navbar());
        } catch (e) {
          print(e);
          apiState.value = ApiState.success;
          // Hiển thị lỗi mạng hoặc lỗi khác
          Get.offAll(() => const LoginScreen());
        }
      } else {
        Get.offAll(() => const LoginScreen());
      }
    }
  }
}
