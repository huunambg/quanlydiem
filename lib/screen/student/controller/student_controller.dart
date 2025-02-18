import 'package:get/get.dart';
import 'package:quanlydiem/config/api_state.dart';
import 'package:quanlydiem/model/student.dart';
import 'package:quanlydiem/screen/login/controller/login_controller.dart';
import 'package:quanlydiem/services/api.dart';

class StudentController extends GetxController {
  var apiState = ApiState.loading.obs;
  RxList<Student> listStudent = <Student>[].obs;

  void loadData(int classId) async {
    final loginCtl = Get.find<LoginController>();
    apiState.value = ApiState.loading;
    try {
      listStudent.value =
          await ApiService().getStudentByClass(classId);
      apiState.value = ApiState.success;
    } catch (e) {
      apiState.value = ApiState.failure;
    }
  }
}
