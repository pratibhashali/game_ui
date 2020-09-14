import 'package:equatable/equatable.dart';

class TournamentElement extends Equatable {
  const TournamentElement({
    this.name,
    this.coverUrl,
    this.gameName,
    this.cursor,
  });

  final String name;

  final String coverUrl;

  final String gameName;
  final String cursor;

  @override
  List<Object> get props => [name, coverUrl, gameName];

  @override
  String toString() => 'Tournament name: - $name';

  factory TournamentElement.fromJson(Map<String, dynamic> json) =>
      TournamentElement(
        name: json["name"],
        coverUrl: json["cover_url"],
        gameName: json["game_name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "cover_url": coverUrl,
        "game_name": gameName,
      };
}
