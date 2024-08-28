import 'package:flutter/material.dart';

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
          child: ElevatedButton(
            onPressed: () {
              NotificationService().showNotification(
                id: 1,
                title: 'Hello!',
                body: 'This is a local notification.',
              );
            },
            child: const Text('Show Notification'),
          ),
        ),
      ),
    );
  }
}
