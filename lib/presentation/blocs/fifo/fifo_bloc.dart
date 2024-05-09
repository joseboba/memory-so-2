import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:memory/domain/entities/fifo_column.dart';
import 'package:memory/domain/entities/fifo_element.dart';

part 'fifo_event.dart';
part 'fifo_state.dart';

class FifoBloc extends Bloc<FifoEvent, FifoState> {
  
  FifoBloc() : super(const FifoState(fifoColumns: [])) {

    on<Restart>((event, emit) {
      emit(state.copyWith(fifoColumns: [], lastFifoElementNumber: 0));
    });

    on<AddFifoColumn>((event, emit) {
      final state = this.state;
      if(state.fifoColumns.last.fifoElements.last.page != '') {
        emit(state.copyWith(fifoColumns: List.from(state.fifoColumns)..add(event.fifoColumn)));
      }
    });

    on<AddFifoElement>((event, emit) {
      final state = this.state;
      List<FifoElement> elements = [];

      if(state.fifoColumns.isEmpty) {
        elements.add(FifoElement(page: event.fifoElement.page, time: event.fifoElement.time));
        emit(state.copyWith(fifoColumns: List.from(state.fifoColumns)..add(
          FifoColumn(fifoElements: elements)),
          lastFifoElementNumber: int.parse(event.fifoElement.page)));
      } else if(state.fifoColumns.last.fifoElements.last.page == '') {
        elements = [...state.fifoColumns.last.fifoElements.where((fifoElement) => fifoElement.page != ''), FifoElement(page: event.fifoElement.page, time: event.fifoElement.time)];
        emit(state.copyWith(fifoColumns: List.from(state.fifoColumns)..add(
          FifoColumn(fifoElements: elements)),
          lastFifoElementNumber: int.parse(event.fifoElement.page)));
      } else {
        final state = this.state;
        List<FifoElement> elements = [...state.fifoColumns.last.fifoElements];
        int positionOfElementToDelete = 0;

        for(int i = 0; i < elements.length; i++) {
          if(elements[positionOfElementToDelete].time > elements[i].time) {
            positionOfElementToDelete = i;
          }
        }

        elements[positionOfElementToDelete] = event.fifoElement;

        emit(state.copyWith(fifoColumns: List.from(state.fifoColumns)..add(
          FifoColumn(fifoElements: elements)),
          lastFifoElementNumber: int.parse(event.fifoElement.page)));

      }
    });

  }

}