import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:operation/model/strategy.dart';
import '../cases/strategyUseCase.dart';

class StrategyBloc extends Bloc<DataEvent, DataState> {
  final StrategyUseCase strategyUseCase;

  StrategyBloc({required this.strategyUseCase}) : super(DataInitial());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is FetchDataEvent) {
      yield DataLoading();
      try {
        List<Strategy> data = await strategyUseCase();
        yield DataLoaded(data: data);
      } catch (e) {
        yield DataError(message: e.toString());
      }
    }
  }
}

abstract class DataEvent {}

class FetchDataEvent extends DataEvent {}

abstract class DataState {}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final List<Strategy> data;

  DataLoaded({required this.data});
}

class DataError extends DataState {
  final String message;

  DataError({required this.message});
}
