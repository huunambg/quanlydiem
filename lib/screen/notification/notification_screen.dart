import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final CollectionReference notifications =
      FirebaseFirestore.instance.collection('Notifications');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
        centerTitle: true,
       
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            notifications.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Lỗi khi tải dữ liệu'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Không có thông báo'));
          }
          final notificationDocs = snapshot.data!.docs;


          return ListView.builder(
            itemCount: notificationDocs.length,
            itemBuilder: (context, index) {
              final notification = notificationDocs[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  title: Text(notification['title'] ?? 'Không có tiêu đề'),
                  subtitle:
                      Text(notification['message'] ?? 'Không có nội dung'),
                  trailing: Text(
                    // Kiểm tra và xử lý giá trị timestamp
                    notification['time'] != null
                        ? formatTimestampToDate(
                            DateTime.parse(notification['time']))
                        : 'Không có thời gian',
                    style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String formatTimestampToDate(DateTime dateTime) {


    // Định dạng DateTime thành chuỗi theo định dạng "dd/MM/yyyy HH:mm"
    final String formattedDate =
        DateFormat('dd/MM/yyyy HH:mm').format(dateTime);

    return formattedDate;
  }
}
