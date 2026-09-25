import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/features/domain/repositories/auth_repository.dart';
import 'package:prj/features/presentation/register/bloc/register_bloc.dart';
import 'package:prj/features/presentation/register/bloc/register_state.dart';
import 'package:prj/features/presentation/register/view/widget/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterBloc(context.read<AuthRepository>(),),
        child: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is RegisterSuccess) {
                Navigator.of(context).pushReplacementNamed('/home');
              }
            },
            child: Scaffold(
              appBar: AppBar(title: const Text('Đăng ký'),),
              body: const SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(24),
                      child: RegisterForm(),
                    ),
                  )
              ),
            ),
        ),
    );
  }
}