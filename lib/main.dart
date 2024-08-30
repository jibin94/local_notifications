import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
// Initialize the NotificationService
  await NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text(
            'Local Notification',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              notificationButton(
                "Show Notification",
                () => NotificationService().showNotification(
                  id: 1,
                  title: 'Hello!',
                  body: 'This is a local notification.',
                ),
              ),
              notificationButton(
                "Schedule Notification",
                () => NotificationService().scheduleNotification(
                  id: 2,
                  title: 'Scheduled Notification',
                  body:
                      'This notification is scheduled to appear after 5 seconds.',
                  scheduledNotificationDateTime:
                      DateTime.now().add(const Duration(seconds: 5)),
                ),
              ),
              notificationButton(
                "Schedule Periodic Notification",
                () => NotificationService().schedulePeriodicNotification(
                  id: 3,
                  title: 'Periodic Notification',
                  body: 'This notification will repeat every minute.',
                  repeatInterval: RepeatInterval.everyMinute,
                ),
              ),
              notificationButton(
                "Cancel All Notifications",
                () => NotificationService().cancelNotification(0),
              ),
              notificationButton(
                "Cancel All Notifications",
                () => NotificationService().cancelAllNotifications(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget notificationButton(String title, Function? function) {
    return ElevatedButton(
      onPressed: () => function!(),
      child: Text(title),
    );
  }
}
