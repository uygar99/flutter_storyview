import 'package:flutter_storyview/data_classes/story.dart';

class User {
  int id;
  String name;
  String email;
  String pp;
  List<Story> stories;
  List<int> follows;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.pp,
    required this.stories,
    required this.follows,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        pp: json["pp"],
        stories:
            List<Story>.from(json["stories"].map((x) => Story.fromJson(x))),
        follows: List<int>.from(json["follows"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "pp": pp,
        "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
        "follows": List<dynamic>.from(follows.map((x) => x)),
      };
}
