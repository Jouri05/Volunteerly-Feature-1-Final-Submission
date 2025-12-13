class Task {
  final String id;
  final String title;
  final String description;
  bool isDone;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'isDone': isDone,
  };

  static Task fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    isDone: json['isDone'] ?? false,
  );
}
