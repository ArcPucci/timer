part of 'timer_bloc.dart';

@immutable
abstract class TimerEvent {}

class AddTimer extends TimerEvent {
}

class NewTimerState extends TimerEvent {
  final List<int> list;

  NewTimerState(this.list);
}

class StartTimer extends TimerEvent {}