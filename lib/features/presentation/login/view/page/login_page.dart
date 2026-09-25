import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/features/domain/repositories/auth_repository.dart';
import '../../bloc/login_bloc.dart';
import '../../bloc/login_state.dart';
import '../widget/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        context.read<AuthRepository>(),
      ),
      child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            developer.log(
              'Login state: ${state.runtimeType}',
              name: 'Auth.Navigation',
            );
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
              );
            } else if (state is Authenticated) {
              developer.log(
                'Authenticated: requesting replacement with /home',
                name: 'Auth.Navigation',
              );
              try {
                Navigator.of(context).pushReplacementNamed('/home');
                developer.log(
                  'Navigation request accepted; /home has not necessarily rendered yet',
                  name: 'Auth.Navigation',
                );
              } catch (error, stackTrace) {
                developer.log(
                  'Failed to request /home navigation',
                  name: 'Auth.Navigation',
                  level: 1000,
                  error: error,
                  stackTrace: stackTrace,
                );
                rethrow;
              }
            } else if (state is Register) {
              Navigator.of(context).pushReplacementNamed('/register');
            }
          },
          child: Scaffold(
            appBar: AppBar(title: const Text('Đăng nhập')),
            body: const SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24),
                    child: LoginForm(),
                  ),
                )
            ),
        ),
      ),
    );
  }
}
