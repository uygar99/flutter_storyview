import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({this.showShadow = true, super.key});

  final bool showShadow;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        SizedBox(
          width: 32,
          child: IconButton(
            alignment: Alignment.centerLeft,
            onPressed: () {
              Get.back(closeOverlays: true);
            },
            color: Colors.grey,
            icon: const Icon(Icons.chevron_left),
          ),
        ),
        const Spacer(),
        Image.asset(
          'assets/logo/logo.png',
          fit: BoxFit.fill,
          width: 200,
          height: 70,
          //alignment: Alignment.center,
        ),
        const Spacer(),
        const SizedBox(width: 32)
      ],
    );
  }
}
