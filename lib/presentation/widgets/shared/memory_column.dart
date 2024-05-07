

import 'package:flutter/material.dart';
import 'package:memory/domain/entities/nru_column.dart';
import 'package:memory/presentation/widgets/widgets.dart';

class MemoryColumn extends StatelessWidget {

  final NruColumn nruColumn;

  const MemoryColumn({super.key, required this.nruColumn });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Column(
        children: nruColumn.nruElements.map((nruElement) =>
          MemoryPage(pageData: '${nruElement.page},${nruElement.referenceBit},${nruElement.modificationBit}') 
         ).toList() as List<Widget>
      )
    );
  }
}
