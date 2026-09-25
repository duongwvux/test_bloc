import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<int> {
  HomeCubit() : super(0);
  void increment() {
    return emit(state + 1);
  }

  void decrement() {
    return emit((state - 1 > 0)? state - 1: 0);
  }
}