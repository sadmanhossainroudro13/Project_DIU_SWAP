import 'package:flutter/material.dart';
import '../../../widgets/bold_text.dart';

class LatestlistingSeeall extends StatelessWidget {
  final String str;
  const LatestlistingSeeall({super.key, required this.str});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BoldText(str: str, fontSize: 22),
        TextButton(
          onPressed: () {},
          child: Center(
            child: Text("See all", style: TextStyle(color: Colors.green)),
          ),
        ),
      ],
    );
  }
}
