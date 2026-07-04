import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_app_najafi/core/di/injection.dart';
import 'package:test_app_najafi/data/models/todo.dart';
import 'package:test_app_najafi/domain/entities/data_state.dart';
import 'package:test_app_najafi/features/home/data/models/todos_response.dart';
import 'package:test_app_najafi/features/home/domain/usecases/create_todo_use_case.dart';
import 'package:test_app_najafi/features/home/domain/usecases/delete_todo_use_case.dart';
import 'package:test_app_najafi/features/home/domain/usecases/get_todos_use_case.dart';
import 'package:test_app_najafi/features/home/domain/usecases/update_todo_use_case.dart';

part 'todo_provider.g.dart';

final todosListProvider = StateProvider<List<Todo>>((ref) => []);

@riverpod
class TodoProvider extends _$TodoProvider {
  @override
  DataState<TodosResponse> build() {
    return const DataInitial();
  }

  Future<void> fetchTodos({int? limit, int? skip}) async {
    state = const DataLoading();

    final result = await getIt<GetTodosUseCase>().call(
      params: GetTodosParams(limit: limit, skip: skip),
    );

    result.fold(
      (failure) {
        state = DataFailed(failure);
      },
      (response) {
        ref.read(todosListProvider.notifier).state = response.data?.todos ?? [];
        state = DataSuccess(response.data!);
      },
    );
  }

  Future<void> addTodo(String text) async {
    final result = await getIt<CreateTodoUseCase>().call(
      params: CreateTodoParams(todo: text, completed: false, userId: 5),
    );

    result.fold(
      (failure) {
      },
      (response) {
        if (response.data != null) {
          final currentList = ref.read(todosListProvider);
          ref.read(todosListProvider.notifier).state = [
            response.data!,
            ...currentList,
          ];
        }
      },
    );
  }

  Future<void> toggleTodo(Todo todo) async {
    final updatedTodo = todo.copyWith(completed: !(todo.completed ?? false));
    
    final result = await getIt<UpdateTodoUseCase>().call(
      params: UpdateTodoParams(
        id: todo.id!,
        completed: updatedTodo.completed,
      ),
    );

    result.fold(
      (failure) {
      },
      (response) {
        final currentList = ref.read(todosListProvider);
        ref.read(todosListProvider.notifier).state = currentList.map((item) {
          return item.id == todo.id ? updatedTodo : item;
        }).toList();
      },
    );
  }

  Future<void> deleteTodo(int id) async {
    final result = await getIt<DeleteTodoUseCase>().call(
      params: DeleteTodoParams(id: id),
    );

    result.fold(
      (failure) {
      },
      (response) {
        final currentList = ref.read(todosListProvider);
        ref.read(todosListProvider.notifier).state =
            currentList.where((item) => item.id != id).toList();
      },
    );
  }
}
