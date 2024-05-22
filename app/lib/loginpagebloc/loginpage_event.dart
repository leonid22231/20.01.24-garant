part of 'loginpage_bloc.dart';

abstract class LoginPageEvent{
  const LoginPageEvent();
}
class LoginChangePage extends LoginPageEvent{
  LoginStateEnum state;
  LoginChangePage(this.state);
}