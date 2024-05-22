part of 'loginpage_bloc.dart';

abstract class LoginPageState{
  const LoginPageState();
}
class LoginPageLoaded extends LoginPageState{
  final LoginStateEnum state;
  LoginPageLoaded(this.state);
}