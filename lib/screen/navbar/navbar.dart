import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:quanlydiem/screen/account/account.dart';
import 'package:quanlydiem/screen/classes/classes_screen.dart';
import 'package:quanlydiem/screen/home/home_screen.dart';
import 'package:quanlydiem/screen/notification/notification_screen.dart';
import 'package:quanlydiem/services/notification.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;
  final tab = [const HomeScreen(), ClassesScreen(), NotificationScreen(), AcountScreen()];



Future<void> setupInteractedMessage() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();

  debugPrint(token);


  await messaging.subscribeToTopic('news');
  debugPrint('Subscribed to news topic');

  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Received a foreground message: ${message.notification?.body}');
    NotificationService().showNotification(
        title: message.notification?.title, body: message.notification?.body);
  });

  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

void _handleMessage(RemoteMessage message) {
  // Đây là nơi xử lý khi nhận được thông báo từ topic
  debugPrint("Handling message: ${message.messageId}");
  // Bạn có thể thêm logic xử lý tại đây
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupInteractedMessage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tab[_currentIndex],
      bottomNavigationBar: GNav(
        tabMargin: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 2.0),
          onTabChange: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          tabBorderRadius: 15,
          gap: 8, 
          activeColor: Colors.purple, 
          iconSize: 24, 
          tabBackgroundColor:
              Colors.purple.withOpacity(0.1), 
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 5),
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Lớp',
            ),
            GButton(
              icon: Icons.subject_outlined,
              text: 'Môn học',
            ),
            GButton(
              icon: Icons.notifications_outlined,
              text: 'Thông báo',
            ),
            GButton(
              icon: Icons.settings_outlined,
              text: 'Cài đặt',
            )
          ]),
    );
  }
}
