import 'package:dio/dio.dart';

class CatchException {
  String? message;

  CatchException({this.message});

  static CatchException convertException(dynamic error) {
    if (error is DioError && error.error is CatchException) {
      return error.error;
    }
    if (error is DioError) {
      print(error);
      if (error.type == DioErrorType.connectTimeout) {
        print('CONNECTION_ERROR');
        return CatchException(
            message: 'Привышено время обработки запроса. Повторите позднее');
      } else if (error.type == DioErrorType.receiveTimeout) {
        print('RECIVE_ERROR');
        return CatchException(
            message: 'Привышено время обработки запроса. Повторите позднее');
      } else if (error.response == null) {
        print('NO_INTERNET');
        return CatchException(message: 'Нет интернет соединения');
      } else if (error.response!.statusCode == 400) {
        // removeToken();
        return CatchException(message: null);
      } else if (error.response!.statusCode == 401) {
        print("error.response!.statusCode - ${error.response!.statusCode}");

        return CatchException(message: null);
      } else if (error.response!.statusCode == 409) {
        return CatchException(message: error.response!.data["message"]);
      } else if (error.type == DioErrorType.response) {
        print(
            "Error: ${error.response!.data["message"]}(code ${error.response!.statusCode})");
        if (error.response!.statusCode == 500) {
          return CatchException(message: error.response!.data["message"]);
        }
        return CatchException(
            message:
                "${error.response!.data["message"]}(code ${error.response!.statusCode})");
      } else if (error.type == DioErrorType.other) {
        print("no internet(${error.error})");
        return CatchException(message: 'Проверьте интернет соединение');
      } else {
        print(error.error);
        throw CatchException(message: 'Произошла системная ошибка');
      }
    }
    if (error is CatchException) {
      return error;
    } else {
      return CatchException(message: 'Произошла системная ошибка');
    }
  }
}
