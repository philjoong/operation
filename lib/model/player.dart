class Player {
  int? id;
  String? name;
  double? x;
  double? y;

  Player({this.id, this.name, this.x, this.y});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as int?,
      name: json['name'] as String?,
      x: json['x']?.toDouble(),
      y: json['y']?.toDouble(),
    );
  }
}
