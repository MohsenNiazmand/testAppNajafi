import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// Use this class while debugging in release mode
// class NoneFilter extends LogFilter {
//   @override
//   bool shouldLog(LogEvent event) {
//     return true;
//   }
// }

class LoggerHelper {
  static final Logger logger = Logger(
    // filter: NoneFilter(),
    printer: PrefixPrinter(
      PrettyPrinter(
        methodCount: 10,
      ),
    ),
  );
  // ignore: type_annotate_public_apis
  static void errorLog(exception) {
    if (exception is FlutterError) {
      if (exception.message.contains('was used after being disposed.')) {
        return;
      }
    }
    logger.e(exception ?? '');

  }
}

void printRequest(RequestOptions options) {
  // LoggerHelper.logger.i(
  //   {
  //     'request': {
  //       'method': options.method,
  //       'path': options.path,
  //       if (options.contentType != 'multipart/form-data')
  //         'data': options.data,
  //       'queryParameters': options.queryParameters,
  //       'headers': options.headers,
  //     }
  //   },
  // );
}

void printOnResponse(Response<dynamic> response) {
  // LoggerHelper.logger.i(
  //   {
  //     'response': {
  //       'method': response.requestOptions.method,
  //       'path': response.requestOptions.path,
  //       'data': response.data,
  //       'statusCode': response.statusCode
  //     }
  //   },
  // );
}

void onErrorPrint(DioException error) {
  LoggerHelper.errorLog(
    {
      'type': error.type.toString(),
      'error': error.error?.toString(),
      'message': error.message,
      'request': {
        'method': error.requestOptions.method,
        'path': error.requestOptions.path,
        'uri': error.requestOptions.uri.toString(),
        if (error.requestOptions.contentType != 'multipart/form-data')
          'data': error.requestOptions.data,
        'extra': error.requestOptions.extra,
        'headers': error.requestOptions.headers,
        'queryParameters': error.requestOptions.queryParameters,
      },
      'response': {
        'statusCode': error.response?.statusCode,
        'statusMessage': error.response?.statusMessage,
        'data': error.response?.data,
        'extra': error.response?.extra,
        'headers': error.response?.headers,
      },
    },

  );
}
