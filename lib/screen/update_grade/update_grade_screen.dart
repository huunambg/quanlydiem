import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlydiem/config/global_text_style.dart';
import 'package:quanlydiem/model/class.dart';
import 'package:quanlydiem/model/grade.dart';
import 'package:quanlydiem/model/grade_with_student.dart';
import 'package:quanlydiem/model/student.dart';
import 'package:quanlydiem/screen/add_grade/controller/add_grade_controller.dart';
import 'package:quanlydiem/screen/grade_one_subject/controller/grade_one_subject_controller.dart';
import 'package:quanlydiem/widget/button.dart';

class UpdateGradeScreen extends StatefulWidget {
  const UpdateGradeScreen({super.key, required this.grade});
  final GradeWithStudent grade;
  @override
  _UpdateGradeScreenState createState() => _UpdateGradeScreenState();
}

class _UpdateGradeScreenState extends State<UpdateGradeScreen> {
  final TextEditingController _ddgtx1Controller = TextEditingController();
  final TextEditingController _ddgtx2Controller = TextEditingController();
  final TextEditingController _ddgtx3Controller = TextEditingController();
  final TextEditingController _ddgtx4Controller = TextEditingController();
  final TextEditingController _ddgGkController = TextEditingController();
  final TextEditingController _ddgCkController = TextEditingController();
  final TextEditingController _dtbMhkController = TextEditingController();
  final gradeCtl = Get.find<GradeOneSubjectController>();
  List<TextEditingController> controllers = [];
  void updateGrade() {
    List<TextEditingController> controllers = [
      _ddgtx1Controller,
      _ddgtx2Controller,
      _ddgtx3Controller,
      _ddgtx4Controller,
      _ddgGkController,
      _ddgCkController,
      _dtbMhkController
    ];

    for (var controller in controllers) {
      if (controller.text.isEmpty) {
        CherryToast.error(title: const Text("Không được để trống điểm"))
            .show(context);
        return;
      }
    }

    double? parseScore(String text) {
      double? value = double.tryParse(text);
      if (value == null || value < 0 || value > 10) {
        return null;
      }
      return value;
    }

    double? ddgtx1 = parseScore(_ddgtx1Controller.text);
    double? ddgtx2 = parseScore(_ddgtx2Controller.text);
    double? ddgtx3 = parseScore(_ddgtx3Controller.text);
    double? ddgtx4 = parseScore(_ddgtx4Controller.text);
    double? ddgGk = parseScore(_ddgGkController.text);
    double? ddgCk = parseScore(_ddgCkController.text);
    double? dtbMhk = parseScore(_dtbMhkController.text);
    if ([ddgtx1, ddgtx2, ddgtx3, ddgtx4, ddgGk, ddgCk, dtbMhk].contains(null)) {
      CherryToast.error(title: const Text("Điểm phải từ 0 đến 10"))
          .show(context);
      return;
    }

    Grade grade = Grade(
      gradeId: widget.grade.gradeId,
      studentId: widget.grade.studentId,
      classId: widget.grade.classId,
      subjectId: widget.grade.subjectId,
      academicYear: widget.grade.academicYear,
      ddgtx1: ddgtx1!,
      ddgtx2: ddgtx2!,
      ddgtx3: ddgtx3!,
      ddgtx4: ddgtx4!,
      ddgCk: ddgCk!,
      ddgGk: ddgGk!,
      semester: widget.grade.semester,
      dtbMhk: dtbMhk,
    );

    gradeCtl.updateGrade(grade).then(
      (value) {
        for (var controller in controllers) {
          controller.clear();
        }

        int index = gradeCtl.listGrade.indexWhere(
          (element) => element.gradeId == widget.grade.gradeId,
        );

        gradeCtl.listGrade[index] = gradeCtl.listGrade[index].copyWith(
            ddgCk: grade.ddgCk,
            ddgGk: grade.ddgGk,
            ddgtx1: grade.ddgtx1,
            ddgtx2: grade.ddgtx2,
            ddgtx3: grade.ddgtx3,
            ddgtx4: grade.ddgtx4,
            dtbMhk: grade.dtbMhk);
        CherryToast.success(title: const Text("Cập nhật điểm thành công"))
            .show(context);
      },
    ).catchError((e) {
      print(e);
    });
  }

  void calculateAverage() {
    double? ddgtx1 = double.tryParse(_ddgtx1Controller.text);
    double? ddgtx2 = double.tryParse(_ddgtx2Controller.text);
    double? ddgtx3 = double.tryParse(_ddgtx3Controller.text);
    double? ddgtx4 = double.tryParse(_ddgtx4Controller.text);
    double? ddgGk = double.tryParse(_ddgGkController.text);
    double? ddgCk = double.tryParse(_ddgCkController.text);

    if ([ddgtx1, ddgtx2, ddgtx3, ddgtx4, ddgGk, ddgCk].contains(null)) {
      // Nếu bất kỳ điểm nào chưa được nhập, đặt ĐTB là 0
      _dtbMhkController.text = '0';
    } else {
      // Nếu tất cả điểm đã được nhập, tính ĐTB
      double dtbMhk =
          (ddgtx1! + ddgtx2! + ddgtx3! + ddgtx4! + ddgGk! * 2 + ddgCk! * 3) / 9;
      _dtbMhkController.text = dtbMhk.toStringAsFixed(1);
    }
  }

  void setupTextControllerListeners() {
    controllers = [
      _ddgtx1Controller,
      _ddgtx2Controller,
      _ddgtx3Controller,
      _ddgtx4Controller,
      _ddgGkController,
      _ddgCkController,
    ];

    for (var controller in controllers) {
      controller.addListener(calculateAverage);
    }
  }

  @override
  void initState() {
    _ddgtx1Controller.text = widget.grade.ddgtx1.toString();
    _ddgtx2Controller.text = widget.grade.ddgtx2.toString();
    _ddgtx3Controller.text = widget.grade.ddgtx3.toString();
    _ddgtx4Controller.text = widget.grade.ddgtx4.toString();
    _ddgGkController.text = widget.grade.ddgCk.toString();
    _ddgCkController.text = widget.grade.ddgCk.toString();
    _dtbMhkController.text = widget.grade.dtbMhk.toString();
    setupTextControllerListeners();
    super.initState();
  }

  @override
  void dispose() {
    _ddgtx1Controller.dispose();
    _ddgtx2Controller.dispose();
    _ddgtx3Controller.dispose();
    _ddgtx4Controller.dispose();
    _ddgGkController.dispose();
    _ddgCkController.dispose();
    _dtbMhkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nhập điểm"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildTextField("Điểm TX1", _ddgtx1Controller),
            _buildTextField("Điểm TX2", _ddgtx2Controller),
            _buildTextField("Điểm TX3", _ddgtx3Controller),
            _buildTextField("Điểm TX4", _ddgtx4Controller),
            _buildTextField("Điểm GK", _ddgGkController),
            _buildTextField("Điểm CK", _ddgCkController),
            _buildTextField("Điểm TB", _dtbMhkController),
            const SizedBox(height: 20),
            ButtonCustom(
                onTap: () {
                  updateGrade();
                },
                title: "Cập nhật điểm")
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: GlobalTextStyles.font14w600ColorWhite
              .copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 4.0,
        ),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
      ],
    );
  }
}
