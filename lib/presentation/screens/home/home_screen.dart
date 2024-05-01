import 'package:flutter/material.dart';
import 'package:memory/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Algoritmos de memoria'),
            ),
            MainMenu()
          ],
        ),
      ),
    );
  }
}
