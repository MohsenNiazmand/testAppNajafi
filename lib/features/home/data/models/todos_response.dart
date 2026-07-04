
import 'package:test_app_najafi/data/models/todo.dart';

class TodosResponse {
  final List<Todo> todos;
  final int total;
  final int skip;
  final int limit;

  TodosResponse({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory TodosResponse.fromJson(Map<String, dynamic> json) {
    return TodosResponse(
      todos: (json['todos'] as List)
          .map((e) => Todo.fromJson(e))
          .toList(),
      total: json['total'] ?? 0,
      skip: json['skip'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }
}