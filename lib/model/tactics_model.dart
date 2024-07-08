// models/tactics_model.dart
import 'package:equatable/equatable.dart';
import 'package:operation/model/player.dart';

class UnitPosition extends Equatable {
  int id;
  List<Player> players;

  UnitPosition({required this.id, required this.players});

  factory UnitPosition.fromJson(Map<String, dynamic> json) {
    return UnitPosition(
      id: json['id'],
      players: json['players'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'players': players,
    };
  }

  @override
  List<Object> get props => [id, players];
}

class TacticsModel extends Equatable {
  final List<UnitPosition> units;

  TacticsModel({required this.units});

  factory TacticsModel.fromJson(Map<String, dynamic> json) {
    final unitsJson = json['units'] as List<dynamic>;
    final units = unitsJson.map((e) => UnitPosition.fromJson(e)).toList();
    return TacticsModel(units: units);
  }

  Map<String, dynamic> toJson() {
    return {
      'units': units.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [units];
}
