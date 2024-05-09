part of 'fifo_bloc.dart';

class FifoState extends Equatable {

  final List<FifoColumn> fifoColumns;
  final int lastFifoElementNumber;

  const FifoState({required this.fifoColumns, this.lastFifoElementNumber = 0});

  FifoState copyWith({
    List<FifoColumn>? fifoColumns,
    int? lastFifoElementNumber,
  }) {
    return FifoState(
      fifoColumns: fifoColumns ?? this.fifoColumns,
      lastFifoElementNumber: lastFifoElementNumber ?? this.lastFifoElementNumber
    );
  }

  @override
  List<Object> get props => [fifoColumns, lastFifoElementNumber];

}