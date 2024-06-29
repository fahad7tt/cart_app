import 'dart:async';
import 'package:bloc_sample/application/splash_cubit/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(InitialState()) {
    emit(LoadingState());
    Future.delayed(const Duration(seconds: 3), () async {
      // ignore: no_leading_underscores_for_local_identifiers
      final SharedPreferences _shared = await SharedPreferences.getInstance();
      // ignore: await_only_futures
      final login = await _shared.getBool("Login");
      emit(LoadedState(loginState: login));
    });
  }
}