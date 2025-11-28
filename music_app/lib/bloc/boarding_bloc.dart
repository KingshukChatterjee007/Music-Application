import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// EVENTS
abstract class BoardingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OnPageChangeEvent extends BoardingEvent {
  final int index;
  OnPageChangeEvent({required this.index});
  @override
  List<Object> get props => [index];
}

// STATE
class BoardingState extends Equatable {
  final int index; // Tracks which page we are on (0, 1, or 2)
  const BoardingState({this.index = 0});

  BoardingState copyWith({int? index}) {
    return BoardingState(index: index ?? this.index);
  }

  @override
  List<Object> get props => [index];
}

// BLOC
class BoardingBLoc extends Bloc<BoardingEvent, BoardingState> {
  final PageController pageController;

  BoardingBLoc({required this.pageController}) : super(const BoardingState()) {
    on<OnPageChangeEvent>(_onPageChangeEvent);
  }

  void _onPageChangeEvent(
      OnPageChangeEvent event, Emitter<BoardingState> emit) {
    // Determine if we need to animate the page controller manually
    if (pageController.hasClients &&
        pageController.page?.round() != event.index) {
      pageController.animateToPage(
        event.index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
    emit(state.copyWith(index: event.index));
  }
}
