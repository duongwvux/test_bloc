import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/features/data/repositories/database_auth_repository.dart';
import 'package:prj/features/data/datasources/database/auth_database.dart';
import 'package:prj/features/data/security/argon2_password_hasher.dart';
import 'package:prj/features/domain/repositories/auth_repository.dart';
import 'package:prj/features/presentation/register/view/page/register_page.dart';
import 'package:sqflite/sqflite.dart';

import 'features/presentation/user/view/page/user_page.dart';
import 'features/presentation/login/view/page/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await AuthDatabase.open();
  final previousErrorHandler = FlutterError.onError;
  FlutterError.onError = (details) {
    developer.log(
      'Flutter error: ${details.context?.toDescription() ?? details.library ?? 'unknown context'}',
      name: 'App.FlutterError',
      level: 1000,
      error: details.exception,
      stackTrace: details.stack,
    );
    // Preserve Flutter's normal console reporting and error handling.
    if (previousErrorHandler != null) {
      previousErrorHandler(details);
    } else {
      FlutterError.presentError(details);
    }
  };
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final Database database;
  const MyApp({super.key, required this.database});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (_) => DatabaseAuthRepository(
        database: database,
        passwordHasher: const Argon2PasswordHasher(),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        routes: {
          '/home': (context) {
            developer.log('Creating /home route', name: 'Auth.Navigation');
            return const UserPage(
              token: String.fromEnvironment('token'),
              requestBody: {
                'status': [1],
                'getAll': true,
              },
            );
          },
          '/register': (_) => const RegisterPage(),
        },
        home: LoginPage(),
      ),
    );
  }
}
