import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy Policy")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          "We respect your privacy.\n\n"
          "Your data is stored securely and never shared with third parties.\n\n"
          "We only collect necessary information for app functionality.",
        ),
      ),
    );
  }
}