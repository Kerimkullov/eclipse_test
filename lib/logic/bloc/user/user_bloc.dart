import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user/user.dart';
import '../../service/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GetUserListEvent>(onGetUserList);
  }

  void onGetUserList(GetUserListEvent event, Emitter<UserState> emit) async {
    emit(UserInitial());

    final service = UserService();

    emit(UserListLoaded(userList: await service.getUserList()));
  }
}
