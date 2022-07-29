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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 10),
                Text('Name:'),
                SizedBox(height: 10),
                Text('Email:'),
                SizedBox(height: 10),
                Text('Phone'),
                SizedBox(height: 10),
                Text('Website'),
                SizedBox(height: 10),
                Text('Company'),
                SizedBox(height: 10),
                Text('Company bs'),
                SizedBox(height: 10),
                Text('CatchPhrase'),
                SizedBox(height: 10),
                Text('Address'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(user.name),
                const SizedBox(height: 10),
                Text(user.email),
                const SizedBox(height: 10),
                Text(user.phone),
                const SizedBox(height: 10),
                Text(user.website),
                const SizedBox(height: 10),
                Text(user.company.name),
                const SizedBox(height: 10),
                Text(user.company.bs),
                const SizedBox(height: 10),
                Text(user.company.catchPhrase),
                const SizedBox(height: 10),
                Text(user.address.city),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
