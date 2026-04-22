import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final IconData chooseIcon;
  final String title;
  final VoidCallback onTap;
  CustomTile({
    super.key,
    required this.chooseIcon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(chooseIcon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
    ;
  }
}
