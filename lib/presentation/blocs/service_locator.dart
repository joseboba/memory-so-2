import 'package:get_it/get_it.dart';
import 'package:memory/presentation/blocs/nru/nru_bloc.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorInit() {
  getIt.registerSingleton(NruBloc());
}