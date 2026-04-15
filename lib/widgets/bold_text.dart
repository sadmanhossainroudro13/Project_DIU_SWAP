import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final double fontSize;
  final String str;
  final Color color;
  final double bottom;
  const BoldText({
    Key? key,
    required this.str,
    this.fontSize = 20,
    this.color = Colors.black,
    this.bottom = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Text(
        '$str',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: color,
        ),
      ),
    );
  }
}
