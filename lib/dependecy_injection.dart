import 'package:quanlydiem/screen/add_grade/controller/add_grade_controller.dart';
import 'package:quanlydiem/screen/grade_all_subject/controller/grade_controller.dart';
import 'package:quanlydiem/screen/grade_one_subject/controller/grade_one_subject_controller.dart';
import 'package:quanlydiem/screen/splash/controller/splash_controller.dart';
import 'package:quanlydiem/screen/student/controller/student_controller.dart';
import 'package:quanlydiem/screen/subject/controller/subject_controller.dart';

import '/util/preferences_util.dart';
import 'package:get/get.dart';

import 'screen/classes/controller/home_controller.dart';
import 'screen/login/controller/login_controller.dart';

Future<void> init() async {
  await PreferencesUtil.init();

  final loginController = LoginController();
  Get.lazyPut(() => loginController, fenix: true);
  final splashController = SplashController();
  Get.lazyPut(() => splashController, fenix: true);
  final classesController = ClassesController();
  Get.lazyPut(() => classesController, fenix: true);
  final studentController = StudentController();
  Get.lazyPut(() => studentController, fenix: true);
  final gradeAllSubjectController = GradeAllSubjectController();
  Get.lazyPut(() => gradeAllSubjectController, fenix: true);
  final subjectController = SubjectController();
  Get.lazyPut(() => subjectController, fenix: true);
  final gradeOneSubjectController = GradeOneSubjectController();
  Get.lazyPut(() => gradeOneSubjectController, fenix: true);
  final addGradeController = AddGradeController();
  Get.lazyPut(() => addGradeController, fenix: true);

  
}
