import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_view/story_view.dart';

import '../../data_classes/store_logged_in.dart';
import '../../data_classes/story.dart';
import '../../data_classes/user.dart';
import '../../routes/routes.dart';

class StoryDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controller;
  RxBool isRendered = false.obs;
  RxDouble angle = 0.0.obs;
  final storyController2 = StoryController();
  var storyController = PageController();
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
    print("selam" + CustomStorage.getFollowingUsers()!.length.toString());
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

  /*void onComplete() {
    index += 1;
    stories = followingUsers[index].stories;
    Get.toNamed(Routes.storyDetail,
        arguments: [followingUsers, followingUsers[index].stories, index]);
  }*/

  void onStoryShow(user) {
    if (storyIndex.value >= user.stories.length) {
      storyIndex.value = user.stories.length - 1;
    }
    user.stories[storyIndex.value].isWatched = true;

    if (user.stories.length - 1 > storyIndex.value) {
      storyIndex.value++;
    }
  }

  void onVerticalSwipe(direction) {
    if (direction == Direction.down) {
      //user.stories.last.isWatched = true;
      storyIndex.value = 0;
      Get.offAllNamed(Routes.stories, arguments: followingUsers);
    }
  }

  void onComplete(user) {
    storyIndex.value = 0;
    cubeController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.linear);

    followingUsers[index].stories.last.isWatched = true;
    if (user.id == followingUsers[indexTemp - 1].id) {
      Get.offAllNamed(Routes.stories, arguments: followingUsers);
    }
  }

  Matrix4 transformFirst() {
    const index = 0;
    final transform = Matrix4.identity();
    transform.setEntry(3, 2, 0.001);
    var angle = 0.0 - index.toDouble();
    if (cubeController.position.haveDimensions) {
      angle = cubeController.page!;
    }
    transform.rotateY(-angle * -0.5 * 3.14);
    return transform;
  }

  Matrix4 transformation(index) {
    final transform = Matrix4.identity();
    transform.setEntry(3, 2, 0.001);

    if (index == cubeController.page?.toInt()) {
      final angle = cubeController.page! - index;
      transform.rotateY(-angle * -0.5 * 3.14);
    }

    if (index == cubeController.page!.toInt() + 1) {
      final angle = cubeController.page! - index;
      transform.rotateY(-angle * -0.5 * 3.14);
    }
    return transform;
  }

  void swipe(index, details) {
    if (index == cubeController.page?.toInt()) {
      if (details.delta.dx > 0) {
        // Swiped right
        cubeController.previousPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutCubic,
        );
      } else if (details.delta.dx < 0) {
        // Swiped left
        cubeController.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutCubic,
        );
      }
    }
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
