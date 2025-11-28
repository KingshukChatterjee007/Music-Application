import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// EVENTS
abstract class AlbumEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// STATE
class AlbumState extends Equatable {
  @override
  List<Object> get props => [];
}

// BLOC
class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final PageController pageController;

  AlbumBloc({required this.pageController}) : super(AlbumState());
}
