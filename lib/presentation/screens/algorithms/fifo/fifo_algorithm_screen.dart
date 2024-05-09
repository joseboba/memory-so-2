import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory/domain/entities/fifo_element.dart';
import 'package:memory/presentation/blocs/fifo/fifo_bloc.dart';
import 'package:memory/presentation/screens/algorithms/nru/nru_algorithm_screen.dart';
import 'package:memory/presentation/widgets/shared/fifo_memory_column.dart';

class FifoAlgorithmScreen extends StatelessWidget {
  const FifoAlgorithmScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final fifoState = context.watch<FifoBloc>().state;
    final ScrollController controller = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Algoritmo FIFO'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
            context.read<FifoBloc>().add((Restart()));
          },
        ),
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
              Container(
                height: 50,
                width: 300,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: createButton(
                  textButton: 'Ingresar',
                  state: fifoState,
                  context: context
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
                child: fifoState.fifoColumns.isNotEmpty ? 
                ScrollConfiguration(
                  behavior: MyCustomScrollBehavior(),
                  child: ListView.builder(
                    controller: controller,
                    itemCount: fifoState.fifoColumns.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          FifoMemoryColumn(fifoColumn: fifoState.fifoColumns[index]),
                          const SizedBox(width: 10)
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
      ),
    );
  }

  Widget createButton({String textButton = 'Botón', required FifoState state, required BuildContext context}) {

    return ElevatedButton(
      onPressed: () => {
        context.read<FifoBloc>().add(AddFifoElement(FifoElement(page: (state.lastFifoElementNumber + 1).toString(), time: state.lastFifoElementNumber + 1)))
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
      ),
    );

  }

}
