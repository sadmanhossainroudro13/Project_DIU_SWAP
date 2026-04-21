import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController controller;
  final String str;
  final bool isHidden;
  final VoidCallback onToggle;
  const PasswordInput({
    super.key,
    required this.str,
    required this.controller,
    required this.isHidden,
    required this.onToggle
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isHidden,
      controller: controller,
      decoration: InputDecoration(
        hint: Text(str),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: isHidden? Icon(Icons.visibility_off): Icon(Icons.visibility),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
