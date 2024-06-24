class Task {
  String id;
  String title;
  String description;
  String category;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.category = '',
    this.isCompleted = false,
  });

  // Convert a Task into a Map. The keys must correspond to the names of the attributes.
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'isCompleted': isCompleted,
      };

  // Extract a Task object from a Map.
  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        category: json['category'],
        isCompleted: json['isCompleted'],
      );
}
