import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState>{
  UpdateBloc(): super(UpdateStateLoaded());

  @override
  Stream<UpdateState> mapEventToState(
      UpdateEvent event,
      ) async* {
    if (event is UpdateEventUpdate) {
      yield UpdateStateLoaded();
    }
  }
}