import 'package:operation/model/player.dart';

class Strategy {
  int? userId;
  int? id;
  String? title;
  List<Player>? players;

  Strategy({this.userId, this.id, this.title, this.players});

  factory Strategy.fromJson(Map<String, dynamic> json) {
    return Strategy(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      players: json['players'] != null
          ? (json['players'] as List).map((i) => Player.fromJson(i)).toList()
          : null,
    );
  }
}