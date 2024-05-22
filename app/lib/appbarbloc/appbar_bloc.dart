import 'package:flutter_bloc/flutter_bloc.dart';

import 'appbar_state_enum.dart';

part 'appbar_event.dart';
part 'appbar_state.dart';

class AppBarBloc extends Bloc<AppBarEvent, AppBarState>{
  AppBarBloc(): super(AppBarLoaded(AppBarStateEnum.HOME));

  @override
  Stream<AppBarState> mapEventToState(
      AppBarEvent event,
      ) async* {
    if (event is AppBarChangeState) {
      yield AppBarLoaded(event.state);
    }
  }
}