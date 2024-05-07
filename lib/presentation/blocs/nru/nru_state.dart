part of 'nru_bloc.dart';

@immutable
abstract class NruState {

  final List<NruColumn> nruColumns;
  final bool modificationBit;
  final bool reset;
 

  NruState({required this.nruColumns, this.modificationBit = false, this.reset = false});

}


class NruInitialState extends NruState {

   NruInitialState() : super(nruColumns: List<NruColumn>.empty());
}