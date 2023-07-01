import 'package:get/get.dart';

import '../../data_classes/user.dart';
import '../../routes/routes.dart';

class StoriesController extends GetxController {
  late List<User> followingUsers = <User>[];
  RxList<bool> isWatched = <bool>[].obs;

  @override
  void onInit() async {
    followingUsers = Get.arguments as List<User>;
    await loadData();
    super.onInit();
  }

  void navigateStory(int index) {
    Get.toNamed(Routes.storyDetail,
        arguments: [followingUsers, followingUsers[index].stories, index]);
  }

  Future<void> loadData() async {
    for (var user in followingUsers) {
      isWatched.add(user.stories.last.isWatched);
    }
  }
}
