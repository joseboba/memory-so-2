import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:memory/domain/entities/nru_column.dart';
import 'package:memory/domain/entities/nru_element.dart';

part 'nru_event.dart';
part 'nru_state.dart';


class NruBloc extends Bloc<NruEvent, NruState> {

  NruBloc() : super(const NruState(nruColumns: [])) {

    on<Restart>((event, emit){
      emit(state.copyWith(nruColumns: [],reset: false, modificationBit: false, lastNruElementNumber: 0));
    });


    on<ChangeResetValue>((event, emit) {

      final state = this.state;
      emit(state.copyWith(reset: event.reset, modificationBit: false));
    });

    on<ChangeModificationValue>((event, emit) {

      final state = this.state;

      emit((state.copyWith(modificationBit: event.modificationBit, reset:  state.reset)));
    });

    on<AddNruColumn>((event, emit) {
        final state = this.state;

        if(state.nruColumns.last.nruElements.last.page != ""){
          emit(state.copyWith(nruColumns: List.from(state.nruColumns)..add(event.nruColumn), modificationBit: false, reset: false));
        }
    });

    on<AddNruElement>((event, emit) {
      final state = this.state;
      List<NruElement> elements = [];



      if(state.nruColumns.isEmpty){
        elements.add(NruElement(page:event.nruElement.page, modificationBit: event.nruElement.modificationBit, referenceBit: event.nruElement.referenceBit));
        emit(state.copyWith(nruColumns: List.from(state.nruColumns)..add(
          NruColumn(nruElements: elements)), 
          modificationBit: false, reset: false,lastNruElementNumber: int.parse(event.nruElement.page)));
      } else if (state.nruColumns.last.nruElements.last.page == ""){
        
        elements = [...state.nruColumns.last.nruElements.where((nruElement) => nruElement.page != "") ,NruElement(page: event.nruElement.page, referenceBit: event.nruElement.referenceBit,  modificationBit: event.nruElement.modificationBit)];
        
        
        emit(state.copyWith(nruColumns: List.from(state.nruColumns)..add(
          NruColumn(nruElements: elements)), 
          modificationBit: false, reset: false,lastNruElementNumber: int.parse(event.nruElement.page)));
      } else {
        final state = this.state;
        List<NruElement> elements = [...state.nruColumns.last.nruElements];
        int positionOfElementToDelete = -1;

        if(elements.firstWhere((nruElement) => nruElement.referenceBit == "0" && nruElement.modificationBit == "0",orElse: () => NruElement()).page != ""){
          positionOfElementToDelete = elements.indexOf(elements.firstWhere((nruElement) => nruElement.referenceBit == "0" && nruElement.modificationBit == "0"));
        } else if (elements.firstWhere((nruElement) => nruElement.referenceBit == "0" && nruElement.modificationBit == "1",orElse: () => NruElement()).page != "") {
          positionOfElementToDelete = elements.indexOf(elements.firstWhere((nruElement) => nruElement.referenceBit == "0" && nruElement.modificationBit == "1"));
        } else if (elements.firstWhere((nruElement) => nruElement.referenceBit == "1" && nruElement.modificationBit == "0",orElse: () => NruElement()).page != ""){
          positionOfElementToDelete = elements.indexOf(elements.firstWhere((nruElement) => nruElement.referenceBit == "1" && nruElement.modificationBit == "0"));
        } else {
          positionOfElementToDelete = elements.indexOf(elements.firstWhere((nruElement) => nruElement.referenceBit == "1" && nruElement.modificationBit == "1"));
        }


        elements[positionOfElementToDelete] = event.nruElement;


        emit(state.copyWith(nruColumns: List.from(state.nruColumns)..add(
          NruColumn(nruElements: elements)), 
          modificationBit: false, reset: false,lastNruElementNumber: int.parse(event.nruElement.page)));

      }
    });

    on<ResetNruColumn>((event, emit){
      final state = this.state;
      List<NruElement> elements = [];

      elements = [...event.nruColumn.nruElements.where((nruElement) => nruElement.page != "")];
      elements = elements.map((nruElement)=> NruElement(page: nruElement.page, referenceBit: "0", modificationBit: nruElement.modificationBit)).toList();

      emit(state.copyWith(nruColumns: List.from(state.nruColumns)..add(
          NruColumn(nruElements: elements)), 
          modificationBit: false, reset: false));
    });
  }


}