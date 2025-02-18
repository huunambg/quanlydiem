import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlydiem/config/global_text_style.dart';
import 'package:quanlydiem/model/class.dart';
import 'package:quanlydiem/screen/student/student.dart';
import 'package:quanlydiem/screen/subject/subject.dart';

class ItemClassCustom extends StatelessWidget {
  const ItemClassCustom(
      {super.key, required this.classes, required this.isHome});
  final Class classes;
  final bool isHome;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isHome) {
          Get.to(() => StudentScreen(
                classes: classes,
              ));
        } else {
          Get.to(() => SubjectScreen(
                classes: classes,
              ));
        }
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                      color: Colors.blue,
                    ),
                    width: double.infinity,
                    child: Text(
                      classes.className!,
                      style: GlobalTextStyles.font16w600ColorWhite,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
