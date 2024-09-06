import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DefaultInput extends StatelessWidget {
  Function(String text) onChanged;
  String? Function(String?)? validator;
  Size size;
  Color color;
  String text;
  TextInputType type;
  bool obscureText;

  DefaultInput({
    required this.onChanged,
    this.validator,
    required this.size,
    required this.color,
    required this.text,
    required this.type,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: size.height * 0.04),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(30.0)),
      child: TextFormField(
        onChanged: (text) {
          onChanged(text);
        },
        validator: validator,
        keyboardType: type,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: text,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            )),
      ),
    );
  }
}
