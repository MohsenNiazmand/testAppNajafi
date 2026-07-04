import 'package:test_app_najafi/core/exception/exception_handler.dart';
import 'package:test_app_najafi/data/models/api_response.dart';
import 'package:test_app_najafi/data/models/todo.dart';
import 'package:dartz/dartz.dart';
import 'package:test_app_najafi/domain/usecase/usecase.dart';
import 'package:test_app_najafi/features/home/domain/repositories/todo_repository.dart';

class CreateTodoUseCase implements UseCase<Either<ExceptionHandler, ApiResponse<Todo>>, CreateTodoParams> {
  CreateTodoUseCase(this._repo);

  final TodoRepository _repo;

  @override
  Future<Either<ExceptionHandler, ApiResponse<Todo>>> call({
    CreateTodoParams? params,
  }) {
    final body = {
      'todo': params!.todo,
      'completed': params.completed,
      'userId': params.userId,
    };
    return _repo.createTodo(body);
  }
}

class CreateTodoParams {
  final String todo;
  final bool completed;
  final int userId;

  CreateTodoParams({
    required this.todo,
    required this.completed,
    required this.userId,
  });
}