import 'package:dio/dio.dart';
import 'package:test_app_najafi/shared/presentation/widgets/primary_toast.dart';

class ExceptionHandler {
  dynamic get responseData => exception?.response?.data;
  DioException? get exception => dioException;
  int? get statusCode => exception?.response?.statusCode;
  ExceptionHandler({
    this.dioException,
    this.messageException,
  }) {
    final responseData = exception?.response?.data;
    if (messageException != null) {
      PrimaryToast.show(message);
    } else if (responseData != null) {
      String message='';
      message = responseData['message'] as String;


      PrimaryToast.show(message);
    } else if (responseData == null) {
      PrimaryToast.show('Connection Failed, Try again later!');
    } else {
      PrimaryToast.show('An unexpected error occurred!');
    }

    if (exception?.response?.statusCode == 500) {
      PrimaryToast.show(
        'Server is busy now,try again later!',
      );
    }
    print;
  }
  final DioException? dioException;
  final String? messageException;

  String? get errorsMassage {
    try {
      String data = '';
      final errors = responseData['errors'];
      if (errors is Object) {
        final value = errors as Map<String, dynamic>;
        for (final element in value.values.first as List<dynamic>) {
          data += "${element ?? ''}\n";
        }
      } else {
        (errors as Map<String, dynamic>).values.map(
          (e) {
            for (final element in e as List<dynamic>) {
              data += "${element ?? ''}\n";
            }
            return e.map(
              (e) => '$e\n',
            );
          },
        );
      }

      return data;
    } catch (e) {
      // logger(e);
      return null;
    }
  }



  String? get message =>
      messageException ??
      (exception?.message?.contains('The request connection took longer') ==
              true
          ? 'Connection Failed, Try Again later'
          : exception?.message);

  // void get print => logger(toString(), level: Level.error);

  @override
  String toString() {
    if (dioException != null) {
      return 'ExceptionHandler: \n---[Dio Failed]\n---URL: '
          '${dioException!.requestOptions.uri} \n'
          '---headers: ${dioException?.requestOptions.headers}'
          ' \n---Message: $message\n---StatusCode: $statusCode';
    }
    if (messageException != null) {
      return 'ExceptionHandler: \n---[Exception Message]\n---Message: $messageException';
    }
    return 'ExceptionHandler: unknown Error!';
  }

  ExceptionHandler copyWith({
    DioException? dioException,
    String? messageException,
    // AutoDisposeNotifierProviderRef<dynamic>? ref,
  }) {
    return ExceptionHandler(
      dioException: dioException ?? this.dioException,
      messageException: messageException ?? this.messageException,
    );
  }
}
