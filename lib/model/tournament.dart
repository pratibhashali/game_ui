// To parse this JSON data, do
//
//     final tournament = tournamentFromJson(jsonString);

import 'dart:convert';

import 'package:game_ui/model/tournament_element.dart';

Tournament tournamentFromJson(String str) =>
    Tournament.fromJson(json.decode(str));

String tournamentToJson(Tournament data) => json.encode(data.toJson());

class Tournament {
  Tournament({
    this.code,
    this.data,
    this.success,
  });

  int code;
  Data data;
  bool success;

  factory Tournament.fromJson(Map<String, dynamic> json) => Tournament(
        code: json["code"],
        data: Data.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "success": success,
      };
}

class Data {
  Data({
    this.cursor,
    this.tournamentCount,
    this.tournaments,
    this.isLastBatch,
  });

  String cursor;
  dynamic tournamentCount;
  List<TournamentElement> tournaments;
  bool isLastBatch;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cursor: json["cursor"],
        tournamentCount: json["tournament_count"],
        tournaments: List<TournamentElement>.from(
            json["tournaments"].map((x) => TournamentElement.fromJson(x))),
        isLastBatch: json["is_last_batch"],
      );

  Map<String, dynamic> toJson() => {
        "cursor": cursor,
        "tournament_count": tournamentCount,
        "tournaments": List<dynamic>.from(tournaments.map((x) => x.toJson())),
        "is_last_batch": isLastBatch,
      };
}
