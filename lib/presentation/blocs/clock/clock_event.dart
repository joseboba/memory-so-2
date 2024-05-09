part of 'clock_bloc.dart';

sealed class ClockEvent extends Equatable {
  const ClockEvent();

  @override
  List<Object> get props => [];
}

class ClockAddNewProcess extends ClockEvent {  }

class CleanClockProcesses extends ClockEvent { }