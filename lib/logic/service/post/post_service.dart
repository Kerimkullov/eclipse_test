import 'package:dio/dio.dart';
import 'package:eclipse_test/logic/models/post/comment.dart';

import '../../../api/api_requester.dart';
import '../../../api/catch_exceptions.dart';
import '../../models/post/create_comment.dart';
import '../../models/post/post.dart';

class PostService {
  Future<List<Post>> getPostList() async {
    try {
      Dio dio = ApiRequester().dio;

      Response response = await dio.get("posts/");

      if (response.statusCode == 200) {
        return response.data.map<Post>((e) => Post.fromMap(e)).toList();
      }
      throw CatchException.convertException(response.statusMessage);
    } catch (err) {
      throw CatchException.convertException(err);
    }
  }

  Future<List<Comment>> getComments(int id) async {
    try {
      Dio dio = ApiRequester().dio;

      Response response = await dio.get("posts/1/comments/");

      if (response.statusCode == 200) {
        return response.data.map<Comment>((e) => Comment.fromMap(e)).toList();
      }
      throw CatchException.convertException(response.statusMessage);
    } catch (err) {
      throw CatchException.convertException(err);
    }
  }

  Future<bool> createComment(CreateComment comment, int id) async {
    try {
      Dio dio = ApiRequester().dio;

      Response response =
          await dio.post("posts/$id/comments", data: comment.toMap());

      if (response.statusCode == 201) {
        return true;
      }
      throw CatchException.convertException(response.statusMessage);
    } catch (err) {
      throw CatchException.convertException(err);
    }
  }
}
