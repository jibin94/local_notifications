# Flutter local notifications
Flutter Local Notifications is a package that allows Flutter developers to display local notifications within their apps on Android, iOS, and Web platforms. We can display custom notifications from the apps without depending on the external factors. Whatever actions we do within the app and want to notify the users about their action or show any message in response, we use Local Notifications for that.

## Setup

**Step 1**: Add the dependency <br />

Run the following command in your terminal.<br />
```
flutter pub add flutter_local_notifications
```
Alternatively, you can add this to your pubspec.yaml file under dependencies. Make sure you get the latest from pub.dev.<br />
flutter_local_notifications: ^latest-version

**Step 2**: iOS — Modify App Delegate
Navigate to ios/Runner/AppDelegate.swift

In the `didFinishLaunchingWithOptions` method, add the following code
```
if #available(iOS 10.0, *) {
UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}
```

**Step 3**: LocalNotificationService

Create a notification_service class.<br />
3.1 Add the following import
```
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
```

3.2 Define a private `FlutterNotificationPluginVariable`
```
final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
```
3.3 Create a method called setup to initialize the plugin for each platform.

**Step 4**: Call the setup method
In the main.dart, make a call to setup method that we just defined in the service after `WidgetsFlutterBinding.ensureInitialized()` but before `runApp(const MyApp())`.
```
void main() async {
WidgetsFlutterBinding.ensureInitialized();
// Initialize the NotificationService
await NotificationService().init();
runApp(const MyApp());
}
```

**Step 5**: Write a simple method to show local notification.
```
Future<void> showNotification({
required int id,
required String title,
required String body,
}) async {
await flutterLocalNotificationsPlugin.show(id, title, body, platformChannelSpecifics);
}
```

**Step 6**: Call the show local notification method.
```
NotificationService().showNotification(
id: 1,
title: 'Hello!',
body: 'This is a local notification.',
);
```

We will see each property.

`id` – the identifier of the notification. Each notification must have a unique identifier.<br />
`title` – the title of the notification.<br />
`body` – what we want to display as the main message of our notification.<br />
`notificationDetails` – the notification details object we discussed above.<br />
`payload` – the data that we want to pass with this notification so that it can be used later when the notification is tapped on and our application opens up again.

Methods provided by the `FlutterLocalNotificationsPlugin`:

`show` – Displays a simple notification immediately. It shows a title, body, and can include a payload for additional data. This type of notification is typically used for alerts, reminders, or updates that need immediate user attention.<br />
`zonedSchedule` – This type of notification is scheduled to be displayed at a specific time within a defined time zone. The zonedSchedule method allows you to account for time zone differences, ensuring that the notification triggers at the correct local time, regardless of where the user is located.<br />
`periodicallyShow` – Sets up a notification to be shown repeatedly at a specified interval (e.g., hourly, daily, weekly). This notification can help with recurring reminders.

Cancel Notification:

`cancel(id)` – Cancels a previously scheduled or shown notification by its ID. This method ensures that a notification doesn't appear if it's no longer relevant.<br />
`cancelAll()` – Cancels all notifications that have been scheduled or displayed. This method is useful when a reset is needed, such as clearing all reminders after a user session ends.
