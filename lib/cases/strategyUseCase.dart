
import 'package:operation/model/strategy.dart';

import '../repository/strategyRepository.dart';

class StrategyUseCase {
  final StrategyRepository strategyRepository;

  StrategyUseCase({required this.strategyRepository});

  Future<List<Strategy>> call() async {
    return await strategyRepository.getData();
  }
}
