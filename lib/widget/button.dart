import 'package:flutter/material.dart';
import 'package:quanlydiem/config/global_color.dart';
import 'package:quanlydiem/config/global_text_style.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({super.key, required this.onTap, required this.title});
  final String title;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: GlobalColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          title,
          style: GlobalTextStyles.font14w600ColorWhite,
        ),
      ),
    );
  }
}
