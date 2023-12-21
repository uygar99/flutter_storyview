import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../data_classes/user.dart';
import '../../routes/routes.dart';

class StoryDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controller;
  RxDouble angle = 0.0.obs;
  var storyController = PageController();
  late List<User> followingUsers = [];
  RxBool release = false.obs;
  int userIndex = 0;
  RxInt storyIndex = 0.obs;
  Rxn<User> user = Rxn<User>();
  var cubeController = PageController();
  RxBool isPageChanged = true.obs;
  RxList<dynamic> imageUrls = <dynamic>[].obs;
  //RxList<dynamic> isVideo = <dynamic>[].obs;
  Timer? timer;
  RxInt start = 500.obs;
  bool duration = false;
  Duration oneSec = const Duration(milliseconds: 10);
  RxBool isLoading = true.obs;
  RxInt wholeStoryTime = 500.obs;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  //RxList<Story> stories = <Story>[].obs;

  @override
  void onInit() async {
    await takeArgs();
    await loadData();
    await firstNonWatched();
    super.onInit();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
    );
  }

  @override
  void dispose() {
    //videoPlayerController.dispose();
    //chewieController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    timer!.cancel();
    //videoPlayerController

    super.onClose();
  }

  Future<void> takeArgs() async {
    var args = Get.arguments;
    followingUsers = args[0];
    userIndex = args[1];
    print(userIndex);
  }

  void onStoryShow(user) async {
    if (storyIndex.value < user.stories.length) {
      for (int i = 0; i <= storyIndex.value; i++) {
        user.stories[storyIndex.value].isWatched = true;
      }
    }
    await initializeVideoController();
  }

  Future<void> onTapUp(details, BuildContext context) async {
    start.value = 500;
    double tapPosition = details.globalPosition.dx;

    // Get the width of the screen
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate the center of the screen
    double screenCenter = screenWidth / 2;

    if (tapPosition > screenCenter) {
      if (storyIndex.value < imageUrls.length - 1) {
        storyIndex.value++;
        onStoryShow(user.value);
      } else {
        onStoryShow(user.value);
        onComplete(user.value, true);
      }
    } else {
      if (storyIndex.value > 0) {
        storyIndex.value--;
        onStoryShow(user.value);
      } else {
        onStoryShow(user.value);
        onComplete(user.value, false);
      }
    }
  }

  Future<void> onPageChange() async {
    //
    start.value = 500;
    imageUrls.value =
        user.value!.stories.map((userStory) => userStory.content).toList();
    storyIndex.value = 0;
    firstNonWatched();
    onStoryShow(user.value);
    //initializeVideoController();
  }

  Future<void> vertical() async {
    user.value!.stories[storyIndex.value].isWatched = true;
  }

  void onVerticalSwipe() async {
    //user.stories.last.isWatched = true;
    await vertical();
    storyIndex.value = 0;
    Get.offAllNamed(Routes.stories, arguments: followingUsers);
  }

  Future<void> initializeVideoController() async {
    isLoading.value = true;
    if (user.value!.stories[storyIndex.value].isVideo != null &&
        user.value!.stories[storyIndex.value].isVideo!) {
      wholeStoryTime.value = user.value!.stories[storyIndex.value].duration!;
      videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(user.value!.stories[storyIndex.value].content))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized
          update();
        });
      videoPlayerController.play();

      if (user.value!.stories[storyIndex.value].isVideo != null &&
          user.value!.stories[storyIndex.value].isVideo!) {
        start.value = user.value!.stories[storyIndex.value].duration!;
      }
    } else {
      wholeStoryTime.value = 500;
    }
    isLoading.value = false;
  }

  void onComplete(user, isNext) async {
    storyIndex.value = 0;
    firstNonWatched();
    //await initializeVideoController();
    if (isNext == true) {
      //print("nextPage");
      //user.stories.last.isWatched = true;
      cubeController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
    } else {
      //print("previousPage");
      cubeController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }

    //user.stories.last.isWatched = true;
    if (user.id == arranger().last.id && isNext == true) {
      Get.offAllNamed(Routes.stories, arguments: followingUsers);
    }
    /*imageUrls.value =
        user.stories.map((userStory) => userStory.content).toList();*/
    //print("image url lengthi" + imageUrls.length.toString());
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
    storyIndex.value = 0;
    if (index == cubeController.page?.toInt()) {
      if (details.delta.dx > 0) {
        // Swiped right
        onComplete(user.value, false);
      } else if (details.delta.dx < 0) {
        // Swiped left
        onComplete(user.value, true);
      }
    }
  }

  List<User> arranger() {
    List<User> followingUsersTemp = [];
    for (var i = userIndex; i < followingUsers.length; i++) {
      followingUsersTemp.add(followingUsers[i]);
    }
    for (var i = 0; i < userIndex; i++) {
      followingUsersTemp.add(followingUsers[i]);
    }
    firstNonWatched();
    return followingUsersTemp; //tıklanan kişiden solundaki dahil olacak şekilde following usersı dönüyor
  }

  Future<void> firstNonWatched() async {
    if (user.value != null) {
      for (int i = 0; i < user.value!.stories.length; i++) {
        if (user.value!.stories[i].isWatched!) {
          storyIndex.value++;
        }
      }
      if (storyIndex.value >= user.value!.stories.length) {
        storyIndex.value = user.value!.stories.length - 1;
      }
      //release.value = true;
      print("story index: " + storyIndex.value.toString());
    }
  }

  Future<void> loadData() async {
    //print("load dataya geldi");
    /*isVideo.value =
        user.value!.stories.map((userStory) => userStory.isVideo).toList();*/
    await initializeVideoController();
    imageUrls.value =
        user.value!.stories.map((userStory) => userStory.content).toList();
    //print("image url lengthi" + imageUrls.length.toString());
    startTimer();
    /*videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(imageUrls.value[storyIndex.value]));
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9, // Adjust as needed
      autoPlay: true,
      looping: true,
    );*/

    isLoading.value = false;
  }

  void startTimer() {
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          start.value = 500;

          tickJob();
        } else {
          //print(start.value);
          //print(wholeStoryTime.value);
          //print(start.value);
          duration == false ? start.value-- : null;
        }
      },
    );
  }

  void tickJob() {
    //print("tickJob" + user.value!.name);
    storyIndex.value = (storyIndex.value + 1);
    if (storyIndex.value >= imageUrls.length) {
      storyIndex.value = 0;
      onComplete(user.value, true);
      //Get.back();
    } else {
      onStoryShow(user.value);
    }
  }

  // Function to pause the timer
  void pauseTimer() {
    if (user.value!.stories[storyIndex.value].isVideo != null &&
        user.value!.stories[storyIndex.value].isVideo!) {
      videoPlayerController.pause();
    }
    duration = true;
    //print("Pause geldi");
  }

  // Function to resume the timer
  void resumeTimer() {
    if (user.value!.stories[storyIndex.value].isVideo != null &&
        user.value!.stories[storyIndex.value].isVideo!) {
      videoPlayerController.play();
    }
    duration = false;
    //print("Resume geldi");
  }
}
