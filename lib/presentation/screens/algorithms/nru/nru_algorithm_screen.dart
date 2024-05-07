import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory/presentation/blocs/nru/nru_bloc.dart';
import 'package:memory/presentation/widgets/widgets.dart';

class NruAlgorithmScreen extends StatelessWidget {
  const NruAlgorithmScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final nruState = context.watch<NruBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Algoritmo NRU'),
      ),
      body:Padding(
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
            const Text(
              "Ingrese el número de página",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black
              ),
            ),
            Container(
              width: 300,
              height: 50,
              margin: const EdgeInsets.only(top: 10),
              child:
              TextField(
                obscureText: false,
                enabled: true,
                decoration: const InputDecoration(
                    labelStyle: TextStyle(
                        color: Colors.black
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Página',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue)
                    )
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),

            ),
            createRowWithSwitch(text: "Modificado "),
            createRowWithSwitch(text: "Reset"),
            Container(
              height: 50,
              width: 300,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: createButton(
                  textButton: "Ingresar"
              ),
            ),
            const Text(
              'Memoria virtual',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: nruState.nruColumns.isNotEmpty ?
                Row(
                  children:
                  nruState.nruColumns.map((column) =>
                      Row(
                        children: [
                          MemoryColumn(nruColumn: column),
                          const SizedBox(width: 10,)
                        ],
                      )
                  ).toList() as List<Widget>,
                ) : const SizedBox()
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      )
    );
  }

  Widget createRowWithSwitch({String text = ""}){
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

          value: true,
          activeColor: Colors.lightBlue,
          onChanged: (bool value) {

        })
      ],
    );
  }

  Widget createButton({String textButton = "botón"}){
    return  ElevatedButton(
      onPressed: ()=>{},
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
}
