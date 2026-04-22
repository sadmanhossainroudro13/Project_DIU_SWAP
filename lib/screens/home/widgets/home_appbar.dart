import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          children: [
            Image.asset("assets/images/just_logo.png", height: 45),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
              child: const Text(
                "DIU Swap",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black87,
    );
  }
}
