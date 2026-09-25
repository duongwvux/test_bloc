import 'package:flutter/material.dart';
import 'package:prj/features/domain/entities/api_user.dart';

import 'user_list.dart';

class SearchableUserList extends StatefulWidget {
  final List<ApiUser> users;

  const SearchableUserList({super.key, required this.users});

  @override
  State<SearchableUserList> createState() => _SearchableUserListState();
}

class _SearchableUserListState extends State<SearchableUserList> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredUsers = query.isEmpty
        ? widget.users
        : widget.users.where((user) {
            return [
              user.name,
              user.account,
              user.email,
              user.phoneNumber,
            ].any((value) => value.toLowerCase().contains(query));
          }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              labelText: 'Tìm kiếm người dùng',
              hintText: 'Tên, tài khoản, email hoặc số điện thoại',
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      tooltip: 'Xóa tìm kiếm',
                      onPressed: () {
                        setState(_searchController.clear);
                      },
                      icon: const Icon(Icons.clear),
                    ),
            ),
          ),
        ),
        Expanded(
          child: query.isNotEmpty && filteredUsers.isEmpty
              ? const Center(child: Text('Không tìm thấy người dùng phù hợp.'))
              : UserList(users: filteredUsers),
        ),
      ],
    );
  }
}
