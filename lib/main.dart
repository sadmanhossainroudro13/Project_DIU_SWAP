import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_diu_swap/login_screen.dart';
import 'package:project_diu_swap/screens/main_screen.dart';
import 'package:project_diu_swap/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SignupScreen());
  }
}
