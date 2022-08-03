import 'package:bloc/bloc.dart';
import '../../service/user_service.dart';
import 'package:meta/meta.dart';

import '../../models/post/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<GetPostList>(onGetPostList);
  }

  void onGetPostList(GetPostList event, Emitter<PostState> emit) async {
    emit(PostInitial());

    final service = UserService();

    emit(PostListLoaded(postList: await service.getPostList(event.userId)));
  }
}
