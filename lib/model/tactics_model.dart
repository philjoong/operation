// models/tactics_model.dart
import 'package:equatable/equatable.dart';

class TacticsModel extends Equatable {
  final List<UnitPosition> units;
  final BallPosition ball;

  TacticsModel({required this.units, required this.ball});

  factory TacticsModel.fromJson(Map<String, dynamic> json) {
    final unitsJson = json['units'] as List<dynamic>;
    final units = unitsJson.map((e) => UnitPosition.fromJson(e)).toList();
    final ball = BallPosition.fromJson(json['ball']);
    return TacticsModel(units: units, ball: ball);
  }

  Map<String, dynamic> toJson() {
    return {
      'units': units.map((e) => e.toJson()).toList(),
      'ball': ball.toJson(),
    };
  }

  @override
  List<Object> get props => [units, ball];
}

class UnitPosition extends Equatable {
  final int id;
  final double x;
  final double y;

  UnitPosition({required this.id, required this.x, required this.y});

  factory UnitPosition.fromJson(Map<String, dynamic> json) {
    return UnitPosition(
      id: json['id'],
      x: json['x'],
      y: json['y'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'x': x,
      'y': y,
    };
  }

  @override
  List<Object> get props => [id, x, y];
}

class BallPosition extends Equatable {
  final double x;
  final double y;

  BallPosition({required this.x, required this.y});

  factory BallPosition.fromJson(Map<String, dynamic> json) {
    return BallPosition(
      x: json['x'],
      y: json['y'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }

  @override
  List<Object> get props => [x, y];
}
