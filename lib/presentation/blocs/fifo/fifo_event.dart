part of 'fifo_bloc.dart';

abstract class FifoEvent extends Equatable {
  const FifoEvent();

  @override
  List<Object> get props => [];
}

class Restart extends FifoEvent {}

class AddFifoElement extends FifoEvent {
  final FifoElement fifoElement;

  const AddFifoElement(this.fifoElement);

  @override
  List<Object> get props => [fifoElement];
}

class AddFifoColumn extends FifoEvent {
  final FifoColumn fifoColumn;

  const AddFifoColumn(this.fifoColumn);

  @override
  List<Object> get props => [fifoColumn];
}