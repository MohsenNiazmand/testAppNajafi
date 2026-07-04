import 'package:test_app_najafi/core/exception/exception_handler.dart';
import 'package:test_app_najafi/data/models/api_response.dart';
import 'package:test_app_najafi/data/models/todo.dart';
import 'package:test_app_najafi/features/home/data/models/todos_response.dart';
import 'package:test_app_najafi/features/home/data/services/todo_api_service.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_app_najafi/features/home/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  TodoRepositoryImpl(this._apiService);

  final TodoApiService _apiService;

  @override
  Future<Either<ExceptionHandler, ApiResponse<TodosResponse>>> getTodos({
    int? limit,
    int? skip,
  }) async {
    try {
      final result = await _apiService.getTodos(
        limit: limit,
        skip: skip,
      );

      if (result.statusCode==200) {
        return Right(result);
      } else {
        final errorMessage = result.message;
        final exceptionHandler = ExceptionHandler(
          messageException: errorMessage,
        );
        return Left(exceptionHandler);
      }
    } on DioException catch (e) {
      return Left(ExceptionHandler(dioException: e));
    } catch (e) {
      return Left(ExceptionHandler(messageException: e.toString()));
    }
  }


  @override
  Future<Either<ExceptionHandler, ApiResponse<Todo>>> createTodo(
      Map<String, dynamic> body,
      ) async {
    try {
      final result = await _apiService.createTodo(body);

      if (result.statusCode==200)  {
        return Right(result);
      } else {
        final errorMessage = result.message;
        final exceptionHandler = ExceptionHandler(
          messageException: errorMessage,
        );
        return Left(exceptionHandler);
      }
    } on DioException catch (e) {
      return Left(ExceptionHandler(dioException: e));
    } catch (e) {
      return Left(ExceptionHandler(messageException: e.toString()));
    }
  }

  @override
  Future<Either<ExceptionHandler, ApiResponse<Todo>>> updateTodo(
      int id,
      Map<String, dynamic> body,
      ) async {
    try {
      final result = await _apiService.updateTodo(id, body);

      if (result.statusCode==200)  {
        return Right(result);
      } else {
        final errorMessage = result.message;
        final exceptionHandler = ExceptionHandler(
          messageException: errorMessage,
        );
        return Left(exceptionHandler);
      }
    } on DioException catch (e) {
      return Left(ExceptionHandler(dioException: e));
    } catch (e) {
      return Left(ExceptionHandler(messageException: e.toString()));
    }
  }

  @override
  Future<Either<ExceptionHandler, ApiResponse<Todo>>> deleteTodo(
      int id,
      ) async {
    try {
      final result = await _apiService.deleteTodo(id);

      if (result.statusCode==200) {
        return Right(result);
      } else {
        final errorMessage = result.message;
        final exceptionHandler = ExceptionHandler(
          messageException: errorMessage,
        );
        return Left(exceptionHandler);
      }
    } on DioException catch (e) {
      return Left(ExceptionHandler(dioException: e));
    } catch (e) {
      return Left(ExceptionHandler(messageException: e.toString()));
    }
  }
}