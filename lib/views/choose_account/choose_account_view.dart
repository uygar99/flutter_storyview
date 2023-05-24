import 'package:flutter/material.dart';
import 'package:flutter_storyview/widgets/custom_elevated_button.dart';
import 'package:flutter_storyview/widgets/top_bar.dart';
import 'package:get/get.dart';

import 'choose_account_controller.dart';

class ChooseAccountView extends GetView<ChooseAccountController> {
  const ChooseAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopBar(),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Column(children: [
              Obx(() => _accountListWidget(context)),
              //const Text("sa")
            ]))));
  }

  Widget _accountListWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: controller.users.map((user) {
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
                  trailing: CustomElevatedButton(
                      color: Colors.grey, text: "Choose Account", user: user)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
