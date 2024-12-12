import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  const ButtonText(
      {super.key, required this.text, required this.fontSize, required this.textColor});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: textColor, fontSize: fontSize),
    );
  }
}
