import 'package:abx_booking/data/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BaseRepo {
  Result handleError(exception, stackTrace) {
    // CrashReport().logError(
    //   FlutterErrorDetails(exception: exception, stack: stackTrace),
    // );

    String errorMsg = "";
    if (exception is DioError) {
      /* errorMsg = exception.response?.statusCode == null
          ? exception.message
          : "HTTP Error: ${exception.response?.statusCode}"; */

      switch (exception.type) {
        case DioErrorType.connectTimeout:
          errorMsg =
              'Unable to reach the server. Please verify your internet connection and try again.';
          break;
        case DioErrorType.receiveTimeout:
          errorMsg =
              'Failed to receive a response. Please verify your internet connection and try again.';
          break;
        case DioErrorType.sendTimeout:
          errorMsg =
              'Failed to send a request. Please verify your internet connection and try again.';
          break;
        case DioErrorType.response:
          errorMsg = (exception.response?.statusCode == null
              ? exception.message
              : exception.response?.statusCode.toString())!;
          break;
        case DioErrorType.cancel:
          errorMsg = (exception.response?.statusCode == null
              ? exception.message
              : exception.response?.statusCode.toString())!;
          break;
        case DioErrorType.other:
          errorMsg =
              'Cannot retrieve data at this time. Please try again later.';
          break;
        default:
          errorMsg =
              'Cannot retrieve data at this time. Please try again later.';
          break;
      }
    } else {
      errorMsg = exception.toString();
    }
    return Result(false, message: errorMsg);
  }
}
