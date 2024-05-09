import 'package:flutter/material.dart';
import 'package:memory/domain/entities/fifo_column.dart';
import 'package:memory/domain/entities/fifo_element.dart';
import 'package:memory/presentation/widgets/shared/memory_page.dart';

class FifoMemoryColumn extends StatelessWidget {

  final FifoColumn fifoColumn;

  const FifoMemoryColumn({super.key, required this.fifoColumn});

  @override
  Widget build(BuildContext context) {

    List<FifoElement> elements = fifoColumn.fifoElements;

    final int numberOfElements = 6 - elements.length;

    if(elements.length < 6) {
      for(int i = 0; i < numberOfElements; i++) {
        elements.add(FifoElement(page: '', time: 0));
      }
    }

    return SizedBox(
      width: 80,
      child: Column(
        children: elements.map((fifoElement) => 
          MemoryPage(pageData: fifoElement.page != '' ? '${fifoElement.page},${fifoElement.time}' : '')
        ).toList() as List<Widget>
      ),
    );

  }

}