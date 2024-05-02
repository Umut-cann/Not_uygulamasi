import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConstCubit extends Cubit<Color> {
  ConstCubit() : super(Colors.white);

  void toggleFavoriteColor() {
    if (state == Colors.white) {
      emit(Colors.red);
    } else {
      emit(Colors.white);
    }
  }
}

class splashCubit extends Cubit<bool> {
  splashCubit() : super(false);

  void truebool() {
    emit(true);
  }
}
