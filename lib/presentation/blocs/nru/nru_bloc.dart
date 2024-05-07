import 'package:bloc/bloc.dart';
import 'package:memory/domain/entities/nru_column.dart';
import 'package:meta/meta.dart';

part 'nru_event.dart';
part 'nru_state.dart';


class NruBloc extends Bloc<NruEvent, NruState> {

  NruBloc() : super(NruInitialState()) {
    on<InitializeNru>((event, emit) => {});
  }




}