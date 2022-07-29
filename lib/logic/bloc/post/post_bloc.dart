import 'package:bloc/bloc.dart';
import 'package:eclipse_test/logic/service/post/post_service.dart';
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

    final service = PostService();

    emit(PostListLoaded(postList: await service.getPostList()));
  }
}
