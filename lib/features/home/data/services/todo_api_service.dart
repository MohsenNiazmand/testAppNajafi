import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_app_najafi/core/constants/constants.dart';
import 'package:test_app_najafi/data/models/todo.dart';
import 'package:test_app_najafi/features/home/data/models/todos_response.dart';

part 'todo_api_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class TodoApiService {
  factory TodoApiService(Dio dio) = _TodoApiService;

  @GET('/todos')
  Future<TodosResponse> getTodos({
    @Query('limit') int? limit,
    @Query('skip') int? skip,
  });

  @POST('/todos/add')
  Future<Todo> createTodo(
      @Body() Map<String, dynamic> body,
      );

  @PUT('/todos/{id}')
  Future<Todo> updateTodo(
      @Path('id') int id,
      @Body() Map<String, dynamic> body,
      );

  @DELETE('/todos/{id}')
  Future<Todo> deleteTodo(
      @Path('id') int id,
      );
}
