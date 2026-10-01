import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/features/domain/entities/api_user.dart';
import 'package:prj/features/presentation/user_detail/bloc/user_detail_bloc.dart';
import 'package:prj/features/presentation/user_detail/bloc/user_detail_event.dart';
import 'package:prj/features/presentation/user_detail/bloc/user_detail_state.dart';

import '../widget/user_detail_view.dart';

class UserDetailPage extends StatelessWidget {
  final ApiUser user;
  
  const UserDetailPage({
    super.key,
    required this.user,
  });
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserDetailBloc()
          ..add(UserDetailOpened(user)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thông tin người dùng'),
        ),
        body: BlocBuilder<UserDetailBloc, UserDetailState>(
            builder: (context, state) {
              if (state is UserDetailLoaded) {
                return UserDetailView(user: state.user);
              }

              if (state is UserDetailFailure) {
                return Center(child: Text(state.message),);
              }

              return const SizedBox.shrink();
            }
        ),
      ),
    );
  }
}