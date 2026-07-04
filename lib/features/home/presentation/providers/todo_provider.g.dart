// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TodoProvider)
final todoProviderProvider = TodoProviderProvider._();

final class TodoProviderProvider
    extends $NotifierProvider<TodoProvider, DataState<TodosResponse>> {
  TodoProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoProviderHash();

  @$internal
  @override
  TodoProvider create() => TodoProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DataState<TodosResponse> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DataState<TodosResponse>>(value),
    );
  }
}

String _$todoProviderHash() => r'297eafd35702e2c02e01b8571ae368e00cabc288';

abstract class _$TodoProvider extends $Notifier<DataState<TodosResponse>> {
  DataState<TodosResponse> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<DataState<TodosResponse>, DataState<TodosResponse>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DataState<TodosResponse>, DataState<TodosResponse>>,
              DataState<TodosResponse>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
