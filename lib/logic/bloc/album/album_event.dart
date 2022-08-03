part of 'album_bloc.dart';

@immutable
abstract class AlbumEvent {}

class GetAlbumList extends AlbumEvent {
  final int userId;

  GetAlbumList({required this.userId});
}

class GetPhotosList extends AlbumEvent {
  final int id;

  GetPhotosList({required this.id});
}
