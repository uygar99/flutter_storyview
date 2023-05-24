import 'package:flutter/material.dart';

import '../data_classes/user.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    this.onPressed,
    this.text,
    this.color,
    super.key,
  });
  final Color? color;
  final void Function(User user)? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onPressed;
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
