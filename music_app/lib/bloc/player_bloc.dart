import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

// EVENTS
abstract class PlayerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// STATE
class PlayerState extends Equatable {
  @override
  List<Object> get props => [];
}

// BLOC
class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final AudioPlayer player;

  PlayerBloc({required this.player}) : super(PlayerState());
}
