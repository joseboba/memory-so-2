import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory/config/config.dart';
import 'package:memory/presentation/blocs/blocs.dart';
import 'package:memory/presentation/blocs/fifo/fifo_bloc.dart';
import 'package:memory/presentation/blocs/nru/nru_bloc.dart';

void main()  {
  serviceLocatorInit();
  runApp(const BlocProviders());
}


class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<NruBloc>()),
          BlocProvider(create: (_) => getIt<ClockBloc>()),
          BlocProvider(create: (_) => getIt<FifoBloc>())
        ],
        child: const MyApp()
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Algoritmos de manejo de memoria',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
