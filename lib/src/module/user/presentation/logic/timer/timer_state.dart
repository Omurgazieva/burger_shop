part of 'timer_cubit.dart';

class TimerState extends Equatable {
  const TimerState();
  @override
  List<Object> get props => [];
}

class InitialState extends TimerState {}

class StartTimerState extends TimerState {}

class RunTimerState extends TimerState {
  final int time;
  const RunTimerState(this.time);
  @override
  List<Object> get props => [time];
}

class FinishedTimerState extends TimerState {
  final int time;
  const FinishedTimerState(this.time);
  @override
  List<Object> get props => [time];
}

class TimerFailureState extends TimerState {
  final String message;
  const TimerFailureState(this.message);
  @override
  List<Object> get props => [message];
}
