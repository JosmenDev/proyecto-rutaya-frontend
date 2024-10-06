import 'package:flutter/material.dart';
import 'package:indriver_clone_flutter/src/presentation/colors/colors.dart';

class DefaultIconBack extends StatelessWidget {
  final Color color;
  final EdgeInsetsGeometry? margin;

  DefaultIconBack({
    this.color = Colors.white,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: margin,
      decoration: BoxDecoration(
        color: celeste, // Fondo celeste
        shape: BoxShape.circle, // Forma circular
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          size: 25, // Ajusta el tamaño si es necesario
          color: color,
        ),
      ),
    );
  }
}
