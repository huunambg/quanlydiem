import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlydiem/config/api_state.dart';
import 'package:quanlydiem/config/global_text_style.dart';
import 'package:quanlydiem/const/semester.dart';
import 'package:quanlydiem/model/grade.dart';
import 'package:quanlydiem/model/student.dart';
import 'package:quanlydiem/screen/grade_all_subject/controller/grade_controller.dart';
import 'package:quanlydiem/widget/body_background.dart';

class GradeScreen extends StatefulWidget {
  const GradeScreen({super.key, required this.classId, required this.student});
  final int classId;
  final Student student;

  @override
  State<GradeScreen> createState() => _GradeScreenState();
}

class _GradeScreenState extends State<GradeScreen> {
  final gradeCtl = Get.find<GradeAllSubjectController>();

  @override
  void initState() {
    super.initState();
    gradeCtl.loadData(widget.classId, widget.student.studentId!);
  }

  @override
  Widget build(BuildContext context) {
    return BodyCustom(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Bảng điểm"),
          actions: [
            PopupMenuButton<Semester>(
              icon: const Icon(Icons.more_vert),
              onSelected: (Semester value) {
                gradeCtl.semester.value = value;
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Semester>>[
                const PopupMenuItem<Semester>(
                  value: Semester.semester1,
                  child: Text("Học kỳ 1"),
                ),
                const PopupMenuItem<Semester>(
                  value: Semester.semester2,
                  child: Text("Học kỳ 2"),
                ),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            switch (gradeCtl.apiState.value) {
              case ApiState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ApiState.success:
                if (gradeCtl.getListGradleSemester().isEmpty) {
                  return const Center(
                    child: Text("Chưa có điểm môn học nào."),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text("Tên môn học")),
                      DataColumn(label: Text("GTX1")),
                      DataColumn(label: Text("GTX2")),
                      DataColumn(label: Text("GTX3")),
                      DataColumn(label: Text("GTX4")),
                      DataColumn(label: Text("ĐĐGgk")),
                      DataColumn(label: Text("ĐĐGck")),
                      DataColumn(label: Text("ĐTBmhk")),
                      DataColumn(label: Text("Hành động")),
                    ],
                    rows: gradeCtl.getListGradleSemester().map((Grade grade) {
                      return DataRow(
                        cells: [
                          DataCell(Text(
                            gradeCtl.getSubject(grade.subjectId!).subjectName!,
                            style: GlobalTextStyles.font16w600Color8A96B2
                                .copyWith(color: Colors.black),
                          )),
                          DataCell(Text(
                            grade.ddgtx1!.toString(),
                            style: GlobalTextStyles.font16w600Color8A96B2
                                .copyWith(color: Colors.black),
                          )),
                          DataCell(Text(
                            grade.ddgtx2!.toString(),
                            style: GlobalTextStyles.font16w600Color8A96B2
                                .copyWith(color: Colors.black),
                          )),
                          DataCell(Text(
                            grade.ddgtx3!.toString(),
                            style: GlobalTextStyles.font16w600Color8A96B2
                                .copyWith(color: Colors.black),
                          )),
                          DataCell(Text(
                            grade.ddgtx4!.toString(),
                            style: GlobalTextStyles.font16w600Color8A96B2
                                .copyWith(color: Colors.black),
                          )),
                          DataCell(Text(
                            grade.ddgGk!.toString(),
                            style: GlobalTextStyles.font16w600Color8A96B2
                                .copyWith(color: Colors.black),
                          )),
                          DataCell(Text(
                            grade.ddgCk!.toString(),
                            style: GlobalTextStyles.font16w600Color8A96B2
                                .copyWith(color: Colors.black),
                          )),
                          DataCell(Text(
                            grade.dtbMhk!.toString(),
                            style: GlobalTextStyles.font16w600Color8A96B2
                                .copyWith(color: Colors.black),
                          )),
                          const DataCell(const Icon(
                            Icons.edit_document,
                            color: Colors.black,
                          )),
                        ],
                      );
                    }).toList(),
                  ),
                );
              case ApiState.failure:
                return const Center(
                  child: Text("Error loading grades"),
                );
            }
          }),
        ),
      ),
    );
  }
}
