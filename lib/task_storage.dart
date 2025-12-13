import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'task.dart';

class TaskStorage {
  static const _key = 'tasks';

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];

    final List decoded = jsonDecode(raw);
    return decoded.map((e) => Task.fromJson(e)).toList();
  }

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(tasks.map((t) => t.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  static Future<void> addTask(Task task) async {
    final tasks = await loadTasks();
    tasks.insert(0, task);
    await saveTasks(tasks);
  }
}
