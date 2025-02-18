import 'package:get/get.dart';
import 'package:quanlydiem/config/api_state.dart';
import 'package:quanlydiem/model/class.dart';
import 'package:quanlydiem/screen/login/controller/login_controller.dart';
import 'package:quanlydiem/services/api.dart';



class ClassesController extends GetxController {
  var apiState = ApiState.loading.obs;
  RxList<Class> listClass = <Class>[].obs;

  void loadData() async {
    final loginCtl = Get.find<LoginController>();
    try {
      listClass.value = await ApiService().getListClassByTeacher(
          loginCtl.userData.value.userId!);
      apiState.value = ApiState.success;
    } catch (e) {
      apiState.value = ApiState.failure;
    }
  }
}
