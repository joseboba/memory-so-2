import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory/domain/entities/nru_element.dart';
import 'package:memory/presentation/blocs/nru/nru_bloc.dart';
import 'package:memory/presentation/widgets/widgets.dart';

class NruAlgorithmScreen extends StatelessWidget {
  const NruAlgorithmScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final nruState = context.watch<NruBloc>().state;
    final ScrollController controller = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Algoritmo NRU'),
        leading:  IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context,true);
            context.read<NruBloc>().add((Restart()));
          }
        )
      ),
      body: SingleChildScrollView(
        
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ingreso de página',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              createRowWithSwitch(text: "Modificado ", state: nruState, position: 1, context:  context ),
              createRowWithSwitch(text: "Reset", state: nruState, position: 2, context:  context),
              Container(
                height: 50,
                width: 300,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: createButton(
                    textButton: "Ingresar",
                    context: context,
                    state: nruState
                ),
              ),
              const Text(
                'Memoria virtual',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 500,
                  padding: const EdgeInsets.only(top: 15),
                  child: nruState.nruColumns.isNotEmpty ?
                  ScrollConfiguration(
                    behavior: MyCustomScrollBehavior(),
                    child: ListView.builder(
                      controller: controller,
                      itemCount: nruState.nruColumns.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                            children: [
                              MemoryColumn(nruColumn: nruState.nruColumns[index]),
                              const SizedBox(width: 10,)
                            ],
                          );
                      },
                    ),
                  )
                  : const SizedBox()
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      )
    );
  }

  Widget createRowWithSwitch({String text = "", required NruState  state, required int position, required BuildContext context}){
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black
          )
        ),
        const SizedBox(
          width: 20,
        ),
        Switch(
          value: position == 2 ? state.reset : state.modificationBit ,
          activeColor: Colors.lightBlue,
          onChanged: (bool value) {
            if(position == 2){
              context.read<NruBloc>().add(ChangeResetValue(value));
            } else {
               if(!state.reset){
                 context.read<NruBloc>().add(ChangeModificationValue(value));
               } 
            }
          })
      ],
    );
  }

  Widget createButton({String textButton = "botón", required NruState  state, required BuildContext context}){
    return  ElevatedButton(
      onPressed: ()=>{
        if(state.reset){
            if(state.nruColumns.isEmpty){
              _showMyDialog(context: context, text: "Se debe agregar alguna página.")
            } else {
              context.read<NruBloc>().add(ResetNruColumn(state.nruColumns.last))
            }
        } else {
            context.read<NruBloc>().add(AddNruElement(NruElement(page: (state.lastNruElementNumber + 1).toString(),referenceBit: "1", modificationBit: state.modificationBit ? "1": "0")))
        }
        //_showMyDialog(context: context, text:  "asdas")
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue
      ),
      child: Text(
        textButton,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
      )
    );
  }

  Future<void> _showMyDialog({required BuildContext context, required String text}) async {

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Aviso'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text)
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Aceptar', style: TextStyle(color: Colors.white),),
            style: TextButton.styleFrom(
              backgroundColor: Colors.lightBlue,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}

   class MyCustomScrollBehavior extends MaterialScrollBehavior {
      // Override behavior methods and getters like dragDevices
      @override
      Set<PointerDeviceKind> get dragDevices => { 
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
    }
