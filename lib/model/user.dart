import 'package:game_ui/model/user_stats.dart';

class User {
  String id;
  String fullName;
  String profilePicture;
  int rating;
  String userName;
  UserStats userStats;

  User({
    this.id,
    this.fullName,
    this.profilePicture,
    this.rating,
    this.userName,
    this.userStats,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    profilePicture = json['profile_picture'];
    rating = json['rating'];
    userName = json['user_name'];
    userStats = json['user_stats'] != null
        ? new UserStats.fromJson(json['user_stats'])
        : null;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_": fullName,
        "profile_picture": profilePicture,
        "rating": rating,
        "user_name": userName,
        if (userStats != null) "user_stats": userStats.toJson(),
      };
}
