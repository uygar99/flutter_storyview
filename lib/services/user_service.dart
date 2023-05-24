import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data_classes/user_list.dart';

class UserService extends GetxService {
  static UserService get to => Get.find();

  Future<Users> getUsers() async {
    final String response =
        await rootBundle.loadString("assets/mock_data/user_list.json");
    final jsonMap = json.decode(response);
    //Users users = await json.decode(jsonMap);
    Users users = Users.fromJson(jsonMap);
    //print(users.users.length);
    return users;
  }
}
