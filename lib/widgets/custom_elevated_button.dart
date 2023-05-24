import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data_classes/store_logged_in.dart';
import '../data_classes/user.dart';
import '../routes/routes.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    //this.onPressedUser,
    this.text,
    this.color,
    this.user,
    super.key,
  });
  final Color? color;
  //final void Function()? onPressedUser;
  final String? text;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        CustomStorage.initialize(user!);
        Get.toNamed(Routes.home);
      },
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(color!),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      child: Text(text!),
    );
  }
}
