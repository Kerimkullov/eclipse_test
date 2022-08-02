import 'package:dio/dio.dart';
import 'package:eclipse_test/logic/models/album/album.dart';

import '../../../api/api_requester.dart';
import '../../../api/catch_exceptions.dart';
import '../../models/album/photos.dart';

class AlbumService {
  Future<List<Album>> getAlbumList() async {
    try {
      Dio dio = ApiRequester().dio;

      Response response = await dio.get("albums/");

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
