class Todo {
  final int? id;
  final String todo;
  final bool completed;
  final int? userId;
  final bool? isDeleted;
  final String? deletedOn;

  Todo({
    this.id,
    required this.todo,
    required this.completed,
    this.userId,
    this.isDeleted,
    this.deletedOn,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      todo: json['todo'] ?? '',
      completed: json['completed'] ?? false,
      userId: json['userId'],
      isDeleted: json['isDeleted'],
      deletedOn: json['deletedOn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todo': todo,
      'completed': completed,
      if (userId != null) 'userId': userId,
    };
  }

  Todo copyWith({
    int? id,
    String? todo,
    bool? completed,
    int? userId,
    bool? isDeleted,
    String? deletedOn,
  }) {
    return Todo(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedOn: deletedOn ?? this.deletedOn,
    );
  }
}