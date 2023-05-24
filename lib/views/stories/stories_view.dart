import 'package:flutter/material.dart';
import 'package:flutter_storyview/views/stories/stories_controller.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../widgets/bottom_navbar.dart';
import '../../widgets/top_bar.dart';

class StoriesView extends GetView<StoriesController> {
  const StoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      bottomNavigationBar: const BottomNavbar(index: 0, selected: false),
      body: Column(
        children: [
          SizedBox(
            height: 120.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.followingUsers.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Obx(() => InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.storyDetail, arguments: [
                                    controller.followingUsers,
                                    controller.followingUsers[index].stories,
                                    index
                                  ]);
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 75.0,
                                      height: 75.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: controller.followingUsers[index]
                                                .stories.last.isWatched
                                            ? Colors.grey
                                            : Colors.green,
                                      ),
                                    ),
                                    Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            "assets/profile_pictures/${controller.followingUsers[index].pp}",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),

                          const SizedBox(height: 8.0),
                          //Text(controller.users.stories[index].username),
                        ],
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
