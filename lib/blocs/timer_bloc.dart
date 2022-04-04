import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'timer_event.dart';

part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;
  TimerBloc() : super(const TimerState([])) {
    on<AddTimer>((event, emit) => _addTimerEventToState(event, emit));
    on<NewTimerState>((event, emit) => _newTimerState(event, emit));
    on<StartTimer>((event, emit) => _startTimer(event, emit));
  }

  Future<void> _addTimerEventToState(
      AddTimer event, Emitter<TimerState> emit) async {
    final int duration = Random().nextInt(10) + 10;
    final List<int> list = List.from(state.list);
    list.add(duration);
    emit(TimerState(list));
  }

  _newTimerState(NewTimerState event, Emitter<TimerState> emit) {
    emit(TimerState(event.list));
  }

  _startTimer(StartTimer event, Emitter<TimerState> emit) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.list.isEmpty) {
        return;
      }

      int count = 0;
      List<int> list = List.from(state.list);
      for (int i = 0; i < list.length; i++) {
        int temp = list[i];
        if (count < 4) {
          count++;
          list[i] = --temp;
        }
      }
      list = list.where((element) => element != 0).toList();
      add(NewTimerState(list));
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
