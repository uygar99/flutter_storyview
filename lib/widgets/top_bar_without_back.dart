import 'package:flutter/material.dart';

class TopBarWithoutBack extends StatelessWidget implements PreferredSizeWidget {
  const TopBarWithoutBack({this.showShadow = true, super.key});

  final bool showShadow;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
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
