import 'package:meta/meta.dart';
import 'package:operation/model/strategy.dart';
import '../service/strategy_service.dart';

abstract class StrategyRepository {
  Future<List<Strategy>> getData();
}

class StrategyRepositoryImpl implements StrategyRepository {
  final StrategyService strategyService;

  StrategyRepositoryImpl({required this.strategyService});

  @override
  Future<List<Strategy>> getData() async {
    return await strategyService.fetchStrategy();
  }
}
