import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app_najafi/core/constants/constants.dart';
import 'package:test_app_najafi/features/home/data/repositories/todo_repository_impl.dart';
import 'package:test_app_najafi/features/home/data/services/todo_api_service.dart';
import 'package:test_app_najafi/features/home/domain/repositories/todo_repository.dart';
import 'package:test_app_najafi/features/home/domain/usecases/create_todo_use_case.dart';
import 'package:test_app_najafi/features/home/domain/usecases/delete_todo_use_case.dart';
import 'package:test_app_najafi/features/home/domain/usecases/get_todos_use_case.dart';
import 'package:test_app_najafi/features/home/domain/usecases/update_todo_use_case.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    return dio;
  });

  getIt.registerLazySingleton<TodoApiService>(
    () => TodoApiService(getIt<Dio>()),
  );

  getIt.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(getIt<TodoApiService>()),
  );

  getIt.registerLazySingleton<GetTodosUseCase>(
    () => GetTodosUseCase(getIt<TodoRepository>()),
  );
  getIt.registerLazySingleton<CreateTodoUseCase>(
    () => CreateTodoUseCase(getIt<TodoRepository>()),
  );
  getIt.registerLazySingleton<UpdateTodoUseCase>(
    () => UpdateTodoUseCase(getIt<TodoRepository>()),
  );
  getIt.registerLazySingleton<DeleteTodoUseCase>(
    () => DeleteTodoUseCase(getIt<TodoRepository>()),
  );
}
