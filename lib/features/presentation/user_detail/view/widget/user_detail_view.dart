import 'package:flutter/material.dart';
import 'package:prj/features/domain/entities/api_user.dart';

class UserDetailView extends StatelessWidget {
  final ApiUser user;

  const UserDetailView({super.key, required this.user});

  Widget _info(String label, String value) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value.trim().isEmpty ? 'Chưa cập nhật' : value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final avatarUri = Uri.tryParse(user.avatar);
    final hasAvatar =
        avatarUri != null &&
        (avatarUri.scheme == 'https' || avatarUri.scheme == 'http') &&
        avatarUri.host.isNotEmpty;
    const placeholder = ColoredBox(color: Colors.white);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: ClipOval(
              child: SizedBox(
                width: 140,
                height: 140,
                child: hasAvatar
                    ? Image.network(
                        user.avatar,
                        fit: BoxFit.cover,
                        errorBuilder: (_, error, stackTrace) => placeholder,
                      )
                    : placeholder,
              ),
            ),
          ),
          SizedBox(height: 24),
          _info('Họ tên', user.name),
          _info('Tài khoản', user.account),
          _info('Email', user.email),
          _info('Số điện thoại', user.phoneNumber),
          _info('Phòng ban', user.departmentNumber),
        ],
      ),
    );
  }
}
