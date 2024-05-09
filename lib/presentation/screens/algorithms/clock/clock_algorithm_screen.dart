import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory/presentation/blocs/blocs.dart';

class ClockAlgorithmScreen extends StatelessWidget {
  const ClockAlgorithmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clockState = context.watch<ClockBloc>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Algoritmo de Reloj'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          const _CirclesClock(),
          AnimatedRotation(
              curve: Curves.easeOut,
              turns: clockState.turn,
              duration: const Duration(seconds: 1),
              child: const Icon(Icons.arrow_right_alt_outlined, size: 125)),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'delete-clock-processes',
            onPressed: clockState.isInProgress ? null : () {
              context.read<ClockBloc>()
                  .cleanProcesses();
            },
            backgroundColor: clockState.isInProgress ? Colors.grey : Colors.redAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            child: const Icon(Icons.delete_forever, color: Colors.white),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'add-process',
            onPressed: clockState.isInProgress ? null : () {
              context.read<ClockBloc>()
                  .addNewProcess();
            },
            backgroundColor: clockState.isInProgress ? Colors.grey : Colors.lightBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            child: const Icon(Icons.add_outlined, color: Colors.white),
          ),
        ],
      )
    );
  }
}

class _CirclesClock extends StatelessWidget {
  const _CirclesClock();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _CirclePosition(
            angle: 0,
            child: _Circle(identifier: 1)
        ),
        _CirclePosition(
            angle: math.pi / 3,
            child: _Circle(identifier: 2),
        ),
        _CirclePosition(
            angle: 2 * math.pi / 3,
            child: _Circle(identifier: 3),
        ),
        _CirclePosition(
            angle: math.pi,
            child: _Circle(identifier: 4)
        ),
        _CirclePosition(
            angle: 4 * math.pi / 3,
            child: _Circle(identifier: 5)
        ),
        _CirclePosition(
            angle: 5 * math.pi / 3,
            child: _Circle(identifier: 6)
        ),
      ],
    );
  }
}

class _CirclePosition extends StatelessWidget {
  final double angle;
  final Widget child;

  const _CirclePosition({
    required this.angle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    const double radius = 125;
    final double centerX = size.width * 0.45;
    final double centerY = size.height * 0.4;
    final double x = centerX + radius * math.cos(angle);
    final double y = centerY + radius * math.sin(angle);

    return Positioned(
      left: x,
      top: y,
      child: child,
    );
  }
}

class _Circle extends StatelessWidget {
  final int identifier;

  const _Circle({
    required this.identifier
  });

  @override
  Widget build(BuildContext context) {
    final clockState = context.watch<ClockBloc>().state;
    final page = clockState.pages[identifier];
    final isActive = clockState.activePages[identifier]!;

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.blueGrey.shade200),
      child:  Badge(
        label: Text('$page'),
        child: Center(
          child: Text(
            'r = ${isActive ? '1' : '0'}',
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
