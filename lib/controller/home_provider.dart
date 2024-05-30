import 'package:flutter/material.dart';
import 'package:task/model/task_model.dart';
import 'package:task/service/database_service.dart';

class HomeProvider extends ChangeNotifier {
  DateTime dateTime = DateTime.now();
  Duration estimatedTime = Duration();

  void selectDateTime(DateTime date) {
    dateTime = date;
    notifyListeners();
  }

  void selectEstimatedTime(Duration time) {
    estimatedTime = time;
    notifyListeners();
  }

  Future<Duration?> pickDuration(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timeOfDay != null) {
      return Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
    }
    return null;
  }
  Future<void>toggleCompletedTask(String taskId)async{
    try {
      await DataBaseService().compltedTasks(taskId);
      notifyListeners();
    } catch (e) {
      Exception(e);
    }
  }

  Stream<List<TaskModel>> getDatas() {
    try {
      return DataBaseService().getDatas();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addTask({
    String? title,
    String? description,
    DateTime? dateTime,
    Duration? estimatedTime,
  }) async {
    try {
      await DataBaseService().addTask(
        title: title,
        description: description,
        dateTime: dateTime,
        estimatedTime: estimatedTime,
      );
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<void> updateTask({
    String?id,
    String? title,
    String? description,
    DateTime? dateTime,
    Duration? estimatedTime,
  }) async {
    try {
      await DataBaseService().updateTask(
        taskId: id!,
        title: title,
        description: description,
        dateTime: dateTime,
        estimatedTime: estimatedTime,
      );
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<void>deleteTask(String taskId)async{
    try {
      await DataBaseService().deleteTask(taskId);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}
