import 'package:flutter/material.dart';
import 'models/task.dart';
import 'services/task_storage.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  Future<void> _reload() async {
    setState(() => loading = true);
    tasks = await TaskStorage.loadTasks();
    setState(() => loading = false);
  }

  Future<void> _toggleDone(int index, bool value) async {
    setState(() {
      tasks[index].isDone = value;
    });
    await TaskStorage.saveTasks(tasks);
  }

  Future<void> _deleteTask(String id) async {
    await TaskStorage.deleteTask(id);
    await _reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task List')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : tasks.isEmpty
          ? const Center(child: Text('No tasks yet.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final t = tasks[i];

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.pink.shade100,
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: t.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            if (t.description.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                t.description,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  decoration: t.isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      Checkbox(
                        value: t.isDone,
                        onChanged: (v) {
                          if (v == null) return;
                          _toggleDone(i, v);
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _deleteTask(t.id),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
