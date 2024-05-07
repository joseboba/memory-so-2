import 'package:get_it/get_it.dart';
import 'package:memory/presentation/blocs/nru/nru_bloc.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorInit() {
  // TODO: SE DEBEN DE REGISTRAR TODOS LOS BLOCS A UTILIZAR
  getIt.registerSingleton(NruBloc());
}