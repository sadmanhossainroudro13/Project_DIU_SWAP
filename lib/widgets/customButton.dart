import 'package:flutter/material.dart';


class Custombutton extends StatelessWidget {
  final VoidCallback buttonFunction;
  final Color bgColor;
  final Color textColor;
  final String buttonText;

  const Custombutton({
    required this.buttonText,
    required this.buttonFunction,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: buttonFunction,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          "$buttonText",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
