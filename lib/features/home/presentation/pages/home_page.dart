import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_app_najafi/core/extentions/app_localization_helper.dart';
import 'package:test_app_najafi/domain/enums/enums.dart';
import 'package:test_app_najafi/features/home/presentation/providers/todo_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoState = ref.watch(todoProviderProvider);
    final todos = ref.watch(todosListProvider);

    useEffect(() {
      Future.microtask(() {
        ref.read(todoProviderProvider.notifier).fetchTodos();
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.appTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildBody(context, ref, todoState, todos),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, todoState, todos) {
    if (todoState.stateChecker == StateCheckerEnum.loading && todos.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (todoState.stateChecker == StateCheckerEnum.failed && todos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(todoState.error?.message ?? 'Error occurred'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(todoProviderProvider.notifier).fetchTodos(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (todos.isEmpty) {
      return const Center(child: Text('No Todos available'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Card(
          child: ListTile(
            title: Text(
              todo.todo,
              style: TextStyle(
                decoration: (todo.completed) ? TextDecoration.lineThrough : null,
              ),
            ),
            leading: Checkbox(
              value: todo.completed,
              onChanged: (value) {
                ref.read(todoProviderProvider.notifier).toggleTodo(todo);
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                if (todo.id != null) {
                  ref.read(todoProviderProvider.notifier).deleteTodo(todo.id!);
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _showAddTodoDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Todo'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter todo title'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  ref.read(todoProviderProvider.notifier).addTodo(controller.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
