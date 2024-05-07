
part of 'nru_bloc.dart';

@immutable
abstract class NruEvent {}


class InitializeNru extends NruEvent {

  InitializeNru();
}

class AddNruElement extends NruEvent {
  final nruElement;
  AddNruElement(this.nruElement);
}
