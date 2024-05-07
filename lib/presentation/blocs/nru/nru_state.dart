part of 'nru_bloc.dart';

class NruState extends Equatable {
  final List<NruColumn> nruColumns;
  final bool modificationBit;
  final bool reset;
 

  const NruState({required this.nruColumns, this.modificationBit = false, this.reset = false});

  NruState copyWith({
    List<NruColumn>? nruColumns,
    bool? modificationBit,
    bool? reset,
  }) {
    return NruState(
      nruColumns: nruColumns ?? this.nruColumns,
      modificationBit: modificationBit ?? this.modificationBit,
      reset: reset ?? this.reset,
    );
  }

  @override
  List<Object> get props => [nruColumns, modificationBit, reset];
}