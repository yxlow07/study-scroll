import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:study_scroll/core/theme/AppTheme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit(super.initialState);

  static final _darkTheme = AppTheme.darkTheme;
  static final _lightTheme = AppTheme.lightTheme;

  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }

  void setLightTheme() {
    emit(_lightTheme);
  }

  void setDarkTheme() {
    emit(_darkTheme);
  }
}
