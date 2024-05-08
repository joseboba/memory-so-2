import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'clock_event.dart';
part 'clock_state.dart';

class ClockBloc extends Bloc<ClockEvent, ClockState> {
  ClockBloc() : super(const ClockState()) {

    on<ClockAddNewProcess>(_newProcess);

    on<CleanClockProcesses>(_cleanProcesses);

  }

  void addNewProcess() {
    add(ClockAddNewProcess());
  }

  void cleanProcesses() {
    add(CleanClockProcesses());
  }

  void _newProcess(ClockAddNewProcess event, Emitter<ClockState> emit) async {
    emit(state.copyWith(isInProgress: true));
    await Future.delayed(const Duration(milliseconds: 200));
    final pages = Map<int, int?>.from(state.pages);
    final activePages = Map<int, bool>.from(state.activePages);
    final page = state.page + 1;

    if (state.allNotNull) {
      bool nextActivate = activePages[1] ?? false;
      int nextIdentification = 1;
      while (nextActivate) {
        activePages[nextIdentification] = false;
        pages[nextIdentification] = null;
        final newTurn = _calculateNextTurn(nextIdentification, emit);
        emit(state.copyWith(turn: newTurn, pages: pages, activePages: activePages));
        await Future.delayed(const Duration(milliseconds: 500));
        nextIdentification++;
        nextActivate = activePages[nextIdentification] ?? false;
      }
    }

    for (final pageEntry in pages.entries) {
      final key = pageEntry.key;
      final value = pageEntry.value;
      final isActive = activePages[key]!;
      final nextTurn = _calculateNextTurn(key, emit);

      if (!isActive && value == null) {
        activePages[key] = true;
        pages[key] = page;
        emit(state.copyWith(turn: nextTurn, page: page));
        break;
      }
    }

    emit(state.copyWith(page: page, pages: pages, activePages: activePages, isInProgress: false));
  }

  double _calculateNextTurn(int key, Emitter<ClockState> emit) {
    if (key == 6) {
      final newBaseValue = state.turn.ceilToDouble();
      emit(state.copyWith(pageTurnValue: _setNewTurnValues()));
      return newBaseValue;
    }


    final nextTurn = state.turn + (state.pageTurnValue[key + 1]! - state.turn);
    return double.parse(nextTurn.toStringAsFixed(2));
  }

  Map<int, double> _setNewTurnValues() {
    final pageTurnValues = Map<int, double>.from(state.pageTurnValue);
    pageTurnValues.forEach((key, value) {
      pageTurnValues[key] = double.parse((value + 1).toStringAsFixed(2));
    });

    return pageTurnValues;
  }

  void _cleanProcesses(CleanClockProcesses event, Emitter<ClockState> emit) async {
    emit(state.copyWith(isInProgress: true));
    await Future.delayed(const Duration(milliseconds: 200));

    emit(state.copyWith(
      page: 0,
      pages: initialPages,
      turn: 0,
      activePages: initialActivePages,
      pageTurnValue: pageTurnValues,
      isInProgress: false
    ));
  }
}
