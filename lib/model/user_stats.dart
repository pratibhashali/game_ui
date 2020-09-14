class UserStats {
  int played;
  int won;

  UserStats({this.played, this.won});

  UserStats.fromJson(Map<String, dynamic> json) {
    played = json['played'];
    won = json['won'];
  }

  int winningPercentage() {
    return ((won / played) * 100).toInt();
  }

  Map<String, dynamic> toJson() => {
        "played": played,
        "won": won,
      };
}
