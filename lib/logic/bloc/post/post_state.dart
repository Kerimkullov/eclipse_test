part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostListLoaded extends PostState {
  final List<Post> postList;

  PostListLoaded({required this.postList});
}
