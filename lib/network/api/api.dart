import 'package:abx_booking/utils/app_config.dart';
import 'package:abx_booking/utils/common.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'api_client.dart';

class Api {
  static ApiClient getInstance() {
    return ApiClient(_getDio());
  }

  static Dio _getDio() {
    var dio = Dio();
    dio.options.baseUrl = AppConfig.getBaseUrl();
    dio.options.connectTimeout = AppConfig.connectTimeout();
    dio.options.receiveTimeout = AppConfig.receiveTimeout();
    dio.options.sendTimeout = AppConfig.sendTimeout();

    dio.interceptors.add(
        LogInterceptor(responseBody: true, requestHeader: true, error: true));

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onResponse: (response, handler) {
      if (response.data != null && response.data is String) {
        response.data = jsonDecode(response.data);
      }
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError: (DioError e, handler) {
      // Do something with response error
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));

    // dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onResponse: (Response response) {
    //       if (response.data != null && response.data is String) {
    //         response.data = jsonDecode(response.data);
    //       }
    //       return response;
    //     },
    //     onRequest: (RequestOptions options) {
    //       if (options.data != null) {
    //         Common.printWrapped('Request params: ' + jsonEncode(options.data));
    //       }
    //     },
    //     onError: (DioError e) async {
    //       return e;
    //     },
    //   ),
    // );

    return dio;
  }
}
