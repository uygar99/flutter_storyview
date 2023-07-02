import 'package:flutter/material.dart';
import 'package:flutter_storyview/views/stories/story_show_controller.dart';
import 'package:get/get.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../widgets/custom_story_view.dart';

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
        itemBuilder: (context, index) {
          final user = controller.arranger()[index];
          final storyItems = [
            for (int i = 0; i < user.stories.length; i++)
              StoryItem.pageImage(
                imageFit: BoxFit.contain,
                url: user.stories[i].content,
                controller: controller.storyController2,
                duration: const Duration(seconds: 5),
              ),
          ];
          if (index == 0) {
            return GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx < 0) {
                  // Swiped left
                  controller.swipe(index, details);
                }
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
                child: _storyView(storyItems, user),
              ),
            );
          }

          return GestureDetector(
            onPanUpdate: (details) {
              controller.swipe(index, details);
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
                    child: _storyView(storyItems, user),
                  )
                : Container(),
          );
        },
      )
    ])));
  }

  Widget _storyView(storyItems, user) {
    return CustomStoryView(
      controller: controller.storyController2,
      storyItems: storyItems,
      onStoryShow: (s) {
        controller.onStoryShow(user);
      },
      onVerticalSwipeComplete: (direction) {
        controller.onVerticalSwipe(direction);
      },
      onComplete: () {
        //user.stories.last.isWatched = true;
        controller.onComplete(user);
      },
      //progressPosition: ProgressPosition.top,
      repeat: false,
      inline: true,
    );
  }
}
