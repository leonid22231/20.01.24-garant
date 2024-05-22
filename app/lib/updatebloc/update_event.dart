part of 'update_bloc.dart';

abstract class UpdateEvent{
  const UpdateEvent();
}
class UpdateEventUpdate extends UpdateEvent{
  UpdateEventUpdate();
}