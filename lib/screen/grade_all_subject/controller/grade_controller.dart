import 'package:get/get.dart';
import 'package:quanlydiem/config/api_state.dart';
import 'package:quanlydiem/const/semester.dart';
import 'package:quanlydiem/model/grade.dart';
import 'package:quanlydiem/model/subject.dart';
import 'package:quanlydiem/screen/login/controller/login_controller.dart';
import 'package:quanlydiem/services/api.dart';

class GradeAllSubjectController extends GetxController {
  var apiState = ApiState.loading.obs;
  RxList<Grade> listGrade = <Grade>[].obs;
  RxList<Subject> listSubject = <Subject>[].obs;
  Rx<Semester> semester = Semester.semester1.obs;
  @override
  void onInit() {
    loadSubject();
    super.onInit();
  }

  void loadSubject() async {
    final loginCtl = Get.find<LoginController>();
    try {
      listSubject.value = await ApiService().getSubject(loginCtl.accessToken);
    } catch (e) {
      print(e);
    }
  }

  Subject getSubject(int id) {
    for (var element in listSubject) {
      if (element.subjectId == id) return element;
    }
    return Subject();
  }

  List<Grade> getListGradleSemester() {
    if (semester == Semester.semester1) {
      return listGrade
          .where(
            (p0) => p0.semester == "1",
          )
          .toList();
    } else {
      return listGrade
          .where(
            (p0) => p0.semester == "2",
          )
          .toList();
    }
  }

  void loadData(int classId, int studentId) async {
    final loginCtl = Get.find<LoginController>();
    apiState.value = ApiState.loading;
    try {
      listGrade.value = await ApiService()
          .getGradeByClassAndStudent(classId, studentId);
      apiState.value = ApiState.success;
    } catch (e) {
      apiState.value = ApiState.failure;
    }
  }
}
