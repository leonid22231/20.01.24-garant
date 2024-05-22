part of 'appbar_bloc.dart';

abstract class AppBarEvent{
  const AppBarEvent();
}
class AppBarChangeState extends AppBarEvent{
  AppBarStateEnum state;
  AppBarChangeState(this.state);
}