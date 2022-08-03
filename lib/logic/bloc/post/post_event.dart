part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class GetPostList extends PostEvent {
  final int userId;

  GetPostList({required this.userId});
}
