import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'task_model.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider() {
    loadTasks();
  }

  void addTask(Task task) {
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void updateTask(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      saveTasks();
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    saveTasks();
    notifyListeners();
  }

  void saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskList = _tasks.map((task) => json.encode(task.toJson())).toList();
    prefs.setStringList('tasks', taskList);
  }

  void loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskList = prefs.getStringList('tasks');
    if (taskList != null) {
      _tasks = taskList.map((task) => Task.fromJson(json.decode(task))).toList();
      notifyListeners();
    }
  }
}
