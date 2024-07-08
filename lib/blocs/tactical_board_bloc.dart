import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:operation/model/tactics_model.dart';
import 'package:operation/model/user.dart';
import 'package:operation/repository/user_repository.dart';


class TacticalBoardBloc extends Bloc<TacticalBoardEvent, TacticalBoardState> {
  final UserRepository userRepository;

  TacticalBoardBloc(this.userRepository) : super(TacticalBoardInitial());

  @override
  Stream<TacticalBoardState> mapEventToState(TacticalBoardEvent event) async* {
    if (event is LoadTacticalBoard) {
      yield* _mapLoadTacticalBoardToState(event);
    }
  }

  Stream<TacticalBoardState> _mapLoadTacticalBoardToState(LoadTacticalBoard event) async* {
    yield TacticalBoardInitial();

    final userId = event;
    if (userId != null) {
      final tacticsList = await userRepository.getUserTactics(userId as String);
      if (tacticsList.isNotEmpty) {
        final unitPositionSequence = tacticsList.first;
        yield TacticalBoardLoaded(unitPositionSequence as List<UnitPosition>);
      } else {
        // Handle case where no tactics are available
        yield TacticalBoardError('No Tactical Board Data');
      }
    } else {
      yield TacticalBoardError('Failed to load user data');
    }
  }
}

abstract class TacticalBoardEvent extends Equatable {
  const TacticalBoardEvent();
  
  @override
  List<Object> get props => [];
}

class LoadTacticalBoard extends TacticalBoardEvent {
  final String userId;

  const LoadTacticalBoard(this.userId);

  @override
  List<Object> get props => [userId];
}

abstract class TacticalBoardState extends Equatable {
  const TacticalBoardState();
  
  @override
  List<Object> get props => [];
}

class TacticalBoardInitial extends TacticalBoardState {}

class TacticalBoardLoaded extends TacticalBoardState {
  final List<UnitPosition> unitPositionSequence;

  const TacticalBoardLoaded(this.unitPositionSequence);
  
  @override
  List<Object> get props => [unitPositionSequence];
}

class TacticalBoardError extends TacticalBoardState {
  final String message;

  const TacticalBoardError(this.message);

  @override
  List<Object> get props => [message];
}