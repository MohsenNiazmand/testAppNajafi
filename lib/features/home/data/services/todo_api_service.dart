import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_app_najafi/core/constants/constants.dart';
import 'package:test_app_najafi/data/models/api_response.dart';
import 'package:test_app_najafi/data/models/todo.dart';
import 'package:test_app_najafi/features/home/data/models/todos_response.dart';


part 'todo_api_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class TodoApiService {
  factory TodoApiService(Dio dio) = _TodoApiService;

  @GET('/todos')
  Future<ApiResponse<TodosResponse>> getTodos({
    @Query('limit') int? limit,
    @Query('skip') int? skip,
  });

  @POST('/todos/add')
  Future<ApiResponse<Todo>> createTodo(
      @Body() Map<String, dynamic> body,
      );

  @PUT('/todos/{id}')
  Future<ApiResponse<Todo>> updateTodo(
      @Path('id') int id,
      @Body() Map<String, dynamic> body,
      );

  @DELETE('/todos/{id}')
  Future<ApiResponse<Todo>> deleteTodo(
      @Path('id') int id,
      );
}