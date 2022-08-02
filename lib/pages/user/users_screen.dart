import 'package:eclipse_test/components/error_text_widget.dart';
import 'package:eclipse_test/constants/eclipse_text_style.dart';
import 'package:eclipse_test/pages/user/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/user/user_bloc.dart';
import '../../logic/models/user/user.dart';
import '../../utils/text_extensions.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final userBloc = UserBloc();

  @override
  void initState() {
    userBloc.add(GetUserListEvent());

    super.initState();
  }

  void onTapUserCard(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserInfoScreen(
          user: user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<UserBloc, UserState>(
            bloc: userBloc,
            builder: (context, state) {
              if (state is UserInitial) {
                return const CircularProgressIndicator.adaptive();
              }

              if (state is UserListLoaded) {
                return ListView.separated(
                  itemCount: state.userList.length,
                  itemBuilder: (context, i) {
                    final user = state.userList[i];
                    return Card(
                      child: ListTile(
                        onTap: (() => onTapUserCard(user)),
                        title: Text(
                          user.username.capitalize(),
                          style: EclipseTextStyle.title,
                        ),
                        subtitle: Text(
                          user.name.capitalize(),
                          style: EclipseTextStyle.subtitle,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, i) => const SizedBox(height: 10),
                );
              }

              return const ErrorTextWidget();
            },
          ),
        ),
      ),
    );
  }
}
