part of 'login_bloc.dart';

abstract class LoginEvent{
  const LoginEvent();
}
class LoginChangeState extends LoginEvent{
  bool login;
  LoginChangeState(this.login);
}