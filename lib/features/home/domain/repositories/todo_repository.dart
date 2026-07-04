import 'package:test_app_najafi/core/exception/exception_handler.dart';
import 'package:test_app_najafi/data/models/api_response.dart';
import 'package:test_app_najafi/data/models/todo.dart';
import 'package:test_app_najafi/features/home/data/models/todos_response.dart';
import 'package:dartz/dartz.dart';

abstract class TodoRepository {
  Future<Either<ExceptionHandler, ApiResponse<TodosResponse>>> getTodos({
    int? limit,
    int? skip,
  });


  Future<Either<ExceptionHandler, ApiResponse<Todo>>> createTodo(
      Map<String, dynamic> body,
      );

  Future<Either<ExceptionHandler, ApiResponse<Todo>>> updateTodo(
      int id,
      Map<String, dynamic> body,
      );

  Future<Either<ExceptionHandler, ApiResponse<Todo>>> deleteTodo(
      int id,
      );
}