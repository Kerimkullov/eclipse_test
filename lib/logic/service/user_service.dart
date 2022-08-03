import 'package:dio/dio.dart';
import 'package:eclipse_test/api/api_requester.dart';

import '../../../api/catch_exceptions.dart';
import '../models/album/album.dart';
import '../models/album/photos.dart';
import '../models/post/comment.dart';
import '../models/post/create_comment.dart';
import '../models/post/post.dart';
import '../models/user/user.dart';

class UserService {
  Future<List<User>> getUserList() async {
    try {
      Dio dio = ApiRequester().dio;

      Response response = await dio.get("users/");

      if (response.statusCode == 200) {
        return response.data.map<User>((e) => User.fromMap(e)).toList();
      }
      throw CatchException.convertException(response.statusMessage);
    } catch (err) {
      throw CatchException.convertException(err);
    }
  }

  Future<List<Post>> getPostList(int id) async {
    try {
      Dio dio = ApiRequester().dio;

      Response response = await dio.get("users/$id/posts/");

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

      Response response = await dio.get("posts/$id/comments/");

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

  Future<List<Album>> getAlbumList(int id) async {
    try {
      Dio dio = ApiRequester().dio;

      Response response = await dio.get("users/$id/albums/");

      if (response.statusCode == 200) {
        return response.data.map<Album>((e) => Album.fromMap(e)).toList();
      }
      throw CatchException.convertException(response.statusMessage);
    } catch (err) {
      throw CatchException.convertException(err);
    }
  }

  Future<List<Photos>> getPhotosList(int id) async {
    try {
      Dio dio = ApiRequester().dio;

      Response response = await dio.get("albums/$id/photos");

      if (response.statusCode == 200) {
        return response.data.map<Photos>((e) => Photos.fromMap(e)).toList();
      }
      throw CatchException.convertException(response.statusMessage);
    } catch (err) {
      throw CatchException.convertException(err);
    }
  }
}
