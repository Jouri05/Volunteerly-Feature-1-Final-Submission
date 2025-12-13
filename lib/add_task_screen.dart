import 'package:flutter/material.dart';
import 'task.dart';
import 'task_storage.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedPriority;
  final List<String> priorities = ["Low", "Medium", "High"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Log Hours"),
            const SizedBox(height: 5),
            TextField(
              controller: hoursController,
              decoration: const InputDecoration(
                hintText: "e.g. 2",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            const Text("Priority Level"),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              value: selectedPriority,
              items: priorities.map((level) {
                return DropdownMenuItem(value: level, child: Text(level));
              }).toList(),
              onChanged: (value) {
                setState(() => selectedPriority = value);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Select priority",
              ),
            ),
            const SizedBox(height: 20),
            const Text("Due Date"),
            const SizedBox(height: 5),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                hintText: "DD/MM/YYYY",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Description"),
            const SizedBox(height: 5),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade200,
                ),
                onPressed: () {},
                child: const Text(
                  "Done",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade200,
                ),
                onPressed: () {},
                child: const Text(
                  "Delete",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
