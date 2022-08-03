import 'package:bloc/bloc.dart';
import 'package:eclipse_test/logic/models/album/album.dart';
import 'package:eclipse_test/logic/models/album/photos.dart';
import 'package:eclipse_test/logic/service/user_service.dart';
import 'package:meta/meta.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(AlbumInitial()) {
    on<GetAlbumList>(onGetAlbumList);

    on<GetPhotosList>(onGetPhotosList);
  }

  void onGetAlbumList(GetAlbumList event, Emitter<AlbumState> emit) async {
    emit(AlbumInitial());

    final service = UserService();

    emit(AlbumLoaded(albumList: await service.getAlbumList(event.userId)));
  }

  void onGetPhotosList(GetPhotosList event, Emitter<AlbumState> emit) async {
    emit(AlbumInitial());

    final service = UserService();

    emit(PhotosLoaded(photosList: await service.getPhotosList(event.id)));
  }
}
