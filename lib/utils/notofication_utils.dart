    import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task/model/task_model.dart';

Future<void> requestNotificationPermissions() async {
    var status = await Permission.notification.request();
    if (status.isGranted) {
      print('Notification permission granted');
    } else if (status.isDenied) {
      print('Notification permission denied');
    } else if (status.isPermanentlyDenied) {
      print('Notification permission permanently denied');
      openAppSettings();
    }
  }
  void scheduleNotification(TaskModel task, DateTime scheduledDateTime) {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: task.id.hashCode,
      channelKey: 'basic_channel',
      title: 'Task Reminder',
      body: '${task.title} is due in 10 minutes',
    ),
    schedule: NotificationInterval(
      interval: 10, 
      repeats: false,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'view',
        label: 'View Task',
        autoDismissible: true,
      ),
    ],
  );
}