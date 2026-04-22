import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Terms & Conditions")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          "By using this app, you agree to our terms.\n\n"
          "- No illegal items\n"
          "- No spam posts\n"
          "- Respect other users\n\n"
          "Violation may result in account suspension.",
        ),
      ),
    );
  }
}
