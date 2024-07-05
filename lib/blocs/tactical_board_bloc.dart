import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';


class TacticalBoardBloc extends Bloc<TacticalBoardEvent, TacticalBoardState> {
  TacticalBoardBloc() : super(TacticalBoardInitial());

  @override
  Stream<TacticalBoardState> mapEventToState(TacticalBoardEvent event) async* {
    if (event is LoadTacticalBoard) {
      yield* _mapLoadTacticalBoardToState();
    }
    // Handle other events
  }

  Stream<TacticalBoardState> _mapLoadTacticalBoardToState() async* {
    // Simulate data fetching
    await Future.delayed(Duration(seconds: 2));
    yield TacticalBoardLoaded('Tactical Board Data');
  }
}

abstract class TacticalBoardEvent extends Equatable {
  const TacticalBoardEvent();
  
  @override
  List<Object> get props => [];
}

class LoadTacticalBoard extends TacticalBoardEvent {}

abstract class TacticalBoardState extends Equatable {
  const TacticalBoardState();
  
  @override
  List<Object> get props => [];
}

class TacticalBoardInitial extends TacticalBoardState {}

class TacticalBoardLoaded extends TacticalBoardState {
  final String data;

  const TacticalBoardLoaded(this.data);
  
  @override
  List<Object> get props => [data];
}