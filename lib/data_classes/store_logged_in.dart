import 'package:flutter_storyview/data_classes/user.dart';

class CustomStorage {
  static final CustomStorage _instance = CustomStorage._internal();
  factory CustomStorage() => _instance;
  CustomStorage._internal();
  User? user;
  List<User>? followingUsers;
  List<User>? nonFollowingUsers;

  static void initialize(User newUser) {
    _instance.user = newUser;
    _instance.followingUsers = [];
    _instance.nonFollowingUsers = [];
  }

  static List<User>? getFollowingUsers() {
    return _instance.followingUsers;
  }

  static List<User>? getNonFollowingUsers() {
    return _instance.nonFollowingUsers;
  }

  static void addFollower(User user) {
    _instance.followingUsers?.add(user);
    _instance.nonFollowingUsers?.remove(user);
  }

  static void removeFollower(User user) {
    _instance.followingUsers?.remove(user);
    _instance.nonFollowingUsers?.add(user);
  }

  static User getUser() {
    return _instance.user!;
  }
}
