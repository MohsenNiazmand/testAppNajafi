import 'package:test_app_najafi/core/exception/exception_handler.dart';
import 'package:test_app_najafi/data/models/api_response.dart';
import 'package:test_app_najafi/domain/usecase/usecase.dart';
import 'package:test_app_najafi/features/home/data/models/todos_response.dart';
import 'package:test_app_najafi/features/home/domain/repositories/todo_repository.dart';
import 'package:dartz/dartz.dart';

class GetTodosUseCase
    implements
        UseCase<
          Either<ExceptionHandler, ApiResponse<TodosResponse>>,
          GetTodosParams?
        > {
  GetTodosUseCase(this._repo);

  final TodoRepository _repo;

  @override
  Future<Either<ExceptionHandler, ApiResponse<TodosResponse>>> call({
    GetTodosParams? params,
  }) {
    return _repo.getTodos(limit: params?.limit, skip: params?.skip);
  }
}

class GetTodosParams {
  final int? limit;
  final int? skip;

  GetTodosParams({this.limit, this.skip});
}
