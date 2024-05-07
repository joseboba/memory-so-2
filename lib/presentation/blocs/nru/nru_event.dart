
part of 'nru_bloc.dart';


abstract class NruEvent extends Equatable {
  const NruEvent();

  @override
  List<Object> get props => [];
}

class AddNruElement extends NruEvent {
  final NruColumn nruElement;

  const AddNruElement(this.nruElement);

  @override
  List<Object> get props => [nruElement];
}
