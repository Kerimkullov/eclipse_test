part of 'album_bloc.dart';

@immutable
abstract class AlbumEvent {}

class GetAlbumList extends AlbumEvent {}

class GetPhotosList extends AlbumEvent {
  final int id;

  GetPhotosList({required this.id});
}
