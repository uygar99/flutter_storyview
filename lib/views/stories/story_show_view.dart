import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storyview/views/stories/story_show_controller.dart';
import 'package:get/get.dart';
import 'package:story_view/story_view.dart';

import '../../routes/routes.dart';

class StoryShowView extends GetView<StoryDetailController> {
  //final int index;
  //final List<String> model;
  const StoryShowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storyController = StoryController();
    return Scaffold(
        body: SafeArea(
            child: Obx(() => CubePageView(
                  controller: controller.cubeController,
                  onPageChanged: (a) {
                    //controller.index += 1;
                    if (!(controller
                            .arranger()[controller.index]
                            .stories
                            .length >
                        controller.storyIndex.value)) {
                      controller.storyIndex.value = 0;
                    }
                    controller.closeIndex += 1;
                    /*controller
                        .followingUsers[(a + controller.index) %
                            controller.followingUsers.length]
                        .stories
                        .last
                        .isWatched = true;
                    controller
                        .followingUsers[(a + controller.index - 1) %
                            controller.followingUsers.length]
                        .stories
                        .last
                        .isWatched = true;*/
                    if (a == controller.followingUsers.length) {
                      Get.offAllNamed(Routes.stories,
                          arguments: controller.followingUsers);
                    }
                  },
                  children: controller
                      .arranger()
                      .map((user) => Stack(
                            children: [
                              StoryView(
                                controller: storyController,
                                storyItems: [
                                  for (int i = 0; i < user.stories.length; i++)
                                    StoryItem.pageImage(
                                        imageFit: BoxFit.contain,
                                        url: (user.stories[i].content),
                                        controller: storyController,
                                        duration: const Duration(seconds: 5)),
                                ],
                                onStoryShow: (s) {
                                  if (controller.storyIndex.value >=
                                      user.stories.length) {
                                    controller.storyIndex.value =
                                        user.stories.length - 1;
                                  }
                                  user.stories[controller.storyIndex.value]
                                      .isWatched = true;

                                  if (user.stories.length - 1 >
                                      controller.storyIndex.value) {
                                    controller.storyIndex.value++;
                                  }
                                },
                                onVerticalSwipeComplete: (direction) {
                                  if (direction == Direction.down) {
                                    //user.stories.last.isWatched = true;
                                    controller.storyIndex.value = 0;
                                    Get.offAllNamed(Routes.stories,
                                        arguments: controller.followingUsers);
                                  }
                                },
                                onComplete: () {
                                  //user.stories.last.isWatched = true;
                                  controller.storyIndex.value = 0;
                                  controller.cubeController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: const Cubic(1, 1, 1, 1));
                                  controller.followingUsers[controller.index]
                                      .stories.last.isWatched = true;
                                  if (user.id ==
                                      controller
                                          .followingUsers[
                                              controller.indexTemp - 1]
                                          .id) {
                                    Get.offAllNamed(Routes.stories,
                                        arguments: controller.followingUsers);
                                  }
                                  //controller.cubeController.initialPage;
                                  //storyController.
                                  //storyController.previous();
                                  //controller.cubeController.
                                  /*Get.offAllNamed(Routes.stories,
                                      arguments: controller.followingUsers);*/
                                },
                                progressPosition: ProgressPosition.top,
                                repeat: false,
                                inline: true,
                              ),
                            ],
                          ))
                      .toList(),
                ))));
  }
}
