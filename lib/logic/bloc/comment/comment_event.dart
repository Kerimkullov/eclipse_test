part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class GetComments extends CommentEvent {
  final int id;

  GetComments({required this.id});
}

class CreateCommentEvent extends CommentEvent {
  final CreateComment comment;

  final int id;

  CreateCommentEvent({required this.comment, required this.id});
}
