import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Defaultbutton extends StatelessWidget {
  Function() onPressed;
  Size size;
  Color color;
  String? direction;
  String text;

  Defaultbutton({
    required this.size,
    required this.onPressed,
    required this.color,
    this.direction,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.005),
      height: size.height * 0.06, // Ajusta la altura del botón
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: () {
          onPressed();
        },
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: size.height * 0.02,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
