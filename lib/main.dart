import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlydiem/firebase_options.dart';
import 'package:quanlydiem/screen/splash/splash.dart';
import 'package:quanlydiem/services/notification.dart';
import 'dependecy_injection.dart' as dependecy_injection;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService().initNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await dependecy_injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Quản lý điểm học sinh',
      home: SplashScreen(),
    );
  }
}
