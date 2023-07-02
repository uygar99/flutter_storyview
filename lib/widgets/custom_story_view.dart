import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';

class CustomStoryView extends StatelessWidget {
  final StoryController controller;
  final List<StoryItem> storyItems;
  final Function(StoryItem) onStoryShow;
  final Function(Direction?) onVerticalSwipeComplete;
  final Function() onComplete;
  final bool repeat;
  final bool inline;

  const CustomStoryView({
    super.key,
    required this.controller,
    required this.storyItems,
    required this.onStoryShow,
    required this.onVerticalSwipeComplete,
    required this.onComplete,
    this.repeat = false,
    this.inline = true,
  });

  @override
  Widget build(BuildContext context) {
    return StoryView(
      controller: controller,
      storyItems: storyItems,
      onStoryShow: onStoryShow,
      onVerticalSwipeComplete: onVerticalSwipeComplete,
      onComplete: onComplete,
      repeat: repeat,
      inline: inline,
    );
  }
}
