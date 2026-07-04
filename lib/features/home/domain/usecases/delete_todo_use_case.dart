import 'package:test_app_najafi/core/exception/exception_handler.dart';
import 'package:test_app_najafi/data/models/api_response.dart';
import 'package:test_app_najafi/data/models/todo.dart';
import 'package:dartz/dartz.dart';
import 'package:test_app_najafi/domain/usecase/usecase.dart';
import 'package:test_app_najafi/features/home/domain/repositories/todo_repository.dart';

class DeleteTodoUseCase implements UseCase<Either<ExceptionHandler, ApiResponse<Todo>>, DeleteTodoParams> {
  DeleteTodoUseCase(this._repo);

  final TodoRepository _repo;

  @override
  Future<Either<ExceptionHandler, ApiResponse<Todo>>> call({
    DeleteTodoParams? params,
  }) {
    return _repo.deleteTodo(params!.id);
  }
}

class DeleteTodoParams {
  final int id;

  DeleteTodoParams({required this.id});
}