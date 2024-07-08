import 'package:equatable/equatable.dart';

class Player extends Equatable{
  int? id;
  bool? isBall;
  String? name;
  String? team;
  double? x;
  double? y;
  bool? head;
  bool? rightFoot;
  bool? leftFoot;
  bool? jumped;

  Player({this.id, this.isBall, this.name, this.team, this.x, this.y, 
  this.head, this.rightFoot, this.leftFoot, this.jumped});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as int?,
      isBall: json['isBall'] as bool?,
      name: json['name'] as String?,
      team: json['team'] as String?,
      x: (json['x'] as num?)?.toDouble(),
      y: (json['y'] as num?)?.toDouble(),
      head: json['head'] as bool?,
      rightFoot: json['rightFoot'] as bool?,
      leftFoot: json['leftFoot'] as bool?,
      jumped: json['jumped'] as bool?,
    );
  }
  @override
  List<Object?> get props => [
        id,
        isBall,
        name,
        team,
        x,
        y,
        head,
        rightFoot,
        leftFoot,
        jumped,
      ];
}
