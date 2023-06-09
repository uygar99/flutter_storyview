import 'package:flutter_storyview/data_classes/store_logged_in.dart';
import 'package:flutter_storyview/services/user_service.dart';
import 'package:get/get.dart';

import '../../data_classes/user.dart';
import '../../data_classes/user_list.dart';
import '../../routes/routes.dart';

class HomeController extends GetxController {
  RxList<User> users = <User>[].obs;
  RxList<User> followingUsers = <User>[].obs;
  RxList<User> nonFollowingUsers = <User>[].obs;
  final RxList<bool> selectedFollowers = [true, false].obs;
  //final RxList<bool> selectedExplore = [false, true].obs;
  RxBool followerOrExplore = true.obs;

  @override
  void onInit() async {
    await loadData();
    await followingOrNot();
    super.onInit();
  }

  void storiesNavigator() {
    Get.toNamed(Routes.stories, arguments: followingUsers);
  }

  void toggleController(int index) {
    for (int i = 0; i < selectedFollowers.length; i++) {
      selectedFollowers[i] = i == index;
    }
    if (index == 0) {
      followerOrExplore.value = true;
    } else {
      followerOrExplore.value = false;
    }
  }

  Future<void> followingOrNot() async {
    for (User user in users) {
      //List<int> followedUserIds = CustomStorage.getUser().follows;
      if (CustomStorage.getFollowingUsers()!
          .any((element) => element.id == user.id)) {
        followingUsers.add(user);
        if (!CustomStorage.getFollowingUsers()!
            .any((element) => element.id == user.id)) {
          CustomStorage.addFollower(user);
        }
      } else {
        //nonFollowingUsers.add(user);
        //CustomStorage.removeFollower(user);
      }
    }
    followingUsers.value = CustomStorage.getFollowingUsers()!;
    for (User user in users) {
      if (!CustomStorage.getFollowingUsers()!
          .any((element) => element.id == user.id)) {
        nonFollowingUsers.value.add(user);
      }
    }
    //nonFollowingUsers.value = CustomStorage.getNonFollowingUsers()!;
  }

  void follow(User user) {
    followingUsers.add(user);
    nonFollowingUsers.remove(user);
    if (!CustomStorage.getFollowingUsers()!
        .any((element) => element.id == user.id)) {
      CustomStorage.addFollower(user);
    }
  }

  void unfollow(User user) {
    followingUsers.remove(user);
    nonFollowingUsers.add(user);
    if (CustomStorage.getFollowingUsers()!
        .any((element) => element.id == user.id)) {
      CustomStorage.removeFollower(user);
    }
  }

  void followOrUnfollow(User user) {
    if (followingUsers.contains(user)) {
      unfollow(user);
    } else {
      follow(user);
    }
  }

  Future<void> loadData() async {
    Users usersTemp = await UserService().getUsers();
    users(usersTemp.users);
  }
}
