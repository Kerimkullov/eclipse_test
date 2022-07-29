part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserListLoaded extends UserState {
  final List<User> userList;

  UserListLoaded({required this.userList});
}
