import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory/config/config.dart';
import 'package:memory/presentation/blocs/blocs.dart';

void main()  {
  serviceLocatorInit();
  runApp(const MyApp());
}


class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: const [
          // TODO: SE DEBEN DE AGREGAR LOS BLOC PROVIDERS CUANTO LOS TENGAMOS
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
