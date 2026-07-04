


import 'package:test_app_najafi/core/exception/exception_handler.dart';
import 'package:test_app_najafi/domain/enums/enums.dart';

abstract class DataState<T> {
  const DataState({
    this.data,
    this.error,
    this.stateChecker,
  });

  final T? data;
  final ExceptionHandler? error;
  final StateCheckerEnum? stateChecker;
}

class DataInitial<T> extends DataState<T> {
  const DataInitial() : super(stateChecker: StateCheckerEnum.initial);
}

class DataLoading<T> extends DataState<T> {
  const DataLoading() : super(stateChecker: StateCheckerEnum.loading);
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data)
      : super(data: data, stateChecker: StateCheckerEnum.done);
}

class DataFailed<T> extends DataState<T> {
  DataFailed(ExceptionHandler error)
      : super(error: error, stateChecker: StateCheckerEnum.failed);
}
