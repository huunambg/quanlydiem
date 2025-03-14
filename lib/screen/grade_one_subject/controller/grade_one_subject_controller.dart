import 'package:get/get.dart';
import 'package:quanlydiem/config/api_state.dart';
import 'package:quanlydiem/const/semester.dart';
import 'package:quanlydiem/model/grade.dart';
import 'package:quanlydiem/model/grade_with_student.dart';
import 'package:quanlydiem/screen/login/controller/login_controller.dart';
import 'package:quanlydiem/services/api.dart';

class GradeOneSubjectController extends GetxController {
  var apiState = ApiState.loading.obs;
  RxList<GradeWithStudent> listGrade = <GradeWithStudent>[].obs;
  Rx<Semester> semester = Semester.semester1.obs;

  List<GradeWithStudent> getListGradleSemester() {
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

  void loadData(int classId, int subjectId) async {
    final loginCtl = Get.find<LoginController>();
    apiState.value = ApiState.loading;
    try {
      listGrade.value =
          await ApiService().getGradeBySubjectClass(classId, subjectId);
      apiState.value = ApiState.success;
    } catch (e) {
      apiState.value = ApiState.failure;
    }
  }

  Future<void> updateGrade(Grade grade) async {
    await ApiService().updateGrade(grade);
  }

  Future<void> deleteGrade(int id) async {
    await ApiService().deleteGrade(id);
  }
}
