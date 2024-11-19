import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(InitialState());

  int time = 30;

  void startTimer() {
    time = 30;
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (time == 0) {
        timer.cancel();
        emit(FinishedTimerState(time));
      } else {
        time--;
        emit(RunTimerState(time));
      }
    });
  }
}
