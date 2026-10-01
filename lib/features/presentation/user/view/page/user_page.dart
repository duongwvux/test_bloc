import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/features/data/repositories/api_user_repository.dart';
import 'package:prj/features/presentation/user/bloc/user_bloc.dart';
import 'package:prj/features/presentation/user/bloc/user_event.dart';
import 'package:prj/features/presentation/user/bloc/user_state.dart';
import 'package:prj/features/presentation/user/view/widget/user_list.dart';

class UserPage extends StatelessWidget {
  final String token;
  final Map<String, dynamic>? requestBody;

  const UserPage({
    super.key,
    required this.token,
    this.requestBody,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ApiUserRepository>(
        create: (_) => ApiUserRepository(
            token: token,
            requestBody: requestBody,
        ),
        child: BlocProvider(
            create: (context) => UserBloc(
              context.read<ApiUserRepository>(),
            )..add(const UsersRequested()),
            child: Scaffold(
              appBar: AppBar(title: const Text('Danh sách người dùng'),),
              body: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoaded) {
                      return UserList(users: state.users);
                    }
                    if (state is UserFailure) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(state.message),
                            const SizedBox(height: 12,),
                            FilledButton(
                                onPressed: () =>
                                {
                                  context.read<UserBloc>().add(
                                      const UsersRequested())
                                },
                                child: const Text('Thử lại'),
                            ),
                          ],
                        ),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
              ),
            ),
        ),
    );
  }
}
