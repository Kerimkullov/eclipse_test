import 'package:bloc/bloc.dart';
import 'package:eclipse_test/logic/models/post/comment.dart';
import 'package:meta/meta.dart';

import '../../models/post/create_comment.dart';
import '../../service/user_service.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    on<GetComments>(onGetComments);

    on<CreateCommentEvent>(onCreateComment);
  }

  void onGetComments(GetComments event, Emitter<CommentState> emit) async {
    emit(CommentInitial());

    final service = UserService();

    emit(CommentLoaded(postComments: await service.getComments(event.id)));
  }

  void onCreateComment(
      CreateCommentEvent event, Emitter<CommentState> emit) async {
    emit(CommentInitial());

    final service = UserService();

    emit(CommentLoaded(postComments: await service.getComments(event.id)));
  }
}
