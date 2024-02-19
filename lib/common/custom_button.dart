import 'package:cometchat_flutter_sample_app/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
  final String name;
  final VoidCallback onClick;

  const CustomBottom({required this.name, required this.onClick, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onClick,
        child: Text(
          name,
          style: const TextStyle(color: Colors.black),
        ),
        style: TextButton.styleFrom(
            backgroundColor: CustomColors.nextButtonColor,
            minimumSize: const Size(69, 28),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5))));
  }
}
