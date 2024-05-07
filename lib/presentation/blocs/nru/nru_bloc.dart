import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:memory/domain/entities/nru_column.dart';

part 'nru_event.dart';
part 'nru_state.dart';


class NruBloc extends Bloc<NruEvent, NruState> {

  NruBloc() : super(const NruState(nruColumns: [])) {
    on<NruEvent>((event, emit) => {});
  }


}