import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      // PrimaryToast.show(message);
    } else if (responseData != null) {
      String message='';
      message = responseData['message'] as String;

      final emailErrorField=responseData['data']['email'];
      final universityErrorField=responseData['data']['funiversity'];
      final passwordErrorField=responseData['data']['password'];
      final oldPasswordErrorField=responseData['data']['old_password'];
      final profileFileErrorField=responseData['data']['profile_file'];
      if(emailErrorField!=null){
        final emailError= ((responseData['data']['email']) as List<dynamic>).first;
        if(emailError!=null){
          message=emailError as String;
        }
      }
      if(universityErrorField!=null){
        final fUniError= ((responseData['data']['funiversity']) as List<dynamic>).first;
        if(fUniError!=null){
          message=fUniError as String;
        }
      }

      if(passwordErrorField!=null){
        final passwordError= ((responseData['data']['password']) as List<dynamic>).first;
        if(passwordError!=null){
          message=passwordError as String;
        }
      }

      if(oldPasswordErrorField!=null){
        final oldPasswordError= ((responseData['data']['old_password']) as List<dynamic>).first;
        if(oldPasswordError!=null){
          message=oldPasswordError as String;
        }
      }

      if(profileFileErrorField!=null){
        final profileFileError= ((responseData['data']['profile_file']) as List<dynamic>).first;
        if(profileFileError!=null){
          message=profileFileError as String;
        }
      }




      // PrimaryToast.show(message);
    } else if (responseData == null) {
      // PrimaryToast.show('Connection Failed, Try again later!');
    } else {
      // PrimaryToast.show('An unexpected error occurred!');
    }

    if (exception?.response?.statusCode == 500) {
      // PrimaryToast.show(
      //   'Server is busy now,try again later!',
      // );
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
