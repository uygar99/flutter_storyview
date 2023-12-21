import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_storyview/views/stories/story_show_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class StoryShowView extends GetView<StoryDetailController> {
  //final int index;
  //final List<String> model;
  const StoryShowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: <Widget>[
      PageView.builder(
        controller: controller.cubeController,
        itemCount: controller.arranger().length,
        onPageChanged: (index) async {
          await controller.onPageChange();
          //print("yrni user length" + controller.imageUrls.length.toString());
        },
        //onPageChanged: controller.onComplete,
        itemBuilder: (context, index) {
          final user = controller.arranger()[index];
          controller.user.value = user;
          if (index == 0) {
            return GestureDetector(
              onPanUpdate: (details) {
                /*if (details.delta.dx < 0) {
                  // Swiped left
                  controller.swipe(index, details);
                  controller.start.value = 500;
                  controller.user.value!.stories[controller.storyIndex.value]
                      .isWatched = true;
                } else {
                  controller.start.value = 500;
                }*/
              },
              child: AnimatedBuilder(
                animation: controller.cubeController,
                builder: (context, child) {
                  Matrix4 transform = controller.transformFirst();
                  return Transform(
                    transform: transform,
                    alignment: Alignment.centerRight,
                    child: child,
                  );
                },
                child: _storyView(context, user),
              ),
            );
          }

          return GestureDetector(
            onPanUpdate: (details) {
              controller.swipe(index, details);
              controller.user.value!.stories[controller.storyIndex.value]
                  .isWatched = true;
            },
            child: controller.cubeController.position.haveDimensions
                ? AnimatedBuilder(
                    animation: controller.cubeController,
                    builder: (context, child) {
                      Matrix4 transform = controller.transformation(index);
                      return Transform(
                        transform: transform,
                        alignment:
                            index == controller.cubeController.page?.toInt()
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: child,
                      );
                    },
                    child: _storyView(context, user),
                  )
                : Container(),
          );
        },
      )
    ])));
  }

  Widget _storyView(BuildContext context, user) {
    return GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! > 40) {
            controller.onVerticalSwipe();
          }
        },
        onLongPress: controller.pauseTimer,
        onLongPressUp: controller.resumeTimer,
        onTapUp: (details) async {
          await controller.onTapUp(details, context);
        },
        child: _customStories(context));
  }

  Widget _customStories(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 4.0, // Gri çizgilerin yüksekliği
            child: Obx(
              () => Row(
                  children: List.generate(
                controller.imageUrls.length,
                (index) => index == controller.storyIndex.value
                    ? Expanded(
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Obx(() => FAProgressBar(
                                  currentValue: double.parse(
                                      (controller.wholeStoryTime.value -
                                              controller.start.value)
                                          .toString()),
                                  maxValue: double.parse(controller
                                      .wholeStoryTime.value
                                      .toString()),
                                  backgroundColor:
                                      const Color.fromARGB(255, 200, 200, 200),
                                  progressColor: Colors.grey,
                                ))))
                    : Expanded(
                        child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Obx(() => FAProgressBar(
                              currentValue: 0.0,
                              maxValue: 475,
                              backgroundColor: index <
                                          controller.storyIndex.value &&
                                      controller.user.value!.stories.length >
                                          controller.storyIndex.value &&
                                      (controller.user.value!.stories[index]
                                              .isWatched ||
                                          controller
                                              .user
                                              .value!
                                              .stories[
                                                  controller.storyIndex.value]
                                              .isWatched)
                                  ? Colors.grey
                                  : const Color.fromARGB(255, 200, 200, 200),
                              progressColor: Colors.grey,
                            )),
                      )),
              )),
            )),
        const SizedBox(height: 10.0),
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Obx(() => controller.isLoading.isTrue
                ? const Center(child: CircularProgressIndicator())
                : controller.user.value!.stories.length >
                            controller.storyIndex.value &&
                        controller.user.value!
                                .stories[controller.storyIndex.value].isVideo !=
                            null &&
                        controller.user.value!
                            .stories[controller.storyIndex.value].isVideo!
                    ? SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: VideoPlayer(controller.videoPlayerController))
                    : controller.user.value!.stories.length >
                                controller.storyIndex.value &&
                            (controller
                                        .user
                                        .value!
                                        .stories[controller.storyIndex.value]
                                        .isVideo ==
                                    null ||
                                controller
                                        .user
                                        .value!
                                        .stories[controller.storyIndex.value]
                                        .isVideo ==
                                    false)
                        ? Image.network(
                            controller.imageUrls[controller.storyIndex.value],
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.8,
                            fit: BoxFit.fitWidth,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Container();
                            },
                          )
                        : Container()),
            // Add any overlay widgets here if needed
          ],
        ),
      ],
    );
  }
}
