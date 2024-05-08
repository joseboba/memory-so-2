
part of 'nru_bloc.dart';


abstract class NruEvent extends Equatable {
  const NruEvent();

  @override
  List<Object> get props => [];
}

class Restart extends NruEvent {}

class AddNruElement extends NruEvent {
  final NruElement nruElement;

  const AddNruElement(this.nruElement);

  @override
  List<Object> get props => [nruElement];
}

class ChangeResetValue extends NruEvent {
  final bool reset;

  const ChangeResetValue(this.reset);

  @override
  List<Object> get props => [reset];
}

class ChangeModificationValue extends NruEvent {
  final bool modificationBit;

  const ChangeModificationValue(this.modificationBit);

    @override
  List<Object> get props => [modificationBit];
}

class AddNruColumn extends NruEvent {
  final NruColumn nruColumn;

  const AddNruColumn(this.nruColumn);

  @override
  List<Object> get props => [nruColumn];
}

class ResetNruColumn extends NruEvent {
  final NruColumn nruColumn;

  const ResetNruColumn(this.nruColumn);

  @override
  List<Object> get props => [nruColumn];
}