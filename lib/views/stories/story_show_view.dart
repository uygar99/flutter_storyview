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
    return Scaffold(
        body: SafeArea(
            child: Stack(children: <Widget>[
      /*FutureBuilder(
        future: Future.value(true),
        builder: (BuildContext context, AsyncSnapshot<void> snap) {
          //If we do not have data as we wait for the future to complete,
          //show any widget, eg. empty Container
          if (!snap.hasData) {
            return Container();
          }

          //Otherwise the future completed, so we can now safely use the controller.page
          return Text(controller.cubeController.position.hasContentDimensions
              .toString());
        },
      ),*/
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
                controller: controller.storyController,
                duration: const Duration(seconds: 5),
              ),
          ];
          if (index == 0) {
            return GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx < 0) {
                  // Swiped left
                  controller.cubeController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOutCubic,
                  );
                }
              },
              child: AnimatedBuilder(
                animation: controller.cubeController,
                builder: (context, child) {
                  final transform = Matrix4.identity();
                  transform.setEntry(3, 2, 0.001);
                  var angle = 0.0 - index.toDouble();
                  if (controller.cubeController.position.haveDimensions) {
                    angle = controller.cubeController.page!;
                  }
                  transform.rotateY(-angle * -0.5 * 3.14);

                  return Transform(
                    transform: transform,
                    alignment: Alignment.centerRight,
                    child: child,
                  );
                },
                child: _StoryView(storyItems, user),
              ),
            );
          }

          return GestureDetector(
            onPanUpdate: (details) {
              if (index == controller.cubeController.page?.toInt()) {
                if (details.delta.dx > 0) {
                  // Swiped right
                  controller.cubeController.previousPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOutCubic,
                  );
                } else if (details.delta.dx < 0) {
                  // Swiped left
                  controller.cubeController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOutCubic,
                  );
                }
              }
            },
            child: controller.cubeController.position.haveDimensions
                ? AnimatedBuilder(
                    animation: controller.cubeController,
                    builder: (context, child) {
                      final transform = Matrix4.identity();
                      transform.setEntry(3, 2, 0.001);

                      if (index == controller.cubeController.page?.toInt()) {
                        final angle = controller.cubeController.page! - index;
                        transform.rotateY(-angle * -0.5 * 3.14);
                      }

                      if (index ==
                          controller.cubeController.page!.toInt() + 1) {
                        final angle = controller.cubeController.page! - index;
                        transform.rotateY(-angle * -0.5 * 3.14);
                      }

                      return Transform(
                        transform: transform,
                        alignment:
                            index == controller.cubeController.page?.toInt()
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: child,
                      );
                    },
                    child: _StoryView(storyItems, user),
                  )
                : Container(),
          );
        },
      )
    ])));
  }

  Widget _StoryView(storyItems, user) {
    return StoryView(
      controller: controller.storyController,
      storyItems: storyItems,
      onStoryShow: (s) {
        if (controller.storyIndex.value >= user.stories.length) {
          controller.storyIndex.value = user.stories.length - 1;
        }
        user.stories[controller.storyIndex.value].isWatched = true;

        if (user.stories.length - 1 > controller.storyIndex.value) {
          controller.storyIndex.value++;
        }
      },
      onVerticalSwipeComplete: (direction) {
        if (direction == Direction.down) {
          //user.stories.last.isWatched = true;
          controller.storyIndex.value = 0;
          Get.offAllNamed(Routes.stories, arguments: controller.followingUsers);
        }
      },
      onComplete: () {
        //user.stories.last.isWatched = true;
        controller.storyIndex.value = 0;
        controller.cubeController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.linear);

        controller.followingUsers[controller.index].stories.last.isWatched =
            true;
        if (user.id == controller.followingUsers[controller.indexTemp - 1].id) {
          Get.offAllNamed(Routes.stories, arguments: controller.followingUsers);
        }
      },
      progressPosition: ProgressPosition.top,
      repeat: false,
      inline: true,
    );
  }
}
