import 'package:flutter_storyview/data_classes/user.dart';

class Users {
  List<User> users;
  Users({
    required this.users,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
