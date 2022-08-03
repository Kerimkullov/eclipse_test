import 'package:eclipse_test/constants/eclipse_text_style.dart';
import 'package:eclipse_test/pages/album/album_screen.dart';
import 'package:eclipse_test/pages/post/post_screen.dart';
import 'package:flutter/material.dart';

import '../../logic/models/user/user.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: const CircleAvatar(
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    size: 48,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _InfoContainer(
                category: 'Name:',
                value: user.name,
              ),
              _InfoContainer(
                category: 'Email:',
                value: user.email,
              ),
              _InfoContainer(
                category: 'Phone:',
                value: user.phone,
              ),
              _InfoContainer(
                category: 'Website:',
                value: user.website,
              ),
              _InfoContainer(
                category: 'Company:',
                value: user.company.name,
              ),
              _InfoContainer(
                category: 'Company BS:',
                value: user.company.bs,
              ),
              _InfoContainer(
                category: 'CatchPhrase:',
                value: ' "${user.company.catchPhrase}" ',
              ),
              _InfoContainer(
                category: 'Address:',
                value: user.address.toString(),
              ),
              const SizedBox(height: 24),
              const Text(
                'Posts',
                style: EclipseTextStyle.title,
              ),
              const SizedBox(height: 8),
              PostScreen(userId: user.id),
              const SizedBox(height: 24),
              const Text(
                'Albums',
                style: EclipseTextStyle.title,
              ),
              const SizedBox(height: 8),
              AlbumScreen(userId: user.id),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoContainer extends StatelessWidget {
  const _InfoContainer({
    Key? key,
    required this.category,
    required this.value,
  }) : super(key: key);

  final String category;

  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        InputDecorator(
          decoration: InputDecoration(
            labelText: category,
            labelStyle: EclipseTextStyle.categoryTitle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            value,
            style: EclipseTextStyle.categoryValue,
          ),
        ),
      ],
    );
  }
}
