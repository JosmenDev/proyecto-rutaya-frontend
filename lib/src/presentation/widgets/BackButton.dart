import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Backbutton extends StatelessWidget {
  Color color;

  Backbutton({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back,
        color: color,
        size: 28.0,
      ),
    );
  }
}
