import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music_app/db_helper/db_helper.dart';

// EVENTS
abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// STATE
class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

// BLOC
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DbHelper dbHelper;

  HomeBloc({required this.dbHelper}) : super(HomeState());
}
