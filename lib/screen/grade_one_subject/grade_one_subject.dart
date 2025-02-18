import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:quanlydiem/config/api_state.dart';
import 'package:quanlydiem/config/global_text_style.dart';
import 'package:quanlydiem/const/semester.dart';
import 'package:quanlydiem/model/class.dart';
import 'package:quanlydiem/model/grade_with_student.dart';
import 'package:quanlydiem/model/subject.dart';
import 'package:quanlydiem/screen/add_grade/add_grade_screen.dart';
import 'package:quanlydiem/screen/grade_one_subject/controller/grade_one_subject_controller.dart';
import 'package:quanlydiem/screen/update_grade/update_grade_screen.dart';
import 'package:quanlydiem/widget/body_background.dart';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class GradeOneSubjectScreen extends StatefulWidget {
  const GradeOneSubjectScreen(
      {super.key, required this.classes, required this.subject});
  final Class classes;
  final Subject subject;

  @override
  State<GradeOneSubjectScreen> createState() => _GradeOneSubjectScreenState();
}

class _GradeOneSubjectScreenState extends State<GradeOneSubjectScreen> {
  final gradeCtl = Get.find<GradeOneSubjectController>();

  Future<void> exportToExcel(List<GradeWithStudent> grades) async {
    // Yêu cầu quyền ghi file trên Android
    if (Platform.isAndroid) {
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        print("Không có quyền truy cập bộ nhớ");
        return;
      }
    }

    // Tạo workbook Excel
    var excel = Excel.createExcel();
    var sheet = excel['Bảng điểm'];

    // Thêm tiêu đề cột
    sheet.appendRow([
      TextCellValue('STT'),
      TextCellValue('Họ và Tên'),
      TextCellValue('GTX1'),
      TextCellValue('GTX2'),
      TextCellValue('GTX3'),
      TextCellValue('GTX4'),
      TextCellValue('ĐĐG Giữa Kỳ'),
      TextCellValue('ĐĐG Cuối Kỳ'),
      TextCellValue('ĐTB Môn Học Kỳ')
    ]);

// Duyệt danh sách và thêm dữ liệu vào Excel
    for (int i = 0; i < grades.length; i++) {
      GradeWithStudent grade = grades[i];
      sheet.appendRow([
        TextCellValue((i + 1).toString()), // STT
        TextCellValue(grade.fullName ?? ''),
        TextCellValue(grade.ddgtx1?.toString() ?? ''),
        TextCellValue(grade.ddgtx2?.toString() ?? ''),
        TextCellValue(grade.ddgtx3?.toString() ?? ''),
        TextCellValue(grade.ddgtx4?.toString() ?? ''),
        TextCellValue(grade.ddgGk?.toString() ?? ''),
        TextCellValue(grade.ddgCk?.toString() ?? ''),
        TextCellValue(grade.dtbMhk?.toString() ?? '')
      ]);
    }
    // Lưu file Excel
    var fileBytes = excel.save();
    Directory? directory;

    if (Platform.isAndroid) {
      directory =
          await getExternalStorageDirectory(); // Thư mục lưu trên Android
    } else {
      directory = await getApplicationDocumentsDirectory(); // Thư mục trên iOS
    }

    String filePath = '${directory!.path}/BangDiem${widget.subject.subjectName}.xlsx';
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    print('File Excel đã được lưu tại: $filePath');
  }

  @override
  void initState() {
    super.initState();
    gradeCtl.loadData(widget.classes.classId!, widget.subject.subjectId!);
    
  }

  @override
  Widget build(BuildContext context) {
    return BodyCustom(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.subject.subjectName!),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  PanaraConfirmDialog.show(
                    context,
                    title: "Xin chào",
                    message: "Bạn có muốn xuất bảng điểm ra file!",
                    confirmButtonText: "Xuất File",
                    cancelButtonText: "Quay lại",
                    onTapCancel: () {
                      Get.back();
                    },
                    onTapConfirm: () {
                      Get.back();
                      Future.delayed(
                        1.seconds,
                        () {
                          exportToExcel(gradeCtl.getListGradleSemester());
                        },
                      );
                    },
                    panaraDialogType: PanaraDialogType.normal,
                    barrierDismissible: false,
                  );
                },
                icon: const Icon(Icons.ios_share_rounded)),
            IconButton(
                onPressed: () {
                  Get.to(AddGradeScreen(
                    classes: widget.classes,
                    semester:
                        gradeCtl.semester == Semester.semester1 ? "1" : "2",
                    subjectId: widget.subject.subjectId!,
                  ));
                },
                icon: const Icon(Icons.add)),
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
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Obx(() {
            switch (gradeCtl.apiState.value) {
              case ApiState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ApiState.success:
                if (gradeCtl.getListGradleSemester().isEmpty) {
                  return const Center(
                    child: Text("Chưa có điểm của học sinh nào."),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 16,
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.blueGrey.shade100),
                    dataRowColor: MaterialStateColor.resolveWith((states) =>
                        states.contains(MaterialState.hovered)
                            ? Colors.blue.shade50
                            : Colors.white),
                    columns: const [
                      DataColumn(label: Text("Họ và Tên")),
                      DataColumn(label: Text("GTX1")),
                      DataColumn(label: Text("GTX2")),
                      DataColumn(label: Text("GTX3")),
                      DataColumn(label: Text("GTX4")),
                      DataColumn(label: Text("ĐĐGgk")),
                      DataColumn(label: Text("ĐĐGck")),
                      DataColumn(label: Text("ĐTBmhk")),
                      DataColumn(label: Text("Thao tác")),
                    ],
                    rows: gradeCtl
                        .getListGradleSemester()
                        .map((GradeWithStudent grade) {
                      return DataRow(
                        cells: [
                          DataCell(Text(
                            grade.fullName!,
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
                          DataCell(ElevatedButton(
                            child: Text("Sửa"),
                            onPressed: () {
                              Get.to(UpdateGradeScreen(grade: grade));
                            },
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
