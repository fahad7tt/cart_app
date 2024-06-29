abstract class SplashState {}

class InitialState extends SplashState {}


class LoadingState extends SplashState {}

class LoadedState extends SplashState {
  // ignore: prefer_typing_uninitialized_variables
  final loginState;
  LoadedState({required this.loginState});
}