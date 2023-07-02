import 'package:flutter_storyview/data_classes/user.dart';
import 'package:flutter_storyview/data_classes/user_list.dart';

import '../services/user_service.dart';

class CustomStorage {
  static final CustomStorage _instance = CustomStorage._internal();
  factory CustomStorage() => _instance;
  CustomStorage._internal();
  User? user;
  List<List<User>?>? followingUsers;
  List<List<User>?>? nonFollowingUsers;

  static void initialize(User newUser) async {
    Users users = await UserService().getUsers();
    _instance.user = newUser;
    _instance.followingUsers ??= List.generate(10, (_) => []);
    _instance.nonFollowingUsers ??= List.generate(10, (_) => []);
    /*for (var user in users.users) {
      if (!newUser.follows.contains(user.id)) {
        _instance.followingUsers![user.id]?.add(user);
      }
    }*/
  }

  static List<User>? getFollowingUsers() {
    return _instance.followingUsers![_instance.user!.id];
  }

  static List<User>? getNonFollowingUsers() {
    return _instance.nonFollowingUsers![_instance.user!.id];
  }

  static void addFollower(User user) {
    _instance.followingUsers![_instance.user!.id]?.add(user);
    _instance.nonFollowingUsers![_instance.user!.id]?.remove(user);
  }

  static void removeFollower(User user) {
    _instance.followingUsers![_instance.user!.id]?.remove(user);
    _instance.nonFollowingUsers![_instance.user!.id]?.add(user);
  }

  static User getUser() {
    return _instance.user!;
  }
}
