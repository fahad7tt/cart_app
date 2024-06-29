abstract class LoginEvent {}

class LoginChecking extends LoginEvent {
  String? user;
  String? pass;
  LoginChecking({this.user, this.pass});
}

class LoginSuccess extends LoginEvent {}