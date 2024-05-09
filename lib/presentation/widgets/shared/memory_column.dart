

import 'package:flutter/material.dart';
import 'package:memory/domain/entities/nru_column.dart';
import 'package:memory/domain/entities/nru_element.dart';
import 'package:memory/presentation/widgets/widgets.dart';

class MemoryColumn extends StatelessWidget {

  final NruColumn nruColumn;

  const MemoryColumn({super.key, required this.nruColumn });

  @override
  Widget build(BuildContext context) {

    List<NruElement> elements = nruColumn.nruElements;

    final int numberOfElements = 6 - elements.length;

    if(elements.length < 6){
      for(int i=0; i< numberOfElements; i++){
        elements.add(NruElement(page: "", modificationBit: "", referenceBit: ""));
      }
    }

    return SizedBox(
      width: 80,
      child: Column(
        children: elements.map((nruElement) =>
          MemoryPage(pageData: nruElement.page != "" ? '${nruElement.page},${nruElement.referenceBit},${nruElement.modificationBit}' : "") 
         ).toList() as List<Widget>
      )
    );
  }
}
