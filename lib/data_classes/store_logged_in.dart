import 'package:flutter_storyview/data_classes/user.dart';

class CustomStorage {
  static final CustomStorage _instance = CustomStorage._internal();
  factory CustomStorage() => _instance;
  CustomStorage._internal();
  User? user;
  static void initialize(User newUser) {
    // You can perform any initialization tasks here
    _instance.user = newUser;
  }

  static User getUser() {
    return _instance.user!;
  }
}
