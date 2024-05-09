

class ClockItem {

  final int position;
  final double turn;
  final bool isActive;
  final bool isPointer;

  ClockItem({
    required this.position,
    required this.turn,
    required this.isActive,
    required this.isPointer
  });

  ClockItem copyWith({
    int? position,
    double? turn,
    bool? isActive,
    bool? isPointer,
  }) {
    return ClockItem(
      position: position ?? this.position,
      turn: turn ?? this.turn,
      isActive: isActive ?? this.isActive,
      isPointer: isPointer ?? this.isPointer,
    );
  }
}