import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:quanlydiem/config/api_state.dart';
import 'package:quanlydiem/config/global_text_style.dart';
import 'package:quanlydiem/model/class.dart';
import 'package:quanlydiem/model/subject.dart';
import 'package:quanlydiem/screen/grade_one_subject/grade_one_subject.dart';
import 'package:quanlydiem/screen/subject/controller/subject_controller.dart';
import 'package:quanlydiem/widget/body_background.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key, required this.classes});
  final Class classes;
  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final subjectCtl = Get.find<SubjectController>();

  @override
  void initState() {
    super.initState();
    subjectCtl.loadSubject();
  }

  @override
  Widget build(BuildContext context) {
    return BodyCustom(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.classes.className!, style: GlobalTextStyles.font18w700ColorWhite),
          backgroundColor: Colors.blue.shade700,
          elevation: 4,
       
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () {
                  switch (subjectCtl.apiState.value) {
                    case ApiState.loading:
                      return const Center(child: CircularProgressIndicator());
                    case ApiState.success:
                      return ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: subjectCtl.listSubject.length,
                        itemBuilder: (context, index) {
                          Subject subject = subjectCtl.listSubject[index];
                          return GestureDetector(
                            onTap: () => Get.to(
                              () => GradeOneSubjectScreen(classes: widget.classes, subject: subject),
                            ),
                            child: Card(
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.blue.shade400, Colors.blue.shade700],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12.0),
                                        bottomLeft: Radius.circular(12.0),
                                      ),
                                    ),
                                    child: Text(
                                      (index + 1).toString(),
                                      style: GlobalTextStyles.font16w600ColorWhite,
                                    ),
                                  ),
                                  const Gap(16),
                                  Expanded(
                                    child: Text(
                                      subject.subjectName!,
                                      style: GlobalTextStyles.font16w600Color8A96B2,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 16),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.blueAccent,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    case ApiState.failure:
                      return const Center(child: Text("Failed to load subjects", style: TextStyle(fontSize: 16, color: Colors.red)));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}