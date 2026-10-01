import 'package:flutter/material.dart';
import 'package:prj/features/domain/entities/api_user.dart';

import 'user_search_field.dart';

class UserList extends StatefulWidget {
  final List<ApiUser> users;
  const UserList({super.key, required this.users});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final _searchController = TextEditingController();

  List<ApiUser> get _visibleUsers {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return widget.users;

    return widget.users.where((user) {
      return [
        user.name,
        user.account,
        user.email,
        user.phoneNumber,
      ].any((value) => value.toLowerCase().contains(query));
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = _visibleUsers;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: UserSearchField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
          ),
        ),
        Expanded(child: _buildList(users)),
      ],
    );
  }

  Widget _buildList(List<ApiUser> users) {
    if (users.isEmpty) {
      return Center(
        child: Text(
          widget.users.isEmpty
              ? 'Không có người dùng.'
              : 'Không tìm thấy người dùng phù hợp.',
        ),
      );
    }


    return ListView.separated(
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(user.name.isNotEmpty ? user.name : user.account),
          subtitle: Text(
            [
              user.email,
              user.phoneNumber,
              user.departmentNumber,
            ].where((value) => value.isNotEmpty).join('\n'),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: user.id.isEmpty
              ? null
              : () {
                  Navigator.of(context).pushNamed(
                    '/users/${Uri.encodeComponent(user.id)}',
                    arguments: user,
                  );
                }
        );
      },
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemCount: users.length,
    );
  }
}
