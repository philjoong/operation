import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartSelectorBloc extends Bloc<StartSelectorEvent, StartSelectorState> {
  StartSelectorBloc() : super(StartSelectorState()) {
    on<ChangeStateEvent>((event, emit) {
      print("ChangeStateEvent Called");
      emit(state.clone(changeState: !state.changeState));
    });
    on<ValueEvent>((event, emit) {
      print("ValueEvent Called");
      emit(state.clone(value: state.value + 1));
    });
  }
}

abstract class StartSelectorEvent {}

class ChangeStateEvent extends StartSelectorEvent {}

class ValueEvent extends StartSelectorEvent {}

class StartSelectorState extends Equatable {
  final bool changeState;
  final int value;

  StartSelectorState({this.changeState = false, this.value = 0});
  StartSelectorState clone({bool? changeState, int? value,}){
    return StartSelectorState(
        changeState: changeState ?? this.changeState,
        value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [value, changeState];
}
