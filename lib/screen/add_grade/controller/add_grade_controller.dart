import 'package:get/get.dart';
import 'package:quanlydiem/model/grade.dart';
import 'package:quanlydiem/model/grade_with_student.dart';
import 'package:quanlydiem/model/student.dart';
import 'package:quanlydiem/screen/grade_one_subject/controller/grade_one_subject_controller.dart';
import 'package:quanlydiem/services/api.dart';

class AddGradeController extends GetxController {
  RxList<Student> listStudentNotHaveGrade = <Student>[].obs;

  void getlistStudentNotHaveGrade(int classId) async {
    List<Student> listStudent = await ApiService().getStudentByClass(classId);
    final List<GradeWithStudent> listGrade =
        Get.find<GradeOneSubjectController>().listGrade;

    for (var element in listGrade) {
      int index =
          listStudent.indexWhere((e) => e.studentId == element.studentId);
      listStudent.removeAt(index);
    }
    listStudentNotHaveGrade.value = listStudent;
  }

  Future<void> addGrade(Grade grade) async {
    await ApiService().addGrade(grade);
  }
}
