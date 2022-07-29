part of 'album_bloc.dart';

@immutable
abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Album> albumList;

  AlbumLoaded({required this.albumList});
}

class PhotosLoaded extends AlbumState {
  final List<Photos> photosList;

  PhotosLoaded({required this.photosList});
}
