import 'package:test_app_najafi/core/exception/exception_handler.dart';
import 'package:test_app_najafi/data/models/api_response.dart';
import 'package:test_app_najafi/data/models/todo.dart';
import 'package:dartz/dartz.dart';
import 'package:test_app_najafi/domain/usecase/usecase.dart';
import 'package:test_app_najafi/features/home/domain/repositories/todo_repository.dart';

class UpdateTodoUseCase implements UseCase<Either<ExceptionHandler, ApiResponse<Todo>>, UpdateTodoParams> {
  UpdateTodoUseCase(this._repo);

  final TodoRepository _repo;

  @override
  Future<Either<ExceptionHandler, ApiResponse<Todo>>> call({
    UpdateTodoParams? params,
  }) {
    final body = <String, dynamic>{};
    if (params!.todo != null) body['todo'] = params.todo;
    if (params.completed != null) body['completed'] = params.completed;
    if (params.userId != null) body['userId'] = params.userId;

    return _repo.updateTodo(params.id, body);
  }
}

class UpdateTodoParams {
  final int id;
  final String? todo;
  final bool? completed;
  final int? userId;

  UpdateTodoParams({required this.id, this.todo, this.completed, this.userId});
}