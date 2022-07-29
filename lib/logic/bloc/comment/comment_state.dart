part of 'comment_bloc.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoaded extends CommentState {
  final List<Comment> postComments;

  CommentLoaded({required this.postComments});
}

class CreateCommentLoaded extends CommentState {
  final bool status;

  CreateCommentLoaded({required this.status});
}
