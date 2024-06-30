import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartBloc extends Bloc<StartEvent, int>{
  StartBloc() : super(0) {
    on<StartEvent>((event, emit) {
      print("StartEvent called.");
    });
    on<AddStartEvent>((event, emit) {
      emit(state + 1);
    });
  }
}
class StartEvent {}

class AddStartEvent extends StartEvent {}