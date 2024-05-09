part of 'clock_bloc.dart';

const initialPages = {
  1: null,
  2: null,
  3: null,
  4: null,
  5: null,
  6: null,
};

const Map<int, double> pageTurnValues = {
  1: 0,
  2: 0.15,
  3: 0.33,
  4: 0.5,
  5: 0.68,
  6: 0.85,
};

const initialActivePages = {
  1: false,
  2: false,
  3: false,
  4: false,
  5: false,
  6: false,
};

class ClockState extends Equatable {
  final int position;
  final Map<int, int?> pages;
  final double turn;
  final int page;
  final bool isInProgress;
  final Map<int, double> pageTurnValue;
  final Map<int, bool> activePages;

  const ClockState(
      {this.position = 1,
      this.isInProgress = false,
      this.pages = initialPages,
      this.page = 0,
      this.turn = 0,
      this.pageTurnValue = pageTurnValues,
      this.activePages = initialActivePages});

  ClockState copyWith({
    int? position,
    Map<int, int?>? pages,
    double? turn,
    int? page,
    Map<int, double>? pageTurnValue,
    Map<int, bool>? activePages,
    bool? isInProgress
  }) {
    return ClockState(
      position: position ?? this.position,
      pages: pages ?? this.pages,
      turn: turn ?? this.turn,
      page: page ?? this.page,
      isInProgress: isInProgress ?? this.isInProgress,
      pageTurnValue: pageTurnValue ?? this.pageTurnValue,
      activePages: activePages ?? this.activePages,
    );
  }

  bool get allActive {
    for (final pageEntry in activePages.entries) {
      if (!pageEntry.value) return false;
    }

    return true;
  }

  @override
  List<Object> get props => [position, turn, pageTurnValue, activePages, isInProgress];
}
