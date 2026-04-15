import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 18),
        child: Image.asset("assets/images/logo.png", height: 120),
      ),
      backgroundColor: Colors.black87,

      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
