import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    developer.log('HomePage.build started', name: 'Auth.Navigation');
    return Scaffold(
      appBar: AppBar(title: const Text('Home'),),
      body: BlocBuilder<HomeCubit, int>(
        builder: (context, count) => Center(child: Text('$count'),),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'Increment',
            child: const Icon(Icons.add),
            onPressed: () => context.read<HomeCubit>().increment(),
          ),
          const SizedBox(height: 4,),
          FloatingActionButton(
            heroTag: 'Decrement',
            child: const Icon(Icons.remove),
            onPressed: () => context.read<HomeCubit>().decrement(),
          )
        ],
      ),
    );
  }
}
