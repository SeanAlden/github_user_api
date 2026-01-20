import 'package:flutter/material.dart';
import '../../data/models/github_user.dart';

class UserListWidget extends StatelessWidget {
  final GithubUser user;
  final VoidCallback onTap;

  const UserListWidget({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(user.avatarUrl),
      ),
      title: Text('Username : ${user.username}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          Text('Name : ${user.name ?? '-'}'),
          Text('Location : ${user.location ?? '-'}'),
        ],
      ),
      onTap: onTap,
    );
  }
}
