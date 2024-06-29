import 'package:bloc_sample/application/login_bloc/login_event.dart';
import 'package:bloc_sample/application/login_bloc/login_state.dart';
import 'package:bloc_sample/domain/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginChecking>((event, emit) async {
      //login process in progress
      emit(LoginCheckingState());
      //verify login credentials
      final resp = await checkloginstatus(event.user, event.pass);
      // ignore: avoid_print
      print(resp.statusCode);
      if (resp.statusCode == 200) {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState(error: ''));
      }
    });
    on<LoginSuccess>((event, emit) => emit(LoginSuccessState()));
  }
}