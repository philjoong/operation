
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:operation/repository/strategyRepository.dart';
import 'package:operation/service/strategy_service.dart';

import 'blocs/startBloc.dart';
import 'cases/strategyUseCase.dart';

GetIt getIt = GetIt.instance();

Future<void> initDependencies() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<StrategyService>(
          () => StrategyServiceImpl(dio: getIt()));
  getIt.registerLazySingleton<StrategyRepository>(
          ()=> StrategyRepositoryImpl(strategyService: getIt()));
  getIt.registerLazySingleton<StrategyUseCase>(
          ()=> StrategyUseCase(strategyRepository: getIt()));
}