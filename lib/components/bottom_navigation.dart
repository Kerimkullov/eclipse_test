import 'package:eclipse_test/logic/bloc/album/album_bloc.dart';
import 'package:eclipse_test/logic/bloc/post/post_bloc.dart';
import 'package:eclipse_test/logic/bloc/user/user_bloc.dart';
import 'package:eclipse_test/pages/album/album_screen.dart';
import 'package:eclipse_test/pages/user/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/post/post_screen.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  static const List<Widget> _widgetList = [
    UserScreen(),
    PostScreen(),
    AlbumScreen(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (BuildContext context) =>
                UserBloc()..add(GetUserListEvent()),
          ),
          BlocProvider<PostBloc>(
            create: (BuildContext context) => PostBloc()
              ..add(
                GetPostList(),
              ),
          ),
          BlocProvider<AlbumBloc>(
            create: (BuildContext context) => AlbumBloc()
              ..add(
                GetAlbumList(),
              ),
          ),
        ],
        child: _widgetList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.album),
            label: 'Album',
          ),
        ],
      ),
    );
  }
}
