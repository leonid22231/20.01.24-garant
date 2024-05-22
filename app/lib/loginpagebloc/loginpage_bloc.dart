import 'package:flutter_bloc/flutter_bloc.dart';

import 'loginstate.dart';

part 'loginpage_event.dart';
part 'loginpage_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState>{
  LoginPageBloc(): super(LoginPageLoaded(LoginStateEnum.LOGIN));

  @override
  Stream<LoginPageState> mapEventToState(
      LoginPageEvent event,
      ) async* {
    if (event is LoginChangePage) {
      yield LoginPageLoaded(event.state);
    }
  }
}