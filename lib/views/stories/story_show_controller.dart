import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_view/controller/story_controller.dart';

import '../../data_classes/story.dart';
import '../../data_classes/user.dart';
import '../../routes/routes.dart';

class StoryDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controller;
  RxBool isRendered = false.obs;
  RxDouble angle = 0.0.obs;
  final storyController = StoryController();
  late List<User> followingUsers = [];
  late List<Story> stories = [];
  late int index = 0;
  RxInt closeIndex = 0.obs;
  RxInt storyIndex = 0.obs;
  int indexTemp = 0;
  var cubeController = PageController();
  //RxList<Story> stories = <Story>[].obs;

  @override
  void onInit() async {
    await takeArgs();
    loadData();
    super.onInit();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
    );
  }

  void changePage(int a) {
    if (!(arranger()[index].stories.length > storyIndex.value)) {
      storyIndex.value = 0;
    }
    closeIndex += 1;
    if (a == followingUsers.length) {
      Get.offAllNamed(Routes.stories, arguments: followingUsers);
    }
  }

  Future<void> takeArgs() async {
    var args = Get.arguments;
    followingUsers = args[0];
    stories = args[1];
    index = args[2];
    indexTemp = index;
    if (indexTemp == 0) indexTemp = followingUsers.length;
  }

  void onComplete() {
    index += 1;
    stories = followingUsers[index].stories;
    Get.toNamed(Routes.storyDetail,
        arguments: [followingUsers, followingUsers[index].stories, index]);
  }

  void makeTrue() {
    if (cubeController.position.haveDimensions) isRendered.value = true;
  }

  List<User> arranger() {
    List<User> followingUsersTemp = [];
    for (var i = index; i < followingUsers.length; i++) {
      followingUsersTemp.add(followingUsers[i]);
    }
    for (var i = 0; i < index; i++) {
      followingUsersTemp.add(followingUsers[i]);
    }
    return followingUsersTemp;
  }

  void loadData() {
    //print("load dataya geldi");
  }
}
