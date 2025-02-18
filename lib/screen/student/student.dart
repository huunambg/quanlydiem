import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:quanlydiem/config/api_state.dart';
import 'package:quanlydiem/config/global_text_style.dart';
import 'package:quanlydiem/model/class.dart';
import 'package:quanlydiem/model/student.dart';
import 'package:quanlydiem/screen/grade_all_subject/grade_all_subject.dart';
import 'package:quanlydiem/screen/student/controller/student_controller.dart';

import 'package:quanlydiem/widget/body_background.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key, required this.classes});
  final Class classes;
  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final studentCtl = Get.find<StudentController>();

  @override
  void initState() {
    super.initState();
    studentCtl.loadData(widget.classes.classId!);
  }

  @override
  Widget build(BuildContext context) {
    return BodyCustom(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.classes.className!),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                switch (studentCtl.apiState.value) {
                  case ApiState.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ApiState.success:
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: studentCtl.listStudent.length,
                      itemBuilder: (context, index) {
                        Student student = studentCtl.listStudent[index];
                        return GestureDetector(
                          onTap: () => Get.to(() => GradeAllSubjectScreen(
                              classId: widget.classes.classId!, student: student)),
                          child: Card(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 24.0),
                                    decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12.0),
                                            bottomLeft: Radius.circular(12.0))),
                                    child: Text(
                                      (index + 1).toString(),
                                      style:
                                          GlobalTextStyles.font16w600ColorWhite,
                                    ),
                                  ),
                                ),
                                const Gap(16),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    student.fullName!,
                                    style:
                                        GlobalTextStyles.font16w600Color8A96B2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  case ApiState.failure:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
          )
        ],
      ),
    ));
  }
}
