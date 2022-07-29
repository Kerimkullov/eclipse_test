import 'package:dio/dio.dart';

class ApiRequester {
  Dio dio = Dio(
    BaseOptions(
        baseUrl: "https://jsonplaceholder.typicode.com/",
        responseType: ResponseType.json,
        contentType: "application/json; charset=utf-8",
        connectTimeout: 25000,
        receiveTimeout: 35000),
  );

  initialSettings() {
    Interceptors interceptors = dio.interceptors;

    interceptors.clear();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      print('REQUEST[${options.data}] => PATH: ${options.path}');
      return handler.next(options);
    }, onResponse: (response, handler) {
      print("response.data  -  ${response.data}");
      print(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');

      return handler.next(response);
    }, onError: (DioError e, handler) async {
      print(
          'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');

      return handler.next(e);
    }));
    interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
  }

  ApiRequester() {
    initialSettings();
  }
}
