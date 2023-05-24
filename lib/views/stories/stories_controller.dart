import 'package:get/get.dart';

import '../../data_classes/user.dart';

class StoriesController extends GetxController {
  late List<User> followingUsers = <User>[];
  RxList<bool> isWatched = <bool>[].obs;

  @override
  void onInit() async {
    followingUsers = Get.arguments as List<User>;
    await loadData();
    super.onInit();
  }

  Future<void> loadData() async {
    for (var user in followingUsers) {
      isWatched.add(user.stories.last.isWatched);
    }
  }
}
