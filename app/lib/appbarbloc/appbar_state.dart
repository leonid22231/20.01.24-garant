part of 'appbar_bloc.dart';

abstract class AppBarState{
  const AppBarState();
}
class AppBarLoaded extends AppBarState{
  final AppBarStateEnum state;
  AppBarLoaded(this.state);
}