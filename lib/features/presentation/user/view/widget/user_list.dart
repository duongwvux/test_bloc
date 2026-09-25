import 'package:flutter/material.dart';
import 'package:prj/features/domain/entities/api_user.dart';

class UserList extends StatelessWidget {
  final List<ApiUser> users;
  const UserList({
    super.key,
    required this.users
  });

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const Center(
        child: Text('Không có người dùng.'),
      );
    }

    return ListView.separated(
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(user.name.isNotEmpty ? user.name : user.account),
            subtitle: Text(
              [
                user.email,
                user.phoneNumber,
                user.departmentNumber,
              ].where((value) => value.isNotEmpty).join('\n'),
            ),
          );
        },
        separatorBuilder: (_, _) => const Divider(height: 1,),
        itemCount: users.length
    );
  }
}