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
          style: const TextStyle(color: Colors.white),
        ),
        style: TextButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: const Size(40, 30),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5))));
  }
}
