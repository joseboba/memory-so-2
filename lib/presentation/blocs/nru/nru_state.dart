part of 'nru_bloc.dart';

class NruState extends Equatable {
  final List<NruColumn> nruColumns;
  final bool modificationBit;
  final bool reset;
  final int lastNruElementNumber;
 

  const NruState({required this.nruColumns ,this.modificationBit = false, this.reset = false, this.lastNruElementNumber = 0});

  NruState copyWith({
    List<NruColumn>? nruColumns,
    bool? modificationBit,
    bool? reset,
    int? lastNruElementNumber,
  }) {
    return NruState(
      nruColumns: nruColumns ?? this.nruColumns,
      modificationBit: modificationBit ?? this.modificationBit,
      reset: reset ?? this.reset,
      lastNruElementNumber: lastNruElementNumber ?? this.lastNruElementNumber
    );
  }

  @override
  List<Object> get props => [nruColumns, modificationBit, reset, lastNruElementNumber];
}


