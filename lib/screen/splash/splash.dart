import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlydiem/config/global_color.dart';
import 'package:quanlydiem/config/global_text_style.dart';
import 'package:quanlydiem/screen/splash/controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashCtl = Get.find<SplashController>();
  @override
  void initState() {
    super.initState();
    splashCtl.handleNavigate();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: GlobalColors.primary,
        body: Column(
          children: [
            const Spacer(),
            Center(
              child: Image.asset(
                'assets/images/logo_splash.png',
                width: 160.0,
                height: 160.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Spacer(),
            SizedBox(
              width: w * 0.66,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(63.0),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white.withOpacity(0.4),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "Vui lòng chờ",
                    style: GlobalTextStyles.font12w400ColorWhite,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
