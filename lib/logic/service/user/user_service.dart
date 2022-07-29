import 'package:dio/dio.dart';
import 'package:eclipse_test/api/api_requester.dart';

import '../../../api/catch_exceptions.dart';
import '../../models/user/user.dart';

class UserService {
  Future<List<User>> getUserList() async {
    try {
      Dio dio = ApiRequester().dio;

      Response response = await dio.get("users/");

      if (response.statusCode == 200) {
        return response.data.map<User>((e) => User.fromMap(e)).toList();
      }
      throw CatchException.convertException(response.statusMessage);
    } on TypeError {
      throw CatchException.convertException("Произошла системная ошибка");
    } catch (err) {
      throw CatchException.convertException(err);
    }
  }
}
