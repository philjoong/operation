import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/startRepository.dart';

class StartBlocDI extends Bloc<StartDIEvent, int>{
  final StartRepository _startRepository;
  StartBlocDI(this._startRepository) : super(0) {
    on<StartDIEvent>((event, emit) async {
      var data = await _startRepository.load();
      print(data);
    });
    on<AddStartDIEvent>((event, emit) {
      emit(state + 1);
    });
  }
}
class StartDIEvent {}

class AddStartDIEvent extends StartDIEvent {}