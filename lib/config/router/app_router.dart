import 'package:go_router/go_router.dart';
import 'package:memory/domain/entities/menu_item_entity.dart';
import 'package:memory/presentation/screens/screens.dart';
import 'package:flutter/material.dart';

final appRouter = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
  GoRoute(path: '/clock', builder: (context, state) => const ClockAlgorithmScreen()),
  GoRoute(path: '/fifo', builder: (context, state) => const FifoAlgorithmScreen()),
  GoRoute(path: '/nru', builder: (context, state) => const NruAlgorithmScreen()),
]);


final menuItems = <MenuItem>[
  MenuItem('Reloj', Icons.access_time_outlined, '/clock'),
  MenuItem('FIFO', Icons.stacked_bar_chart_sharp, '/nru'),
  MenuItem('NRU', Icons.account_tree_sharp, '/nru'),
];