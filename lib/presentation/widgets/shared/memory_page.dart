

import 'package:flutter/material.dart';

class MemoryPage extends StatelessWidget {

  final String pageData;

  const MemoryPage({super.key, required this.pageData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child:  Text(
          pageData,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18
          ),
      ),
      )
    );
  }
}

