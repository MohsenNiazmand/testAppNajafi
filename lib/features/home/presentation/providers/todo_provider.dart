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
final todoActionLoadingProvider = StateProvider<bool>((ref) => false);
final isLoadMoreLoadingProvider = StateProvider<bool>((ref) => false);

@riverpod
class TodoProvider extends _$TodoProvider {
  @override
  DataState<TodosResponse> build() {
    return const DataInitial();
  }

  Future<void> fetchTodos({int limit = 15}) async {
    ref.read(todoActionLoadingProvider.notifier).state = true;
    state = const DataLoading();

    final result = await getIt<GetTodosUseCase>().call(
      params: GetTodosParams(limit: limit, skip: 0),
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
    
    ref.read(todoActionLoadingProvider.notifier).state = false;
  }

  Future<void> loadMore() async {
    final currentData = state.data;
    if (currentData == null) return;
    
    final currentTodos = ref.read(todosListProvider);
    if (currentTodos.length >= currentData.total) return;
    if (ref.read(isLoadMoreLoadingProvider)) return;

    ref.read(isLoadMoreLoadingProvider.notifier).state = true;

    final result = await getIt<GetTodosUseCase>().call(
      params: GetTodosParams(
        limit: currentData.limit,
        skip: currentTodos.length,
      ),
    );

    result.fold(
      (failure) {
        // Silent fail for load more or handle accordingly
      },
      (response) {
        if (response.data != null) {
          ref.read(todosListProvider.notifier).state = [
            ...currentTodos,
            ...response.data!.todos,
          ];
          // Update the state with new metadata (total, skip, limit)
          state = DataSuccess(response.data!);
        }
      },
    );

    ref.read(isLoadMoreLoadingProvider.notifier).state = false;
  }

  Future<void> addTodo(String text) async {
    ref.read(todoActionLoadingProvider.notifier).state = true;
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
    ref.read(todoActionLoadingProvider.notifier).state = false;
  }

  Future<void> toggleTodo(Todo todo) async {
    ref.read(todoActionLoadingProvider.notifier).state = true;
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
    ref.read(todoActionLoadingProvider.notifier).state = false;
  }

  Future<void> deleteTodo(int id) async {
    ref.read(todoActionLoadingProvider.notifier).state = true;
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
    ref.read(todoActionLoadingProvider.notifier).state = false;
  }
}
