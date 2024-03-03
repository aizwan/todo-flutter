class Todo {
  String? id;
  String? todoText;
  bool isDone = false;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todoText = json['title'];
    isDone = json['isCompleted'];
  }
}
