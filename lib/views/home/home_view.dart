import 'package:flutter/material.dart';
import 'package:flutter_storyview/widgets/top_bar.dart';
import 'package:get/get.dart';

import '../../data_classes/user.dart';
import '../../widgets/bottom_navbar.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopBar(),
        bottomNavigationBar: const BottomNavbar(index: 0, selected: true),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Obx(() => Column(children: [
                      _chooseFollowerOrNot(context),
                      controller.followerOrExplore.value
                          ? _accountListWidget(
                              context,
                              controller.followingUsers,
                            )
                          : _accountListWidget(
                              context,
                              controller.nonFollowingUsers,
                            ),
                      Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: OutlinedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    controller.storiesNavigator();
                                  },
                                  child: const Text(
                                    "Stories",
                                    style: TextStyle(color: Colors.black),
                                  ))))
                      //const Text("sa")
                    ])))));
  }

  /*Widget _watchStories(List users) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: <Widget>[
          ListView(
              children: users.map((user) {
            return CircleAvatar(
              backgroundImage: AssetImage("assets/profile_pictures/${user.pp}"),
            );
          }).toList())
        ]));
  }*/

  Widget _trailingButton(User user) {
    return OutlinedButton(
      onPressed: () {
        controller.followOrUnfollow(user);
      },
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
            controller.followerOrExplore.value ? Colors.green : Colors.grey),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      child: Text(controller.followerOrExplore.value ? "Unfollow" : "Follow"),
    );
  }

  Widget _chooseFollowerOrNot(BuildContext context) {
    const List<Widget> choices = <Widget>[
      Text('Followers'),
      Text('Explore'),
    ];
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        controller.toggleController(index);
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: Colors.grey[700],
      selectedColor: Colors.white,
      fillColor: Colors.black,
      color: Colors.grey[600],
      constraints: const BoxConstraints(
        minHeight: 25.0,
        minWidth: 120.0,
      ),
      isSelected: controller.selectedFollowers,
      children: choices,
    );
  }

  Widget _accountListWidget(BuildContext context, List users) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: users.map((user) {
            return Card(
                //margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                    title: Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/profile_pictures/${user.pp}"),
                    ),
                    trailing: _trailingButton(user)));
          }).toList(),
        ),
      ),
    );
  }
}
