import 'package:operation/model/strategy.dart';
import '../model/player.dart';

abstract class StrategyService{
  Future<List<Strategy>> fetchStrategy();
}

class StrategyServiceImplementation implements StrategyService{
  @override
  Future<List<Strategy>> fetchStrategy() async {
    return [
      Strategy(
          userId: 1,
          id: 101,
          title: "First Strategy",
          players: [
            Player(id: 1, name: "Player One", x: 35.0, y: 45.0),
            Player(id: 2, name: "Player Two", x: 55.0, y: 65.0),
          ]
      ),
      Strategy(
          userId: 2,
          id: 102,
          title: "Second Strategy",
          players: [
            Player(id: 3, name: "Player Three", x: 25.0, y: 35.0),
            Player(id: 4, name: "Player Four", x: 75.0, y: 85.0),
          ]
      )
    ];
  }
}